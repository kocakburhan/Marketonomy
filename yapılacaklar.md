# Marketing Agent Teslim ve Pilot Yapılacaklar

Bu dosya, güncel tek `Projects/` sözleşmesine göre Marketing Agent'i marketer'lara teslim etmeden
önce tamamlanacak operasyonel kontrolleri izler.

> Güncel modelde ayrı evaluation workspace ve `create-evaluation.ps1` yoktur. Fikir
> değerlendirme, `Projects/<proje-adi>/` içindeki bir çalışma modudur.

## 1. Repo ve Release Hazırlığı

- [x] Ana mimariyi `mvp/mvp.md` ile doğrula.
- [x] Ayrı evaluation create scriptinin bulunmadığını doğrula.
- [x] Windows ve macOS create/install akışlarının bulunduğunu doğrula.
- [x] Zorunlu testlerin tamamını güncel worktree üzerinde yeniden çalıştır:
  - [x] `.\marketing-agent\scripts\test_mvp_compatibility.ps1 -AgentRoot .\marketing-agent`
  - [x] `.\marketing-agent\scripts\healthcheck.ps1 -AgentRoot .\marketing-agent`
  - [x] `.\scripts\test_marketing_agent_workspace_create.ps1`
  - [x] `.\scripts\test_marketing_agent_install_update.ps1`
  - [x] `.\scripts\test_marketing_agent_macos_scripts.ps1`
  - [x] `git diff --check`
- [x] Pilot için kullanılacak GitHub repo URL'sini kesinleştir:
  `https://github.com/kocakburhan/Marketonomy.git`
- [x] Pilot sürümünü kesinleştir:
  - [x] Tekrarlanabilir pilot için sabit `v5.5.0` release tag'ini kullan.
  - [ ] Geliştirme ortamında özellikle isteniyorsa `latest` kullan.
- [x] Son değişiklikleri commit et, `main` dalına push et ve `v5.5.0` GitHub Release'ini yayınla.
- [x] Remote `v5.5.0` tag'inden temiz Projects root ve `x-projesi` smoke testini tamamla.

## 2. Marketer Bilgisayarı Hazırlığı

- [ ] Codex App kurulu ve kullanıcı hesabıyla açık mı kontrol et.
- [ ] Git kurulu mu kontrol et: `git --version`
- [ ] Google Drive for desktop kurulu ve senkronizasyon tamamlanmış mı kontrol et.
- [ ] Node.js 18 veya üzeri kurulu mu kontrol et: `node --version`
- [ ] Codex App içindeki resmi plugin marketplace'ten `Superpowers` pluginini kur.
- [ ] Codex'i yeniden başlat ve Superpowers skilllerinin görünür olduğunu doğrula.
- [ ] Playwright MCP'yi kur:

```powershell
codex mcp add playwright -- npx "@playwright/mcp@latest"
```

- [ ] Codex'i yeniden başlat ve Playwright MCP'nin aktif araçlar arasında göründüğünü doğrula.
- [ ] Google Drive, Calendar, Gmail, Canva, Figma ve GitHub bağlantılarını marketer ihtiyacına
  göre kur veya eksik olanları kaydet.

## 3. Google Drive Ana `Projects` Klasörü

- [ ] Marketer'ın Google Drive alanında tek ana klasörü oluştur:

```text
Projects/
```

- [ ] Bu klasörü Codex App'te ilk workspace/root olarak aç.
- [ ] Ana `Projects/` klasörünün yalnızca onboarding, plugin kontrolü, reusable marketer profili
  ve yeni proje oluşturma için kullanılacağını marketer'a anlat.
- [ ] Gerçek proje çıktılarının doğrudan ana `Projects/` klasörüne yazılmadığını doğrula.
- [ ] Marketer'ın yalnızca yetkili olduğu proje klasörlerine eriştiğini doğrula.

## 4. Ana Onboarding ve Reusable Marketer Profili

- [ ] Marketer'a `ilk kurulum.md` içindeki ana kurulum promptunu ver.
- [ ] Resmi `install-projects-root.ps1/.sh` akışının `Projects/AGENTS.md`,
  `Projects/onboarding-guide.md` ve `.pa/onboarding/` dosyalarını kurduğunu doğrula.
- [ ] Codex'in proje-local `.pa/agent/` paketini doğrudan `Projects/` köküne kurmaya çalışmadığını
  doğrula.
- [ ] Profil sorularını tamamla veya paylaşılmak istenmeyen alanları açıkça işaretle.
- [ ] Kalıcı profil dosyasının oluştuğunu doğrula:

```text
Projects/
  AGENTS.md
  onboarding-guide.md
  .pa/
    marketer-profile.md
    onboarding-install.json
    onboarding/
      scripts/
```

- [ ] Profil dosyasına secret, parola, erişim anahtarı veya gereksiz hassas veri yazılmadığını
  kontrol et.
- [ ] Yedinci açık uçlu soruda marketer'ın gönüllü paylaştığı ek bağlamın
  `Ek kullanıcı bağlamı` altında saklandığını doğrula.
- [ ] Superpowers ve Playwright MCP kurulumlarının `Projects/` içine dosya yazmadığını; bunların
  Codex'in kullanıcı düzeyi plugin/config alanında yaşadığını doğrula.

## 5. İlk Project Workspace Pilotu

- [ ] Ana `Projects/` klasörü açıkken şu isteği ver:

```text
x-projesi isminde yeni bir PersonalAutonomy proje workspace'i oluştur.
```

