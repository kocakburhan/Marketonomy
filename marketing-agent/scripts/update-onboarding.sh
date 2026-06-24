#!/usr/bin/env bash
set -euo pipefail

projects_root="$PWD"
version="latest"
source_repo_root=""
yes=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --projects-root) projects_root="$2"; shift 2 ;;
    --version) version="$2"; shift 2 ;;
    --source-repo-root) source_repo_root="$2"; shift 2 ;;
    --yes) yes=1; shift ;;
    *) echo "Bilinmeyen parametre: $1" >&2; exit 1 ;;
  esac
done

[[ "$yes" -eq 1 ]] || { echo "Onboarding update icin acik kullanici onayi gerekir. --yes kullan." >&2; exit 1; }
metadata="$projects_root/.pa/onboarding-install.json"
[[ -f "$metadata" ]] || { echo "Onboarding kurulum metadata dosyasi bulunamadi: $metadata" >&2; exit 1; }
command -v python3 >/dev/null 2>&1 || { echo "python3 bulunamadi." >&2; exit 1; }

repo_url="$(python3 - "$metadata" <<'PY'
import json, pathlib, sys
data = json.loads(pathlib.Path(sys.argv[1]).read_text(encoding="utf-8"))
print(data.get("repo_url", ""))
PY
)"

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

if [[ -n "$source_repo_root" ]]; then
  repo_root="$(cd "$source_repo_root" && pwd -P)"
  installer="$repo_root/scripts/install-projects-root.sh"
  args=(--target-root "$projects_root" --source-repo-root "$repo_root" --version "$version" --force-bootstrap)
  [[ -z "$repo_url" ]] || args+=(--repo-url "$repo_url")
else
  [[ -n "$repo_url" ]] || { echo "Onboarding metadata repo_url icermiyor." >&2; exit 1; }
  installer="$script_dir/install-projects-root.sh"
  args=(--target-root "$projects_root" --repo-url "$repo_url" --version "$version" --force-bootstrap)
fi

[[ -f "$installer" ]] || { echo "Projects root installer bulunamadi: $installer" >&2; exit 1; }
"$installer" "${args[@]}"
