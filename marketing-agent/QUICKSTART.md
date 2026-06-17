# Marketing Agent - Codex App Hızlı Başlangıç

## Kurulum Mantığı

Bu klasör tek başına gerçek proje workspace'i değildir. Marketer gerçek proje klasörünü Codex
root olarak açar ve resmi repo installer'ı ile bu paketi hedef workspace'e kurar.

Kurulumdan sonra hedef workspace'te:

- kök `AGENTS.md` bootstrap dosyası bulunur,
- asıl agent paketi `.pa/agent/` altında bulunur,
- asıl davranış talimatı `.pa/agent/AGENTS.md` dosyasından okunur.

## Marketer Promptu

```text
Bu klasör PersonalAutonomy proje workspace'i.

Şu resmi GitHub reposundaki PersonalAutonomy Marketing Agent'ı bu projeye kur:
<GITHUB_REPO_URL>

Kurulumu serbest elle yapma. Repodaki scripts/install-marketing-agent.ps1 installer'ını kullan.
Hedef proje kökü şu anda Codex'te açık olan klasördür.

Kurulumdan sonra .pa/agent/ paketini, kök AGENTS.md bootstrap dosyasını ve
release-manifest.json doğrulamasını kontrol et. Var olan proje dosyalarımı silme.
```

## Kullanıcı Akışı

1. Google Drive for desktop senkronizasyonunun tamamlandığını kontrol et.
2. Gerçek çalışma için ilgili fikir değerlendirme veya proje klasörünü Codex root olarak aç.
3. Her workspace için ayrı bir Codex thread başlat.
4. Marketing Agent kurulu değilse yukarıdaki kurulum promptunu kullan.
5. Kurulumdan sonra doğal dille hedefini yaz: "Bu fikri değerlendir", "Bu hafta için plan
   hazırla" veya "B2B coder brief oluştur" gibi.
6. Codex'in belirttiği kaynak dosyaları, çıktı yolunu ve bekleyen onayı incele.

Üst `idea-workspace/` veya `projects/` klasörünü analiz root'u olarak kullanma. Bu klasörler
yalnızca mevcut workspace'leri listelemek ve onaylı create scriptini çalıştırmak içindir.

## Yeni Workspace

Yeni değerlendirme veya proje klasörlerini elle oluşturma. Web app'ten gelen değişmez
kimliklerle, marketer'ın kendi üst klasöründe onaylı PowerShell scriptini Codex'e çalıştırt.
Scriptin başarı mesajından sonra oluşan klasörü yeni Codex root olarak aç.

## İlk Proje Çalışması

1. `PROJE.md` ve `01-baglam/` dosyalarını agent ile tamamla.
2. Web app Drive aktivasyon checklist'ini tamamla.
3. `Europe/Istanbul` tarihine göre aktif ISO haftalık planı kalan günler için doldur.
4. Çıktıları numaralı proje klasörlerinde üret.
5. Bir işi tamamladığında agent'in haftalık görevi kapatabilmesi için açık onay ver.

## Dış Araçlar

Codex'te etkin olan Browser, Chrome, web veya MCP araçları kullanılabilir. `mcps.json` yalnızca
capability envanteridir. Bir araç görünmüyorsa kurulu varsayılmaz; agent alternatif script veya
manuel veri listesi sunar.

## Sağlık Kontrolü

Kurulu agent paketinde:

```powershell
.\.pa\agent\scripts\healthcheck.ps1 -AgentRoot .\.pa\agent
.\.pa\agent\scripts\test_mvp_compatibility.ps1 -AgentRoot .\.pa\agent
```

Bir kimlik, release, state veya erişim hatası giderilemiyorsa tekrar tekrar denemek yerine
gösterilen sanitize edilmiş log adıyla Yönetici Burhan Kocak'a başvur.
