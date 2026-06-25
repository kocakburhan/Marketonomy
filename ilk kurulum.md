# PersonalAutonomy Marketing Agent İlk Kurulum Rehberi

Bu rehber, elinde yalnızca PersonalAutonomy GitHub repo bağlantısı bulunan bir marketer'ın
sıfırdan kurulum yapmasını ve ilk `x-projesi` workspace'ini oluşturmasını anlatır.

## 1. Güncel Çalışma Modeli

Marketer'ın Google Drive ile senkronize edilen tek ana klasörü vardır:

```text
Projects/
```

Bu ana klasör yalnızca şu işler için kullanılır:

- ilk onboarding
- Codex plugin ve MCP kontrolü
- reusable marketer profilinin tutulması
- yeni proje workspace'i oluşturulması

Gerçek pazarlama ve proje çalışması doğrudan ana klasörde yapılmaz. Her proje ayrı klasörde,
ayrı Codex workspace ve ayrı Codex thread olarak çalışır:

```text
Projects/
  x-projesi/
  y-projesi/
```

Fikir değerlendirme ayrı bir workspace türü değildir. `create-evaluation.ps1`, `idea-workspace/`,
`DEGERLENDIRME.md` ve `.pa/evaluation/` güncel modelde kullanılmaz. Fikir değerlendirme,
oluşturulan proje klasörü içindeki bir çalışma modudur.

## 2. Bilgisayara Kurulacak Temel Araçlar

Kurulumdan önce kullanıcının bilgisayarında şu temel araçlar hazır olmalıdır:

1. Codex App
2. Git
3. Google Drive for desktop
4. Node.js 18 veya üzeri

Node.js özellikle Playwright MCP ve `npx` tabanlı araçlar için gerekir. Kullanıcı komut satırıyla
çalışmayacak olsa bile Codex App bazı MCP/plugin kurulumlarında arka planda Node.js'e ihtiyaç
duyabilir.

### 2.1 Codex App

1. Codex App'i kurun.
2. OpenAI hesabınızla giriş yapın.
3. Uygulamayı açın ve yerel klasör seçebildiğinizi doğrulayın.

### 2.2 Git

GitHub reposunun geçici olarak indirilebilmesi için Git gereklidir.

Kontrol:

```powershell
git --version
```

Komut sürüm döndürmüyorsa Git'i kurun, terminali ve Codex'i yeniden başlatın.

### 2.3 Google Drive for desktop

1. Google Drive for desktop uygulamasını kurun.
2. Marketer'ın Google hesabıyla giriş yapın.
3. Drive alanında `Projects` isminde bir klasör oluşturun.
4. Klasörün bilgisayarda yerel bir yol olarak göründüğünü doğrulayın.
5. İlk senkronizasyon tamamlanmadan proje oluşturmaya başlamayın.

Örnek Windows yolu:

```text
G:\Drive'ım\Projects
```

Örnek macOS yolu:

```text
/Users/<kullanici>/Library/CloudStorage/GoogleDrive-<hesap>/My Drive/Projects
```

### 2.4 Node.js

Playwright MCP'nin ve bazı Codex App plugin/MCP kurulumlarının çalışabilmesi için Node.js 18 veya
üzeri kurulu olmalıdır.

Kontrol:

```powershell
node --version
npx --version
```

## 3. Superpowers Pluginini Kurma

Superpowers, Codex'e planlama, TDD, sistematik debugging ve doğrulama gibi geliştirme
workflow'ları sağlayan bir skill paketidir. Kurulum kullanıcı düzeyindedir; `Projects/`
klasörüne kopyalanmaz.

Codex App'te:

1. Sol menüden **Plugins** bölümünü açın.
2. **Coding** kategorisinde **Superpowers** pluginini bulun.
3. Yanındaki `+` düğmesine basın.
4. Kurulum istemlerini tamamlayın.
5. Codex'i yeniden başlatın.
6. Yeni bir thread açıp skill listesindeki `using-superpowers`, `brainstorming`,
   `test-driven-development` ve `verification-before-completion` girişlerini kontrol edin.

