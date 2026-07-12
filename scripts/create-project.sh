#!/usr/bin/env bash
set -euo pipefail

target_root=""
title="Yeni Proje"
idea_id=""
project_id=""
source_agent_root=""
repo_url=""
version="latest"
marketer_profile_path=""
created_target=""
create_succeeded=0

usage() {
  cat <<'USAGE'
Usage: create-project.sh --target-root PATH [options]

Options:
  --target-root PATH           Empty target project folder to create.
  --title TEXT                 Project title. Defaults to "Yeni Proje".
  --idea-id ID                 Optional idea_id.
  --project-id ID              Optional project_id.
  --source-agent-root PATH     Local marketing-agent package source.
  --repo-url URL               Git repository URL containing marketing-agent/.
  --version VERSION            latest or vMAJOR.MINOR.PATCH. Defaults to latest.
  --marketer-profile-path PATH Explicit marketer profile to copy.
USAGE
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --target-root) target_root="$2"; shift 2 ;;
    --title) title="$2"; shift 2 ;;
    --idea-id) idea_id="$2"; shift 2 ;;
    --project-id) project_id="$2"; shift 2 ;;
    --source-agent-root) source_agent_root="$2"; shift 2 ;;
    --repo-url) repo_url="$2"; shift 2 ;;
    --version) version="$2"; shift 2 ;;
    --marketer-profile-path) marketer_profile_path="$2"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Bilinmeyen parametre: $1" >&2; usage; exit 1 ;;
  esac
done

fail() { echo "HATA: $*" >&2; exit 1; }

cleanup() {
  if [[ "$create_succeeded" -ne 1 && -n "$created_target" && -d "$created_target" ]]; then
    rm -rf "$created_target"
  fi
}
trap cleanup EXIT

[[ -n "$target_root" ]] || fail "--target-root zorunludur."
command -v python3 >/dev/null 2>&1 || fail "python3 bulunamadi."

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
repo_root="$(cd "$script_dir/.." && pwd -P)"

assert_safe_target() {
  local root="$1"
  if [[ -e "$root" ]]; then
    [[ -d "$root" ]] || fail "TargetRoot klasor olmali: $root"
    if [[ -n "$(find "$root" -mindepth 1 -maxdepth 1 -print -quit)" ]]; then
      fail "TargetRoot bos olmali; mevcut proje dosyalari uzerine workspace olusturulmaz: $root"
    fi
  else
    mkdir -p "$root"
  fi
  (cd "$root" && pwd -P)
}

new_local_id() {
  local prefix="$1"
  local guid
  if command -v uuidgen >/dev/null 2>&1; then
    guid="$(uuidgen | tr '[:upper:]' '[:lower:]' | tr -d '-')"
  else
    guid="$(python3 - <<'PY'
import uuid
print(uuid.uuid4().hex)
PY
)"
  fi
  echo "$prefix-$(date +%Y%m%d%H%M%S)-${guid:0:8}"
}

iso_week_name() {
  python3 - <<'PY'
from datetime import date
year, week, _ = date.today().isocalendar()
print(f"{year}-W{week:02d}")
PY
}

find_marketer_profile() {
  local target="$1"
  local current
  current="$(dirname "$target")"
  while [[ -n "$current" && "$current" != "/" ]]; do
    if [[ -f "$current/.pa/marketer-profile.md" ]]; then
      echo "$current/.pa/marketer-profile.md"
      return
    fi
    current="$(dirname "$current")"
  done
}

find_onboarding_install() {
  local target="$1"
  local current
  current="$(dirname "$target")"
  while [[ -n "$current" && "$current" != "/" ]]; do
    if [[ -f "$current/.pa/onboarding-install.json" ]]; then
      echo "$current/.pa/onboarding-install.json"
      return
    fi
    current="$(dirname "$current")"
  done
}

