#!/usr/bin/env bash
set -euo pipefail

target_root=""
source_agent_root=""
repo_url=""
version="latest"
json_output=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --target-root) target_root="$2"; shift 2 ;;
    --source-agent-root) source_agent_root="$2"; shift 2 ;;
    --repo-url) repo_url="$2"; shift 2 ;;
    --version) version="$2"; shift 2 ;;
    --json) json_output=1; shift ;;
    -h|--help)
      echo "Usage: check-update.sh [--target-root PATH] [--source-agent-root PATH|--repo-url URL] [--version latest|vX.Y.Z] [--json]"
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

get_source_version() {
  if [[ "$version" != "latest" ]]; then
    echo "$version"
    return
  fi
  if [[ -n "$source_agent_root" ]]; then
    [[ -f "$source_agent_root/agent-version.json" ]] || fail "SourceAgentRoot agent-version.json icermiyor: $source_agent_root"
    read_json_field "$source_agent_root/agent-version.json" "version"
    return
  fi
  if [[ -n "$repo_url" ]]; then
    latest_git_tag "$repo_url"
    return
  fi
  fail "Guncelleme kaynagi bulunamadi. --source-agent-root veya --repo-url ver."
}

need_command python3
root="$(find_target_root)"
current_version_path="$root/.pa/agent/agent-version.json"
[[ -f "$current_version_path" ]] || fail "Kurulu agent-version.json bulunamadi: $current_version_path"

metadata_path="$root/.pa/agent-install.json"
if [[ -z "$repo_url" && -f "$metadata_path" ]]; then
  repo_url="$(read_json_field "$metadata_path" "repo_url")"
fi

current_version="$(read_json_field "$current_version_path" "version")"
available_version="$(get_source_version || true)"
if [[ -z "$available_version" ]]; then
  status="unavailable"
  available_version="unknown"
else
  comparison="$(semver_compare "$current_version" "$available_version")"
  if [[ "$comparison" -lt 0 ]]; then
    status="update-available"
  elif [[ "$comparison" -eq 0 ]]; then
    status="up-to-date"
  else
    status="local-newer"
  fi
fi
checked_at="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"

if [[ "$json_output" -eq 1 ]]; then
  python3 - "$status" "$current_version" "$available_version" "$repo_url" "$checked_at" <<'PY'
import json, sys
print(json.dumps({
    "status": sys.argv[1],
    "current_version": sys.argv[2],
    "available_version": sys.argv[3],
    "repo_url": sys.argv[4],
    "checked_at": sys.argv[5],
}, ensure_ascii=False, indent=2))
PY
else
  echo "Durum: $status"
  echo "Mevcut surum: $current_version"
  echo "Uygun surum: $available_version"
fi