Kullanıcı bu üründe Codex'i CLI ile değil Codex App arayüzüyle kullanır. Bu yüzden plugin, skill ve
MCP kurulumlarında birincil yol her zaman uygulamadaki **Plugins** sekmesidir. Gerekli bir plugin,
skill veya MCP bu sekmede görünmüyorsa kullanıcı elle tahmin yürütmemelidir; Codex'ten ilgili
kurulum yolunu bulmasını, resmi kaynakları kontrol etmesini ve güvenli kurulum adımlarını
önermesini istemelidir.

CLI sadece geliştirici veya teknik destek senaryosunda alternatif olabilir:

1. `/plugins` komutunu açın.
2. `superpowers` arayın.
3. **Install Plugin** seçeneğini kullanın.
4. Codex'i yeniden başlatın.

## 4. Playwright MCP'yi Kurma

Playwright MCP, Codex'in gerçek tarayıcı sayfalarını açmasına, incelemesine ve UI akışlarını test
etmesine yardımcı olur. Bu kurulum da kullanıcı düzeyindedir; `Projects/` içine dosya yazmaz.

Codex App'te önce **Plugins** sekmesini açın ve Playwright/MCP/browser automation ile ilgili resmi
kurulum seçeneği görünüyorsa oradan kurun. Kurulumdan sonra Codex'i yeniden başlatın ve yeni bir
thread içinde Playwright araçlarının aktif tool listesinde göründüğünü doğrulayın.

Plugins sekmesinde Playwright MCP görünmüyorsa Codex'ten kurulumda yardım isteyin. Teknik destek
veya geliştirici senaryosunda eşdeğer CLI komutu şudur:

```powershell
codex mcp add playwright -- npx "@playwright/mcp@latest"
```

Alternatif olarak `~/.codex/config.toml` dosyasına şu kayıt eklenebilir:

```toml
[mcp_servers.playwright]
command = "npx"
args = ["@playwright/mcp@latest"]
```

Sonra:

1. Codex'i tamamen kapatıp yeniden açın.
2. Yeni bir thread başlatın.
3. Aktif MCP/tool listesinde Playwright araçlarının göründüğünü doğrulayın.
4. Görünmüyorsa `node --version`, `npx --version` ve `codex mcp --help` komutlarını kontrol edin.

Playwright MCP görülmüyorsa Marketing Agent bunu kurulu varsaymamalıdır. Resmi web aracı,
Codex Browser/Chrome araçları veya manuel veri fallback'i kullanılmalıdır.

## 5. Diğer Codex Bağlantılarını Kontrol Etme

Marketer'ın işine göre şu bağlantıları kurun veya erişim durumunu kaydedin:

1. Google Drive
2. Google Calendar
3. Gmail
4. Canva
5. Figma
6. GitHub

Her bağlantı zorunlu değildir. Agent yalnızca aktif tool listesinde görünen bağlantıları
kullanabilir; görünmeyen plugin, MCP veya oturumu varmış gibi davranamaz.

## 6. Doğru Kurulum Roadmap'i

Elinde yalnızca GitHub repo linki, Codex App ve Google Drive erişimi olan kullanıcı şu sırayla
ilerlemelidir:

1. Codex App, Git, Google Drive for desktop ve Node.js 18 veya üzerinin kurulu olduğunu doğrula.
2. Google Drive içinde tek ana klasör oluştur: `Projects/`.
3. Codex App'te repo klasörünü değil, Drive'daki `Projects/` klasörünü workspace/root olarak aç.
4. Codex'e GitHub repo linkini ver ve `v5.5.1` sürümünden resmi `install-projects-root` akışını
   çalıştırmasını iste.
5. Codex'in repoyu geçici klasöre indirip `Projects/AGENTS.md`, `Projects/onboarding-guide.md`,
   `.pa/onboarding-install.json` ve `.pa/onboarding/` scriptlerini kurduğunu kontrol et.
6. Kullanıcı profil bilgilerinin `Projects/.pa/marketer-profile.md` içine kaydedildiğini doğrula;
   secret, parola veya API key yazılmamalıdır.
7. Yeni proje istendiğinde Codex'in resmi `create-project.ps1` veya `create-project.sh` scriptini
   kullandığını doğrula.
8. Projenin `Projects/x-projesi/` altında oluştuğunu; `.pa/agent/`, `PROJE.md`, `DURUM.md`,
   `KARARLAR.md`, kök `AGENTS.md` ve manifest doğrulamasının başarılı olduğunu kontrol et.