write_state_json() {
  python3 - "$1" "$2" "$3" "$4" "$5" "$6" <<'PY'
import hashlib, json, pathlib, sys
path, project_id, idea_id, title, active_week, created_at = sys.argv[1:7]
overrides = pathlib.Path(path).parent / "overrides.md"
overrides_hash = hashlib.sha256(overrides.read_bytes()).hexdigest() if overrides.exists() else None
state = {
    "schema_version": "1.0",
    "workspace_type": "project",
    "project_id": project_id,
    "idea_id": idea_id,
    "title": title,
    "timezone": "Europe/Istanbul",
    "overrides_sha256": overrides_hash,
    "active_week": active_week,
    "active_week_plan": f"05-haftalik-planlar/{active_week}.md",
    "created_at": created_at,
    "created_by": "scripts/create-project.sh",
}
pathlib.Path(path).write_text(json.dumps(state, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
PY
}

target="$(assert_safe_target "$target_root")"
created_target="$target"
[[ -n "$idea_id" ]] || idea_id="$(new_local_id "idea")"
[[ -n "$project_id" ]] || project_id="$(new_local_id "project")"
now_date="$(date +%Y-%m-%d)"
now_iso="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
active_week="$(iso_week_name)"

if [[ -z "$marketer_profile_path" ]]; then
  marketer_profile_path="$(find_marketer_profile "$target" || true)"
fi
if [[ -z "$source_agent_root" && -z "$repo_url" ]]; then
  onboarding_install="$(find_onboarding_install "$target" || true)"
  if [[ -n "$onboarding_install" ]]; then
    metadata_values="$(python3 - "$onboarding_install" <<'PY'
import json, pathlib, sys
data = json.loads(pathlib.Path(sys.argv[1]).read_text(encoding="utf-8"))
print(data.get("repo_url", ""))
print(data.get("requested_version", ""))
PY
)"
    metadata_repo_url="$(printf '%s\n' "$metadata_values" | sed -n '1p')"
    metadata_version="$(printf '%s\n' "$metadata_values" | sed -n '2p')"
    [[ -z "$metadata_repo_url" ]] || repo_url="$metadata_repo_url"
    if [[ "$version" == "latest" && "$metadata_version" =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
      version="$metadata_version"
    fi
  fi
fi

folders=(
  "00-gelen-kutusu" "00-gelen-kutusu/yuklemeler"
  "01-baglam"
  "02-arastirma" "02-arastirma/fikir-degerlendirme" "02-arastirma/pazar-arastirmasi" "02-arastirma/rakip-arastirmasi" "02-arastirma/musteri-arastirmasi" "02-arastirma/trend-arastirmasi" "02-arastirma/store-intelligence/raw" "02-arastirma/store-intelligence/snapshots"
  "03-strateji" "03-strateji/dogrulama" "03-strateji/konumlandirma" "03-strateji/fiyatlandirma" "03-strateji/pazara-giris" "03-strateji/buyume"
  "04-urun" "04-urun/fikir-ozetleri" "04-urun/prd" "04-urun/coder-briefleri" "04-urun/urun-kararlari"
  "05-haftalik-planlar"
  "06-pazarlama-uygulamalari/dijital" "06-pazarlama-uygulamalari/saha" "06-pazarlama-uygulamalari/hibrit"
  "07-lansman"
  "08-raporlar" "08-raporlar/haftalik" "08-raporlar/pazarlama" "08-raporlar/analitik" "08-raporlar/yatirimci" "08-raporlar/finansal" "08-raporlar/pdf" "08-raporlar/excel"
  "09-varliklar"
  "10-final/prd" "10-final/coder-briefleri" "10-final/raporlar" "10-final/yatirimci" "10-final/lansman" "10-final/dijital" "10-final/saha" "10-final/hibrit"
  "11-notlar/bilgi-haritasi/sayfalar"
  "99-arsiv"
  ".pa/project"
)
for folder in "${folders[@]}"; do
  mkdir -p "$target/$folder"
done

gitkeep_folders=(
  "00-gelen-kutusu" "01-baglam" "02-arastirma" "02-arastirma/fikir-degerlendirme"
  "03-strateji" "03-strateji/dogrulama" "04-urun"
  "06-pazarlama-uygulamalari/dijital" "06-pazarlama-uygulamalari/saha" "06-pazarlama-uygulamalari/hibrit"
  "07-lansman" "08-raporlar" "09-varliklar" "10-final/yatirimci" "11-notlar" "11-notlar/bilgi-haritasi" "99-arsiv"
)
for folder in "${gitkeep_folders[@]}"; do
  : > "$target/$folder/.gitkeep"
done

cat > "$target/PROJE.md" <<EOF
# $title

project_id: $project_id
idea_id: $idea_id

## Özet
- Durum: Yeni proje workspace'i
- Oluşturma tarihi: $now_date
- Oluşturma akışı: approved create flow, Codex + Google Drive first

## Fikir Değerlendirme Modu
Bu workspace tek proje çalışma alanıdır. Fikir ayrı bir çalışma klasörüne taşınmaz.
Kullanıcı isterse ilk iş olarak fikir burada acımasızca değerlendirilir; araştırma ve karar
izleri \`02-arastirma/fikir-degerlendirme/\`, \`03-strateji/dogrulama/\`, \`KARARLAR.md\` ve
\`DURUM.md\` içinde tutulur. Fikir denenmeye değmezse proje dosyaları silinmez; gerekçe ve sonraki
seçenekler kayda geçirilir.

EOF

cat > "$target/DURUM.md" <<EOF
# Durum

- Workspace turu: Project
- Aktif iş: Proje bağlamı tamamlanıyor
- Aktif haftalik plan: 05-haftalik-planlar/$active_week.md
- Sonraki adım: 01-baglam/ proje bağlamını tamamla.

EOF

printf '# Kararlar\n\nHenüz karar kaydı yok.\n' > "$target/KARARLAR.md"
printf "# Workspace Rehberi\n\nBu klasör PersonalAutonomy proje workspace'idir.\n" > "$target/README.md"
printf '# Active Task\n\nDurum: Bos\n' > "$target/.pa/project/active-task.md"
printf '{"timezone":"Europe/Istanbul"}\n' > "$target/.pa/project/settings.json"
printf '# Project Overrides\n\nOnaylı proje-özel tercih yok.\n' > "$target/.pa/project/overrides.md"
printf '# Approved Project Overrides\n\nOnaylı proje-özel tercih yok.\n' > "$target/.pa/project/overrides-approved.md"
printf '# Final Linkler\n\nHenüz final teslim linki yok.\n' > "$target/10-final/linkler.md"

week_folder="$target/05-haftalik-planlar/$active_week"
mkdir -p "$week_folder"
cat > "$target/05-haftalik-planlar/$active_week.md" <<EOF
# $active_week Haftalık Plan

- Workspace: $title
- Durum: Başlangıç plan taslağı
- Kapanış kuralı: Workspace artifact'i görevi açıkça kanıtlıyorsa agent görevi kapatır ve kullanıcıyı bilgilendirir. Harici aksiyonlar kullanıcı bildirimi bekler. Final yayın veya teslim açık onay ister.

## Bu Haftanın Odakları
- Başlangıç görevi yok.

## Notlar
- Bu dosya create-project.sh tarafından başlangıç iskeleti olarak oluşturuldu.
- İlk gerçek haftalık görevler kullanıcı ile birlikte planlanır.

EOF

cat > "$week_folder/schedule.md" <<EOF
# $active_week Schedule

Timezone: Europe/Istanbul

## Haftalık Görünüm
- Pazartesi:
- Salı:
- Çarşamba:
- Perşembe:
- Cuma:
- Cumartesi:
- Pazar:

EOF

for day in pazartesi:Pazartesi sali:Salı carsamba:Çarşamba persembe:Perşembe cuma:Cuma cumartesi:Cumartesi pazar:Pazar; do
  file="${day%%:*}.md"
  label="${day#*:}"
  cat > "$week_folder/$file" <<EOF
# $active_week $label

Timezone: Europe/Istanbul

## Gorevler
- Başlangıç görevi yok.

EOF
done

printf '# Bilgi Haritası\n\nKalıcı çıktı, karar ve kaynak ilişkileri burada izlenir.\n' > "$target/11-notlar/bilgi-haritasi/index.md"
printf '# Bilgi Haritası Log\n\n' > "$target/11-notlar/bilgi-haritasi/log.md"

write_state_json "$target/.pa/project/state.json" "$project_id" "$idea_id" "$title" "$active_week" "$now_iso"

if [[ -n "$marketer_profile_path" ]]; then
  cp "$marketer_profile_path" "$target/.pa/project/marketer-profile.md"
fi

installer="$script_dir/install-marketing-agent.sh"
install_args=(--target-root "$target" --version "$version")
if [[ -n "$source_agent_root" ]]; then install_args+=(--source-agent-root "$source_agent_root"); fi
if [[ -n "$repo_url" ]]; then install_args+=(--repo-url "$repo_url"); fi
"$installer" "${install_args[@]}" >/dev/null

create_succeeded=1
echo "SONUC: Project workspace olusturuldu."
echo "Path: $target"
echo "project_id: $project_id"
echo "idea_id: $idea_id"
