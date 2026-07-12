#!/usr/bin/env bash
set -euo pipefail

target_root="$(pwd)"
source_agent_root=""
repo_url=""
version="latest"
update_policy="ask"
force_bootstrap=0
remote_temp_root=""

usage() {
  cat <<'USAGE'
Usage: install-marketing-agent.sh [options]

Options:
  --target-root PATH         Target PersonalAutonomy project workspace. Defaults to current directory.
  --source-agent-root PATH   Local marketing-agent package source.
  --repo-url URL             Git repository URL containing marketing-agent/.
  --version VERSION          latest or vMAJOR.MINOR.PATCH. Defaults to latest.
  --update-policy POLICY     ask or manual. Defaults to ask.
  --force-bootstrap          Replace non-PersonalAutonomy AGENTS.md after backup.
USAGE
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --target-root) target_root="$2"; shift 2 ;;
    --source-agent-root) source_agent_root="$2"; shift 2 ;;
    --repo-url) repo_url="$2"; shift 2 ;;
    --version) version="$2"; shift 2 ;;
    --update-policy) update_policy="$2"; shift 2 ;;
    --force-bootstrap) force_bootstrap=1; shift ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Bilinmeyen parametre: $1" >&2; usage; exit 1 ;;
  esac
done

fail() {
  echo "HATA: $*" >&2
  exit 1
}

need_command() {
  command -v "$1" >/dev/null 2>&1 || fail "$1 bulunamadi."
}

abs_dir() {
  [[ -d "$1" ]] || fail "$2 klasor olmali: $1"
  (cd "$1" && pwd -P)
}

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
repo_root="$(cd "$script_dir/.." && pwd -P)"
target_root="$(abs_dir "$target_root" "TargetRoot")"

case "$version" in
  latest|v[0-9]*.[0-9]*.[0-9]*) ;;
  *) fail "Version latest veya vMAJOR.MINOR.PATCH biciminde olmali." ;;
esac
[[ "$update_policy" == "ask" || "$update_policy" == "manual" ]] || fail "UpdatePolicy ask veya manual olmali."

read_json_field() {
  local path="$1"
  local field="$2"
  python3 - "$path" "$field" <<'PY'
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
  local document_path="$1"
  local state_path="$2"
  python3 - "$document_path" "$state_path" <<'PY'
import json, re, sys
document_path, state_path = sys.argv[1:3]
document = open(document_path, "r", encoding="utf-8").read()
state = json.load(open(state_path, "r", encoding="utf-8"))
for field in ("project_id", "idea_id"):
    state_value = str(state.get(field) or "").strip()
    if not state_value:
        raise SystemExit(f"Project workspace state.json icinde {field} bos olamaz.")
    match = re.search(rf"(?m)^\s*{re.escape(field)}\s*:\s*([^\r\n#]+)", document)
    if not match:
        raise SystemExit(f"Project workspace kimlik dosyasinda {field} bulunamadi: {document_path}")
    if match.group(1).strip() != state_value:
        raise SystemExit(f"Project workspace {field} uyusmazligi: kimlik dosyasi ile state.json ayni olmali.")
PY
}

assert_valid_target_workspace() {
  local project_document="$target_root/PROJE.md"
  local project_state="$target_root/.pa/project/state.json"
  if [[ -e "$target_root/DEGERLENDIRME.md" || -e "$target_root/.pa/evaluation" ]]; then
    fail "Ayrik evaluation workspace modeli kaldirildi. Hedef tek tip proje workspace'i olmali."
  fi
  if [[ -e "$project_document" && ! -e "$project_state" ]] || [[ ! -e "$project_document" && -e "$project_state" ]]; then
    fail "Project workspace eksik: PROJE.md ve .pa/project/state.json birlikte bulunmali."
  fi
  [[ -e "$project_document" && -e "$project_state" ]] || fail "Hedef gecerli PersonalAutonomy proje workspace'i olmali: PROJE.md + .pa/project/state.json."
  assert_workspace_identity "$project_document" "$project_state" || fail "Hedef workspace dogrulanamadi."
}

latest_git_tag() {
  local remote="$1"
  need_command git
  git ls-remote --tags --refs "$remote" "v*" | python3 - <<'PY'
import re, sys
versions = []
for line in sys.stdin:
    match = re.search(r"refs/tags/(v(\d+)\.(\d+)\.(\d+))$", line)
    if match:
        versions.append((tuple(map(int, match.groups()[1:])), match.group(1)))
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
    if [[ -n "$latest" ]]; then
      clone_version="$latest"
    fi
  fi
  remote_temp_root="$(mktemp -d "${TMPDIR:-/tmp}/pa-agent-source.XXXXXX")"
  if [[ "$clone_version" == "latest" ]]; then
    git -c core.autocrlf=false clone --depth 1 "$remote" "$remote_temp_root" >/dev/null
  else
    git -c core.autocrlf=false clone --depth 1 --branch "$clone_version" "$remote" "$remote_temp_root" >/dev/null
  fi
  [[ -d "$remote_temp_root/marketing-agent" ]] || fail "Repo icinde marketing-agent klasoru bulunamadi: $remote"
  printf '%s\n' "$remote_temp_root/marketing-agent"
}

cleanup_remote() {
  if [[ -n "$remote_temp_root" && -d "$remote_temp_root" ]]; then
    rm -rf "$remote_temp_root"
  fi
}
trap cleanup_remote EXIT

file_sha256() {
  if command -v sha256sum >/dev/null 2>&1; then
    sha256sum "$1" | awk '{print tolower($1)}'
  else
    shasum -a 256 "$1" | awk '{print tolower($1)}'
  fi
}