9. Gerçek çalışma için Codex'te `Projects/x-projesi/` klasörünü yeni workspace/root olarak aç ve
   yeni bir thread başlat.
10. Fikir değerlendirmeyi ayrı workspace olarak değil proje içinde yürüt. Çıktılar
    `02-arastirma/fikir-degerlendirme/`, `03-strateji/dogrulama/`, `KARARLAR.md`, `DURUM.md` ve
    `11-notlar/bilgi-haritasi/` yollarına yazılmalıdır.

## 7. Ana `Projects/` Klasörünü Codex'te Açma

Codex App'te workspace/root olarak doğrudan ana `Projects/` klasörünü seçin:

```text
Projects/
```

İlk kurulumda henüz `x-projesi/` klasörü yoktur. GitHub kaynak reposunu da gerçek çalışma
workspace'i olarak açmayın.

## 8. Projects Root Onboarding Kurulumu

Codex'e repo URL'sini verdikten sonra resmi kök installer çalıştırılmalıdır. Kullanıcının elinde
yalnızca GitHub repo linki varsa bu komutlar `Projects/` kökünde elle çalıştırılmaz; Codex önce
repoyu geçici bir klasöre indirir ve aşağıdaki eşdeğer komutu o geçici repo içinden çalıştırır.

Windows:

```powershell
.\scripts\install-projects-root.ps1 `
  -TargetRoot "<PROJECTS_YOLU>" `
  -RepoUrl "<GITHUB_REPO_URL>" `
  -Version v5.5.1
```

macOS:

```bash
./scripts/install-projects-root.sh \
  --target-root "<PROJECTS_YOLU>" \
  --repo-url "<GITHUB_REPO_URL>" \
  --version v5.5.1
```

Bu installer:

- `Projects/AGENTS.md` ince bootstrap dosyasını kurar.
- Canonical `marketing-agent/agents/onboarding-guide.md` dosyasını
  `Projects/onboarding-guide.md` olarak kopyalar.
- `.pa/onboarding/` update scriptlerini kurar.
- `.pa/onboarding-install.json` içine repo ve sürüm bilgisini yazar.
- Mevcut `.pa/marketer-profile.md` ve proje klasörlerini korur.

## 9. Ana Kurulum Promptu

`Projects/` klasörü Codex'te açıkken aşağıdaki promptu verin. `<GITHUB_REPO_URL>` alanını gerçek
repo bağlantısıyla değiştirin:

```text
Bu klasör benim Google Drive ile senkronize edilen PersonalAutonomy ana Projects klasörüm.

Resmi kaynak repo:
<GITHUB_REPO_URL>

Güncel tek-Projects sözleşmesini kullan. Ayrı evaluation workspace oluşturma; create-evaluation.ps1,
idea-workspace, DEGERLENDIRME.md veya .pa/evaluation kullanma.

Bu ana Projects klasörüne Marketing Agent paketini kurma. Bu kök yalnızca onboarding, plugin/MCP
kontrolü, reusable marketer profili ve yeni proje oluşturma içindir.

Şimdi:
1. Repoyu geçici bir klasöre indir ve işletim sistemime uygun resmi Projects root installer'ını
   çalıştır:
   - Windows: scripts/install-projects-root.ps1
   - macOS: scripts/install-projects-root.sh
2. Kurulumdan sonra Projects/AGENTS.md ve Projects/onboarding-guide.md dosyalarını oku.
3. Git, Google Drive senkronizasyonu, Superpowers plugininin ve Playwright MCP'nin hazır olup
   olmadığını kontrol et.
4. Google Drive, Calendar, Gmail, Canva, Figma ve GitHub bağlantılarının durumunu benimle kontrol et.
5. Reusable marketer profilimi benden topla ve Projects/.pa/marketer-profile.md olarak kaydet.
   Standart sorular dışında gönüllü olarak paylaştığım ek bilgileri `Ek kullanıcı bağlamı`
   altında sakla; hassas bilgi çıkarımı yapma.
6. Secret, parola veya erişim anahtarı isteme ve profil dosyasına yazma.
7. Daha sonra yeni proje istediğimde repoyu geçici bir klasöre indir ve işletim sistemime uygun
   resmi scripti kullan:
   - Windows: scripts/create-project.ps1
   - macOS: scripts/create-project.sh
8. Yeni projeyi Projects/<proje-adi>/ altında oluştur. `.pa/onboarding-install.json` içindeki repo
   URL'sini ve `v5.5.1` sürümünü kullan.