- [ ] Codex'in repo kaynağını geçici bir klasöre indirdiğini ve resmi create scriptini kullandığını
  doğrula:
  - [ ] Windows: `scripts/create-project.ps1`
  - [ ] macOS: `scripts/create-project.sh`
- [ ] `create-evaluation.ps1`, `idea-workspace/`, `DEGERLENDIRME.md` veya `.pa/evaluation/`
  oluşturulmadığını doğrula.
- [ ] Script başarı mesajında `Path`, `project_id` ve `idea_id` değerlerini kontrol et.
- [ ] `Projects/x-projesi/` klasörünün oluştuğunu doğrula.
- [ ] Ana marketer profilinin `.pa/project/marketer-profile.md` yoluna kopyalandığını doğrula.
- [ ] Proje kök `AGENTS.md` dosyasının `.pa/project/marketer-profile.md` dosyasını okumaya
  yönlendirdiğini doğrula.
- [ ] `.pa/agent/` paketinin ve kök `AGENTS.md` bootstrap dosyasının oluştuğunu doğrula.
- [ ] `release-manifest.json` hash doğrulamasının başarılı olduğunu doğrula.
- [ ] Yarım kurulum hatasında `x-projesi` klasörünün temizlendiğini doğrula.

## 6. Proje İçi Fikir Değerlendirme Pilotu

- [ ] `Projects/x-projesi/` klasörünü yeni Codex workspace/root olarak aç.
- [ ] Bu proje için yeni bir Codex thread başlat.
- [ ] İlk promptu dene:

```text
Bu projedeki fikri önce gerçekçi ve kanıta dayalı biçimde değerlendir. Fikir doğrulanmadan PRD,
lansman veya final teslim üretme.
```

- [ ] Fikir değerlendirme çıktılarının proje içinde kaldığını doğrula:
  - [ ] `02-arastirma/fikir-degerlendirme/`
  - [ ] `03-strateji/dogrulama/`
  - [ ] `KARARLAR.md`
  - [ ] `DURUM.md`
  - [ ] `11-notlar/bilgi-haritasi/`
- [ ] Kararın `Denenmeye Değer`, `Revizyonla Denenmeye Değer` veya `Denenmeye Değmez`
  biçimlerinden biriyle, kanıt ve durdurma koşuluyla verildiğini doğrula.
- [ ] Sonuç olumsuzsa proje klasörünün silinmediğini doğrula.

## 7. Project Workspace Gerçek Kullanım Testleri

- [ ] Aşağıdaki istekleri tek tek dene:

```text
Bu projede eksikleri kontrol et.
```

```text
Bu hafta için Balanced plan çıkar.
```

```text
Landing page metni hazırla.
```

```text
B2B outbound cold email ve follow-up dizisi hazırla.
```

```text
Rakip araştırması yap ve kaynak/kanıt defteriyle raporla.
```

```text
Bu işi final teslim olarak hazırlama, önce taslak üret.
```

- [ ] Dosyaların canonical klasörlere yazıldığını doğrula.
- [ ] Workspace artifact'i kanıtlı görevleri otomatik kapatıyor mu kontrol et.
- [ ] Harici aksiyonlarda kullanıcı bildirimi bekleniyor mu kontrol et.
- [ ] Final yayın veya teslim için açık kullanıcı onayı isteniyor mu kontrol et.
- [ ] Eksik tool/plugin/MCP olduğunda sahte veri yerine manuel fallback sunuluyor mu kontrol et.

## 8. Update ve Kullanıcı Verisi Koruma Testi

- [ ] `.pa/agent/scripts/check-update.ps1` veya `.sh` ile salt-okunur update kontrolü yap.
- [ ] Kullanıcı onayı olmadan update yapılmadığını doğrula.
- [ ] Onaylı update'i ilgili `update-agent` scriptiyle çalıştır.
- [ ] Update sonrasında şu alanların korunduğunu doğrula:
  - [ ] `PROJE.md`
  - [ ] `DURUM.md`
  - [ ] `KARARLAR.md`
  - [ ] `.pa/project/`
  - [ ] numbered proje klasörleri
  - [ ] araştırmalar, notlar, haftalık planlar ve final çıktılar

## 9. Pilot Sonrası Değerlendirme

- [ ] Marketer yalnızca repo URL'siyle sıfırdan kurulumu tamamlayabildi mi?
- [ ] Ana `Projects/` ile `Projects/x-projesi/` ayrımı anlaşıldı mı?
- [ ] Superpowers ve Playwright MCP kurulumu anlaşılır mıydı?
- [ ] Fikir değerlendirme ayrı workspace aramadan proje içinde başladı mı?
- [ ] Drive senkronizasyon gecikmesinde kullanıcı ne yapacağını bildi mi?
- [ ] Marketing, satış, lansman, growth, analytics ve yatırımcı hazırlığı akışları kullanılabildi mi?
- [ ] Pilot bulgularını ve gerçek blokajları kaydet.

## 10. Teslim Kararı

- [ ] Pilot blokajlarını repo içinde düzelt.
- [x] Manifest gerektiren release-surface değişikliklerinde manifesti yenile.
- [x] Tüm zorunlu testleri tekrar çalıştır.
- [x] Son `v5.5.0` release/tag/push işlemini tamamla.
- [x] Marketer teslim paketi için `ilk kurulum.md`, repo URL'si ve kullanılacak sürümü hazırla.