test_manifest() {
  local agent_root="$1"
  local manifest_path="$agent_root/release-manifest.json"
  [[ -f "$manifest_path" ]] || fail "release-manifest.json bulunamadi: $manifest_path"
  python3 - "$agent_root" "$manifest_path" <<'PY'
import hashlib, json, pathlib, sys
root = pathlib.Path(sys.argv[1])
manifest = json.load(open(sys.argv[2], "r", encoding="utf-8"))
for item in manifest.get("files", []):
    rel = item["path"]
    path = root / rel
    if not path.is_file():
        raise SystemExit(f"Manifest dosyasi eksik: {rel}")
    actual = hashlib.sha256(path.read_bytes()).hexdigest()
    if actual != item["sha256"]:
        raise SystemExit(f"Manifest hash uyusmazligi: {rel}")
print(len(manifest.get("files", [])))
PY
}

copy_agent_package() {
  local source="$1"
  local destination="$2"
  local parent stamp staging backup
  parent="$(dirname "$destination")"
  mkdir -p "$parent"
  stamp="$(date +%Y%m%d-%H%M%S)"
  staging="$parent/agent.installing-$stamp"
  backup="$parent/agent.backup-$stamp"
  test_manifest "$source" >/dev/null
  rm -rf "$staging"
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
  test_manifest "$staging" >/dev/null
  if [[ -d "$destination" ]]; then
    mv "$destination" "$backup"
  fi
  if ! mv "$staging" "$destination"; then
    rm -rf "$staging"
    if [[ -d "$backup" && ! -d "$destination" ]]; then mv "$backup" "$destination"; fi
    fail "Agent paketi hedefe tasinamadi."
  fi
  test_manifest "$destination" >/dev/null
  rm -rf "$backup"
}

install_bootstrap() {
  local template_path="$1"
  local target="$target_root/AGENTS.md"
  [[ -f "$template_path" ]] || fail "Bootstrap sablonu eksik: templates/workspace-bootstrap-AGENTS.md"
  if [[ ! -e "$target" ]]; then
    cp "$template_path" "$target"
    echo "created"
    return
  fi
  if grep -q 'PA_BOOTSTRAP_VERSION:[[:space:]]*1' "$target"; then
    if ! cmp -s "$template_path" "$target"; then
      cp "$template_path" "$target"
      echo "updated"
    else
      echo "unchanged"
    fi
    return
  fi
  [[ "$force_bootstrap" -eq 1 ]] || fail "Hedef AGENTS.md mevcut ama PersonalAutonomy bootstrap degil. Uzerine yazmak icin --force-bootstrap kullan."
  local backup="$target_root/AGENTS.md.pre-pa-install-$(date +%Y%m%d-%H%M%S).bak"
  cp "$target" "$backup"
  cp "$template_path" "$target"
  echo "replaced-with-backup:$backup"
}

write_install_metadata() {
  local installed_version="$1"
  local metadata_source_agent_root=""
  if [[ -n "$source_agent_root" && -z "$repo_url" ]]; then
    metadata_source_agent_root="$source_agent_root"
  fi
  python3 - "$target_root/.pa/agent-install.json" "$repo_url" "$metadata_source_agent_root" "$installed_version" "$update_policy" "$version" <<'PY'
import json, pathlib, sys
from datetime import datetime, timezone
path, repo_url, source_agent_root, installed_version, update_policy, requested_version = sys.argv[1:7]
metadata = {
    "schema_version": "1.0",
    "repo_url": repo_url,
    "source_agent_root": source_agent_root,
    "channel": "stable",
    "requested_version": requested_version,
    "installed_version": installed_version,
    "update_policy": update_policy,
    "installed_at": datetime.now(timezone.utc).isoformat(),
    "installer": "scripts/install-marketing-agent.sh",
}
path = pathlib.Path(path)
path.parent.mkdir(parents=True, exist_ok=True)
path.write_text(json.dumps(metadata, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
PY
}

need_command python3
assert_valid_target_workspace

if [[ -n "$source_agent_root" ]]; then
  source_agent_root="$(abs_dir "$source_agent_root" "SourceAgentRoot")"
  source_agent_full="$source_agent_root"
elif [[ -n "$repo_url" ]]; then
  source_agent_full="$(resolve_remote_agent_root "$repo_url" "$version")"
else
  source_agent_root="$repo_root/marketing-agent"
  source_agent_full="$(abs_dir "$source_agent_root" "SourceAgentRoot")"
fi

for required in AGENTS.md ARCHITECTURE.md SKILLS.md agents pipelines skills scripts templates mcps.json agent-version.json release-manifest.json; do
  [[ -e "$source_agent_full/$required" ]] || fail "Kaynak agent paketi eksik: $required"
done

manifest_count="$(test_manifest "$source_agent_full")"
destination_agent="$target_root/.pa/agent"
copy_agent_package "$source_agent_full" "$destination_agent"
bootstrap_status="$(install_bootstrap "$source_agent_full/templates/workspace-bootstrap-AGENTS.md")"
agent_version="$(read_json_field "$destination_agent/agent-version.json" "version")"
write_install_metadata "$agent_version"

echo "SONUC: PersonalAutonomy Marketing Agent kurulumu tamamlandi."
echo "Hedef workspace: $target_root"
echo "Agent hedefi: $destination_agent"
echo "Surum: $agent_version"
echo "Manifest dosya sayisi: $manifest_count"
echo "Bootstrap AGENTS.md: $bootstrap_status"
echo "Sonraki adim: Hedef klasoru Codex root olarak ac ve kok AGENTS.md talimatlarini izle."