9. Script bittikten sonra project_id, idea_id, .pa/agent/, kök AGENTS.md ve manifest doğrulamasını
   kontrol et.
10. Gerçek çalışma için oluşan proje klasörünü yeni Codex workspace olarak açmam gerektiğini söyle.

Serbest elle proje workspace'i kurma ve mevcut dosyalarımı silme.
```

Pilot için yayınlanmış sabit `v5.5.1` tag'ini kullanın. `latest` ancak yeni release doğrulandıktan
sonra tercih edilmelidir.

## 10. Prompt Sonrasında Ana `Projects/` Klasöründe Ne Oluşur?

Ana onboarding installer sonrasında oluşan yapı:

```text
Projects/
  AGENTS.md
  onboarding-guide.md
  .pa/
    marketer-profile.md
    onboarding-install.json
    onboarding/
      scripts/
        check-update.ps1
        check-update.sh
        update-onboarding.ps1
        update-onboarding.sh
```

Önemli sınırlar:

- `.pa/agent/` ana `Projects/` kökünde oluşmaz.
- `PROJE.md`, `DURUM.md` veya `KARARLAR.md` ana `Projects/` içinde oluşmaz.
- Kök `AGENTS.md`, doğrudan `onboarding-guide.md` dosyasına yönlendiren ince bootstrap'tır.
- Superpowers dosyaları Codex plugin alanında yaşar.
- Playwright MCP ayarı kullanıcı düzeyi `~/.codex/config.toml` içinde yaşar.
- Repo, proje oluşturma sırasında geçici bir klasöre klonlanabilir; bu geçici kaynak gerçek
  proje workspace'i değildir.
- `.pa-create-work/` ve `.pa-script-logs/` sözleşmede ayrılmış teknik alanlardır; mevcut
  `create-project` scripti bunları kalıcı çıktı olarak oluşturmaz. Bu yüzden ilk prompttan sonra
  varlıkları garanti edilmez.

## 11. `x-projesi` Oluşturma

Ana `Projects/` workspace'i açıkken şu promptu verin:

```text
x-projesi isminde yeni bir PersonalAutonomy proje workspace'i oluştur.
Resmi repo kaynağı olarak daha önce verdiğim URL'yi kullan.
İşletim sistemime uygun resmi create-project scriptini çalıştır.
Proje tamamlanınca doğrulamaları yap ve açmam gereken klasörü söyle.
```

Windows'ta çalıştırılması beklenen komutun eşdeğeri:

```powershell
.\scripts\create-project.ps1 `
  -TargetRoot "<PROJECTS_YOLU>\x-projesi" `
  -Title "X Projesi" `
  -RepoUrl "<GITHUB_REPO_URL>" `
  -Version v5.5.1
```

macOS'ta eşdeğer:

```bash
./scripts/create-project.sh \
  --target-root "<PROJECTS_YOLU>/x-projesi" \
  --title "X Projesi" \
  --repo-url "<GITHUB_REPO_URL>" \
  --version v5.5.1
