#!/usr/bin/env bash
set -euo pipefail

target_root=""
source_agent_root=""
repo_url=""
version="latest"
allow_downgrade=0
yes=0
remote_temp_root=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --target-root) target_root="$2"; shift 2 ;;
    --source-agent-root) source_agent_root="$2"; shift 2 ;;
    --repo-url) repo_url="$2"; shift 2 ;;
    --version) version="$2"; shift 2 ;;
    --allow-downgrade) allow_downgrade=1; shift ;;
    --yes) yes=1; shift ;;
    -h|--help)
      echo "Usage: update-agent.sh [--target-root PATH] [--source-agent-root PATH|--repo-url URL] [--version latest|vX.Y.Z] [--allow-downgrade] --yes"
      exit 0
      ;;
    *) echo "Bilinmeyen parametre: $1" >&2; exit 1 ;;
  esac
done

fail() { echo "HATA: $*" >&2; exit 1; }
need_command() { command -v "$1" >/dev/null 2>&1 || fail "$1 bulunamadi."; }

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

find_target_root() {
  if [[ -n "$target_root" ]]; then
    (cd "$target_root" && pwd -P)
    return
  fi
  local current="$script_dir"
  while [[ "$current" != "/" ]]; do
    if [[ "$(basename "$current")" == "agent" && "$(basename "$(dirname "$current")")" == ".pa" ]]; then
      (cd "$(dirname "$(dirname "$current")")" && pwd -P)
      return
    fi
    current="$(dirname "$current")"
  done
  fail "TargetRoot bulunamadi. --target-root parametresi ver."
}

read_json_field() {
  python3 - "$1" "$2" <<'PY'
import json, sys
with open(sys.argv[1], "r", encoding="utf-8") as f:
    data = json.load(f)
value = data
for part in sys.argv[2].split("."):
    value = value.get(part) if isinstance(value, dict) else None
print("" if value is None else value)
PY
}

assert_workspace_identity() {
  python3 - "$1" "$2" <<'PY'
import json, re, sys
document = open(sys.argv[1], "r", encoding="utf-8").read()
state = json.load(open(sys.argv[2], "r", encoding="utf-8"))
for field in ("project_id", "idea_id"):
    state_value = str(state.get(field) or "").strip()
    if not state_value:
        raise SystemExit(f"Project workspace state.json icinde {field} bos olamaz.")
    match = re.search(rf"(?m)^\s*{re.escape(field)}\s*:\s*([^\r\n#]+)", document)
    if not match:
        raise SystemExit(f"Project workspace kimlik dosyasinda {field} bulunamadi.")
    if match.group(1).strip() != state_value:
        raise SystemExit(f"Project workspace {field} uyusmazligi: kimlik dosyasi ile state.json ayni olmali.")
PY
}

assert_valid_target_workspace() {
  local root="$1"
  [[ ! -e "$root/DEGERLENDIRME.md" && ! -e "$root/.pa/evaluation" ]] || fail "Ayrik evaluation workspace modeli kaldirildi. Hedef tek tip proje workspace'i olmali."
  [[ -f "$root/PROJE.md" && -f "$root/.pa/project/state.json" ]] || fail "Hedef gecerli PersonalAutonomy proje workspace'i olmali: PROJE.md + .pa/project/state.json."
  assert_workspace_identity "$root/PROJE.md" "$root/.pa/project/state.json" || fail "Hedef workspace dogrulanamadi."
}

semver_compare() {
  python3 - "$1" "$2" <<'PY'
import re, sys
def parts(v):
    m = re.fullmatch(r"v(\d+)\.(\d+)\.(\d+)", v)
    if not m:
        raise SystemExit(f"Gecersiz surum: {v}")
    return tuple(map(int, m.groups()))
l, r = parts(sys.argv[1]), parts(sys.argv[2])
print(-1 if l < r else 1 if l > r else 0)
PY
}

latest_git_tag() {
  local remote="$1"
  need_command git
  git ls-remote --tags --refs "$remote" "v*" | python3 - <<'PY'
import re, sys
versions = []
for line in sys.stdin:
    m = re.search(r"refs/tags/(v(\d+)\.(\d+)\.(\d+))$", line)
    if m:
        versions.append((tuple(map(int, m.groups()[1:])), m.group(1)))
if versions:
    print(sorted(versions)[-1][1])
PY
}

resolve_remote_agent_root() {
  local remote="$1"
  local requested_version="$2"
  need_command git
  local clone_version="$requested_version"
  if [[ "$clone_version" == "latest" ]]; then
    local latest
    latest="$(latest_git_tag "$remote" || true)"
    if [[ -n "$latest" ]]; then clone_version="$latest"; fi
  fi
  remote_temp_root="$(mktemp -d "${TMPDIR:-/tmp}/pa-agent-update-source.XXXXXX")"
  if [[ "$clone_version" == "latest" ]]; then
    git clone --depth 1 "$remote" "$remote_temp_root" >/dev/null
  else
    git clone --depth 1 --branch "$clone_version" "$remote" "$remote_temp_root" >/dev/null
  fi
  [[ -d "$remote_temp_root/marketing-agent" ]] || fail "Repo icinde marketing-agent klasoru bulunamadi: $remote"
  printf '%s\n' "$remote_temp_root/marketing-agent"
}

