#!/usr/bin/env bash
set -euo pipefail

projects_root="${1:-$PWD}"
metadata="$projects_root/.pa/onboarding-install.json"
[[ -f "$metadata" ]] || { echo "Onboarding kurulum metadata dosyasi bulunamadi: $metadata" >&2; exit 1; }
command -v git >/dev/null 2>&1 || { echo "Git bulunamadi." >&2; exit 1; }
command -v python3 >/dev/null 2>&1 || { echo "python3 bulunamadi." >&2; exit 1; }

repo_url="$(python3 - "$metadata" <<'PY'
import json, pathlib, sys
data = json.loads(pathlib.Path(sys.argv[1]).read_text(encoding="utf-8"))
print(data.get("repo_url", ""))
PY
)"
installed="$(python3 - "$metadata" <<'PY'
import json, pathlib, sys
data = json.loads(pathlib.Path(sys.argv[1]).read_text(encoding="utf-8"))
print(data.get("installed_version", ""))
PY
)"
[[ -n "$repo_url" ]] || { echo "Onboarding metadata repo_url icermiyor." >&2; exit 1; }

latest="$(git ls-remote --tags --refs "$repo_url" 'v*' |
  sed -nE 's#.*refs/tags/(v[0-9]+\.[0-9]+\.[0-9]+)$#\1#p' |
  sort -V | tail -n 1)"

echo "Kurulu surum: $installed"
echo "En yeni surum: $latest"
if [[ -n "$latest" && "$latest" != "$installed" ]]; then
  echo "Update mevcut: true"
else
  echo "Update mevcut: false"
fi