```

Script şu güvenlik kontrollerini uygular:

1. Hedefin yeni veya boş bir klasör olduğunu doğrular.
2. `project_id` ve `idea_id` üretir.
3. Canonical proje klasör ağacını oluşturur.
4. `PROJE.md` ile `.pa/project/state.json` kimliklerini aynı değerlerle yazar.
5. Ana marketer profilini projeye kopyalar.
6. Resmi installer ile `.pa/agent/` paketini kurar.
7. Kök `AGENTS.md` bootstrap dosyasını oluşturur.
8. Kaynak ve hedef `release-manifest.json` hashlerini doğrular.
9. Kurulum yarıda kalırsa oluşturduğu hedef klasörü temizler.

## 12. `x-projesi` İçinde Oluşan Ana Yapı

Başarılı kurulumdan sonra özet yapı şöyledir:

```text
Projects/
  .pa/
    marketer-profile.md

  x-projesi/
    AGENTS.md
    PROJE.md
    DURUM.md
    KARARLAR.md
    README.md

    00-gelen-kutusu/
      yuklemeler/
    01-baglam/
    02-arastirma/
      fikir-degerlendirme/
      pazar-arastirmasi/
      rakip-arastirmasi/
      musteri-arastirmasi/
      trend-arastirmasi/
      store-intelligence/
        raw/
        snapshots/
    03-strateji/
      dogrulama/
      konumlandirma/
      fiyatlandirma/
      pazara-giris/
      buyume/
    04-urun/
      fikir-ozetleri/
      prd/
      coder-briefleri/
      urun-kararlari/
    05-haftalik-planlar/
      YYYY-WNN.md
      YYYY-WNN/
        schedule.md
        pazartesi.md
        sali.md
        carsamba.md
        persembe.md
        cuma.md
        cumartesi.md
        pazar.md
    06-pazarlama-uygulamalari/
      dijital/
      saha/
      hibrit/
    07-lansman/
    08-raporlar/
      haftalik/
      pazarlama/
      analitik/
      yatirimci/
      finansal/
      pdf/
      excel/
    09-varliklar/
    10-final/
      prd/
      coder-briefleri/
      raporlar/
      yatirimci/
      lansman/
      dijital/
      saha/
      hibrit/
      linkler.md
    11-notlar/
      bilgi-haritasi/
        index.md
        log.md
        sayfalar/
    99-arsiv/

    .pa/
      project/
        state.json
        active-task.md
        marketer-profile.md
        settings.json
        overrides.md
        overrides-approved.md
      agent/
        AGENTS.md
        release-manifest.json
        agent-version.json
        ...
      agent-install.json
```

## 13. Proje Workspace'ine Geçiş

Kurulumdan sonra ana `Projects/` workspace'inde gerçek çalışmaya devam etmeyin.

1. Codex App'te yeni workspace/root olarak şunu açın:

```text
Projects/x-projesi/
```

2. Bu proje için yeni bir Codex thread başlatın.
3. Kök `AGENTS.md` bootstrap dosyasının `.pa/agent/AGENTS.md` sözleşmesini yüklemesine izin verin.
4. Bootstrap'ın `.pa/project/marketer-profile.md` dosyasını varsa okuduğunu doğrulayın.

İlk proje promptu:

```text
Bu PersonalAutonomy proje workspace'ini kontrol et.
Önce PROJE.md, DURUM.md, KARARLAR.md ve .pa/project/state.json kimliklerini doğrula.
Ardından fikri gerçekçi ve kanıta dayalı biçimde değerlendir.
Fikir doğrulanmadan PRD, lansman veya final teslim üretme.
```

Fikir değerlendirme çıktıları ayrı workspace'e değil şu alanlara yazılır:

```text
02-arastirma/fikir-degerlendirme/
03-strateji/dogrulama/
KARARLAR.md
DURUM.md
11-notlar/bilgi-haritasi/
```

## 14. Kurulumun Başarılı Olduğunu Doğrulama

Şunların tamamı doğru olmalıdır:

- `Projects/x-projesi/PROJE.md` vardır.
- `Projects/x-projesi/.pa/project/state.json` vardır.
- İki dosyadaki `project_id` ve `idea_id` aynıdır.
- `Projects/x-projesi/.pa/agent/AGENTS.md` vardır.
- `Projects/x-projesi/.pa/agent/release-manifest.json` vardır.
- `Projects/x-projesi/AGENTS.md` PersonalAutonomy bootstrap dosyasıdır.
- `Projects/.pa/marketer-profile.md` varsa proje içine kopyalanmıştır.
- Projedeki profil kopyası ana profildeki gönüllü ek kullanıcı bağlamını da eksiksiz içerir.
- Proje `AGENTS.md` dosyası `.pa/project/marketer-profile.md` dosyasına referans verir.
- Ayrı evaluation workspace işaretleri yoktur.
- Haftalık plan ve günlük schedule dosyaları oluşmuştur.
- `11-notlar/bilgi-haritasi/index.md` ve `log.md` oluşmuştur.

Bu kontrollerden biri başarısızsa proje üzerinde çalışmaya başlamayın. Hatalı klasörü elle
tamamlamak yerine resmi create scriptini temiz, boş bir hedefte yeniden çalıştırın.

## 15. Kaynaklar

- Codex skills ve MCP yapılandırması:
  `https://developers.openai.com/codex/codex-manual.md`
- Superpowers Codex App kurulumu:
  `https://github.com/obra/superpowers`
- Microsoft Playwright MCP:
  `https://github.com/microsoft/playwright-mcp`
