#!/usr/bin/env bash
set -euo pipefail

target_root="$PWD"
source_repo_root=""
repo_url=""
version="latest"
update_policy="ask"
force_bootstrap=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --target-root) target_root="$2"; shift 2 ;;
    --source-repo-root) source_repo_root="$2"; shift 2 ;;
    --repo-url) repo_url="$2"; shift 2 ;;
    --version) version="$2"; shift 2 ;;
    --update-policy) update_policy="$2"; shift 2 ;;
    --force-bootstrap) force_bootstrap=1; shift ;;
    *) echo "Bilinmeyen parametre: $1" >&2; exit 1 ;;
  esac
done

[[ "$version" == "latest" || "$version" =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]] || {
  echo "Version latest veya vMAJOR.MINOR.PATCH biciminde olmali." >&2; exit 1;
}
[[ "$update_policy" == "ask" || "$update_policy" == "manual" ]] || {
  echo "UpdatePolicy ask veya manual olmali." >&2; exit 1;
}
command -v python3 >/dev/null 2>&1 || { echo "python3 bulunamadi." >&2; exit 1; }

mkdir -p "$target_root"
target_root="$(cd "$target_root" && pwd -P)"
[[ ! -e "$target_root/PROJE.md" && ! -e "$target_root/.pa/project/state.json" ]] || {
  echo "Projects root installer proje workspace'ine kurulamaz." >&2; exit 1;
}

temp_repo=""
cleanup() {
  [[ -z "$temp_repo" || ! -d "$temp_repo" ]] || rm -rf "$temp_repo"
}
trap cleanup EXIT

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
if [[ -n "$source_repo_root" ]]; then
  repo_root="$(cd "$source_repo_root" && pwd -P)"
elif [[ -n "$repo_url" ]]; then
  temp_repo="$(mktemp -d "${TMPDIR:-/tmp}/pa-projects-root-source.XXXXXX")"
  if [[ "$version" == "latest" ]]; then
    git -c core.autocrlf=false clone --depth 1 "$repo_url" "$temp_repo"
  else
    git -c core.autocrlf=false clone --depth 1 --branch "$version" "$repo_url" "$temp_repo"
  fi
  repo_root="$temp_repo"
else
  repo_root="$(cd "$script_dir/.." && pwd -P)"
fi

agent_root="$repo_root/marketing-agent"
python3 - "$agent_root" <<'PY'
import hashlib, json, pathlib, sys
root = pathlib.Path(sys.argv[1])
manifest = json.loads((root / "release-manifest.json").read_text(encoding="utf-8"))
for item in manifest["files"]:
    path = root / item["path"]
    if not path.is_file():
        raise SystemExit(f"Manifest dosyasi eksik: {item['path']}")
    if hashlib.sha256(path.read_bytes()).hexdigest() != item["sha256"]:
        raise SystemExit(f"Manifest hash uyusmazligi: {item['path']}")
PY

bootstrap_source="$agent_root/templates/projects-root-bootstrap-AGENTS.md"
guide_source="$agent_root/agents/onboarding-guide.md"
[[ -f "$bootstrap_source" && -f "$guide_source" ]] || { echo "Onboarding kaynak dosyasi eksik." >&2; exit 1; }

if [[ -f "$target_root/AGENTS.md" ]] &&
   ! grep -q 'PA_PROJECTS_BOOTSTRAP_VERSION: 1' "$target_root/AGENTS.md"; then
  if [[ "$force_bootstrap" -ne 1 ]]; then
    echo "Hedef AGENTS.md PersonalAutonomy Projects bootstrap degil. --force-bootstrap kullan." >&2
    exit 1
  fi
  cp "$target_root/AGENTS.md" "$target_root/AGENTS.md.pre-pa-projects-install-$(date +%Y%m%d-%H%M%S).bak"
fi

mkdir -p "$target_root/.pa/onboarding/scripts"
cp "$agent_root/scripts/check-onboarding-update.ps1" "$target_root/.pa/onboarding/scripts/check-update.ps1"
cp "$agent_root/scripts/check-onboarding-update.sh" "$target_root/.pa/onboarding/scripts/check-update.sh"
cp "$repo_root/scripts/install-projects-root.ps1" "$target_root/.pa/onboarding/scripts/install-projects-root.ps1"
cp "$repo_root/scripts/install-projects-root.sh" "$target_root/.pa/onboarding/scripts/install-projects-root.sh"
cp "$agent_root/scripts/update-onboarding.ps1" "$target_root/.pa/onboarding/scripts/update-onboarding.ps1"
cp "$agent_root/scripts/update-onboarding.sh" "$target_root/.pa/onboarding/scripts/update-onboarding.sh"
cp "$bootstrap_source" "$target_root/AGENTS.md"
cp "$guide_source" "$target_root/onboarding-guide.md"

installed_version="$(python3 - "$agent_root/agent-version.json" <<'PY'
import json, pathlib, sys
print(json.loads(pathlib.Path(sys.argv[1]).read_text(encoding="utf-8"))["version"])
PY
)"
[[ "$version" == "latest" ]] || installed_version="$version"
python3 - "$target_root/.pa/onboarding-install.json" "$repo_url" "$version" "$installed_version" "$update_policy" <<'PY'
import datetime, json, pathlib, sys
path, repo_url, requested, installed, policy = sys.argv[1:6]
data = {
    "schema_version": "1.0",
    "repo_url": repo_url,
    "requested_version": requested,
    "installed_version": installed,
    "update_policy": policy,
    "installed_at": datetime.datetime.now(datetime.timezone.utc).isoformat(),
    "installer": "scripts/install-projects-root.sh",
}
pathlib.Path(path).write_text(json.dumps(data, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
PY

echo "SONUC: PersonalAutonomy Projects root onboarding kurulumu tamamlandi."
echo "Hedef: $target_root"
echo "Surum: $installed_version"