cleanup_remote() {
  if [[ -n "$remote_temp_root" && -d "$remote_temp_root" ]]; then rm -rf "$remote_temp_root"; fi
}
trap cleanup_remote EXIT

test_manifest() {
  local agent_root="$1"
  [[ -f "$agent_root/release-manifest.json" ]] || fail "release-manifest.json bulunamadi: $agent_root/release-manifest.json"
  python3 - "$agent_root" <<'PY'
import hashlib, json, pathlib, sys
root = pathlib.Path(sys.argv[1])
manifest = json.load(open(root / "release-manifest.json", "r", encoding="utf-8"))
for item in manifest.get("files", []):
    rel = item["path"]
    path = root / rel
    if not path.is_file():
        raise SystemExit(f"Manifest dosyasi eksik: {rel}")
    if hashlib.sha256(path.read_bytes()).hexdigest() != item["sha256"]:
        raise SystemExit(f"Manifest hash uyusmazligi: {rel}")
PY
}

copy_agent_to_staging() {
  local source="$1"
  local staging="$2"
  test_manifest "$source"
  mkdir -p "$staging"
  python3 - "$source" "$staging" <<'PY'
import json, pathlib, shutil, sys
source = pathlib.Path(sys.argv[1])
staging = pathlib.Path(sys.argv[2])
manifest = json.load(open(source / "release-manifest.json", "r", encoding="utf-8"))
for item in manifest["files"]:
    rel = pathlib.PurePosixPath(item["path"])
    src = source.joinpath(*rel.parts)
    dst = staging.joinpath(*rel.parts)
    dst.parent.mkdir(parents=True, exist_ok=True)
    shutil.copy2(src, dst)
shutil.copy2(source / "release-manifest.json", staging / "release-manifest.json")
PY
  test_manifest "$staging"
}

write_install_metadata() {
  python3 - "$1" "$2" "$3" "$4" "$5" "$6" <<'PY'
import json, pathlib, sys
from datetime import datetime, timezone
root, metadata_path, installed_version, repo_url, source_agent_root, requested_version = sys.argv[1:7]
path = pathlib.Path(metadata_path)
existing = {}
if path.exists():
    existing = json.loads(path.read_text(encoding="utf-8"))
metadata = {
    "schema_version": "1.0",
    "repo_url": repo_url,
    "source_agent_root": source_agent_root,
    "channel": existing.get("channel", "stable"),
    "requested_version": requested_version,
    "installed_version": installed_version,
    "update_policy": existing.get("update_policy", "ask"),
    "installed_at": existing.get("installed_at"),
    "updated_at": datetime.now(timezone.utc).isoformat(),
    "installer": "scripts/update-agent.sh",
}
path.write_text(json.dumps(metadata, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
PY
}

need_command python3
root="$(find_target_root)"
assert_valid_target_workspace "$root"

metadata_path="$root/.pa/agent-install.json"
if [[ -z "$repo_url" && -f "$metadata_path" ]]; then
  repo_url="$(read_json_field "$metadata_path" "repo_url")"
fi

if [[ "$yes" -ne 1 ]]; then
  echo "Guncelleme onay gerektirir. Kullanici onayindan sonra --yes ile tekrar calistir."
  exit 2
fi

if [[ -n "$source_agent_root" ]]; then
  source_agent_full="$(cd "$source_agent_root" && pwd -P)"
elif [[ -n "$repo_url" ]]; then
  source_agent_full="$(resolve_remote_agent_root "$repo_url" "$version")"
else
  fail "Guncelleme kaynagi bulunamadi. .pa/agent-install.json icinde repo_url olmali veya --source-agent-root verilmeli."
fi

destination_agent="$root/.pa/agent"
current_version_path="$destination_agent/agent-version.json"
[[ -f "$current_version_path" ]] || fail "Kurulu agent-version.json bulunamadi: $current_version_path"

current_version="$(read_json_field "$current_version_path" "version")"
source_version="$(read_json_field "$source_agent_full/agent-version.json" "version")"
comparison="$(semver_compare "$current_version" "$source_version")"

if [[ "$comparison" -eq 0 ]]; then
  echo "SONUC: Agent zaten guncel ($current_version)."
  exit 0
fi
if [[ "$comparison" -gt 0 && "$allow_downgrade" -ne 1 ]]; then
  echo "SONUC: Kurulu agent daha yeni ($current_version > $source_version). Downgrade icin --allow-downgrade gerekir."
  exit 0
fi

parent="$(dirname "$destination_agent")"
stamp="$(date +%Y%m%d-%H%M%S)"
staging="$parent/agent.updating-$stamp"
backup="$parent/agent.backup-$stamp"
rm -rf "$staging"

copy_agent_to_staging "$source_agent_full" "$staging"
mv "$destination_agent" "$backup"
if ! mv "$staging" "$destination_agent"; then
  rm -rf "$staging"
  if [[ -d "$backup" && ! -d "$destination_agent" ]]; then mv "$backup" "$destination_agent"; fi
  fail "Agent guncelleme paketi hedefe tasinamadi."
fi
test_manifest "$destination_agent"
rm -rf "$backup"
write_install_metadata "$root" "$metadata_path" "$source_version" "$repo_url" "$source_agent_root" "$version"

echo "SONUC: Marketing Agent guncellendi."
echo "Hedef workspace: $root"
echo "Eski surum: $current_version"
echo "Yeni surum: $source_version"
echo "Korunan alanlar: proje dosyalari ve .pa/project"
