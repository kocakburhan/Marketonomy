# Marketing Agent Teslim ve Pilot Yapilacaklar

Bu dosya, Marketing Agent'i marketer'lara teslim etmeden once kalan operasyonel isleri adim adim
takip etmek icindir.

## 1. Repo ve Release Hazirligi

- [x] Son script/onboarding duzeltmelerini tekrar gozden gecir.
- [x] Zorunlu testleri tekrar calistir:
  - [x] `.\marketing-agent\scripts\test_mvp_compatibility.ps1 -AgentRoot .\marketing-agent`
  - [x] `.\marketing-agent\scripts\healthcheck.ps1 -AgentRoot .\marketing-agent`
  - [x] `.\scripts\test_marketing_agent_workspace_create.ps1`
  - [x] `.\scripts\test_marketing_agent_install_update.ps1`
  - [x] `git diff --check`
- [x] Degisiklikleri commit et.
- [x] Commit'i GitHub'a push et.
- [x] Release stratejisini netlestir:
  - [ ] Pilot `main` uzerinden mi kurulacak?
  - [x] Yoksa `v5.4.2` gibi temiz bir release tag'i mi olusturulacak?
- [x] Tag kullanilacaksa tag'i olustur ve push et.

## 2. Google Drive Ana Klasor Kurulumu

- [ ] Sistem sahibinin Google Drive hesabinda ana klasoru olustur:

```text
PersonalAutonomy/
  shared/
    tools/
      create-evaluation.ps1
      create-project.ps1
    templates/
    logs/

  marketers/
    <marketer-adi>/
      .pa/
        marketer-profile.md
      .pa-create-work/
      .pa-script-logs/
      idea-workspace/
      projects/
```

- [ ] Ana `PersonalAutonomy/` klasorunu herkese acma.
- [ ] Her marketer'a yalnizca kendi `marketers/<isim>/` klasorunu paylas.
- [ ] Coder'lara kisisel workspace verme; sadece katildiklari proje klasorleri paylasilacak.
- [ ] Google Drive for desktop senkronizasyonunun marketer bilgisayarinda calistigini dogrula.

## 3. Resmi Scriptlerin Drive'a Konmasi

- [ ] Guncel `scripts/create-evaluation.ps1` dosyasini `shared/tools/` altina koy.
- [ ] Guncel `scripts/create-project.ps1` dosyasini `shared/tools/` altina koy.
- [ ] Scriptlerin Drive'da yanlis veya eski kopyalari kalmadi mi kontrol et.
- [ ] Marketer'a workspace klasorlerini elle olusturmamasi, sadece script kullanmasi gerektigini soyle.

## 4. Marketer Base Profile Hazirligi

- [ ] Her marketer icin profil dosyasi yolunu olustur:

```text
marketers/<isim>/.pa/marketer-profile.md
```

- [ ] Profil onceden biliniyorsa temel bilgileri gir.
- [ ] Profil bilinmiyorsa dosyayi bos birak veya onboarding'in ilk kullanimda sormasina izin ver.
- [ ] Profil dosyasina teknik log, secret veya hassas gereksiz veri yazma.

## 5. Ilk Evaluation Workspace Pilotu

- [ ] Pilot marketer icin bir ornek fikir sec.
- [ ] Evaluation workspace'i create script ile olustur:

```powershell
.\shared\tools\create-evaluation.ps1 `
  -TargetRoot "...\PersonalAutonomy\marketers\ayse\idea-workspace\ornek-fikir" `
  -Title "Ornek Fikir" `
  -RepoUrl "<GITHUB_REPO_URL>" `
  -Version v5.4.2
```

- [ ] Script basari mesajinda `Path` ve `idea_id` degerlerini kontrol et.
- [ ] Olusan klasoru Codex root olarak ac.
- [ ] Ilk Codex promptunu dene:

```text
Merhaba, ilk kez kullanıyorum. Bu fikri Marketing Agent ile değerlendirmek istiyorum.
```

- [ ] Onboarding akisini kontrol et:
  - [ ] Workspace tipini dogru anlatiyor mu?
  - [ ] Profil varsa tekrar uzun form sormuyor mu?
  - [ ] Profil yoksa kisa ve anlasilir form soruyor mu?
  - [ ] Capability menu marketer'i bogmadan yeterince yonlendiriyor mu?
- [ ] Fikir degerlendirme akisini kontrol et:
  - [ ] Once fikrin degerini tartisiyor mu?
  - [ ] Marketer avantajini verdict degil uygulama rehberligi olarak ele aliyor mu?
  - [ ] Ciktilari `ciktilar/`, `RAPOR.md`, `DURUM.md` icine yaziyor mu?
  - [ ] Evaluation workspace icinde MVP/PRD/coder brief uretmeye kalkmiyor mu?

## 6. Ilk Project Workspace Pilotu

- [ ] Evaluation sonucu pozitifse project workspace'i create script ile olustur:

```powershell
.\shared\tools\create-project.ps1 `
  -TargetRoot "...\PersonalAutonomy\marketers\ayse\projects\ornek-proje" `
  -Title "Ornek Proje" `
  -IdeaId "<evaluation idea_id>" `
  -RepoUrl "<GITHUB_REPO_URL>" `
  -Version v5.4.2
```

- [ ] Script basari mesajinda `project_id` ve `idea_id` degerlerini kontrol et.
- [ ] Olusan proje klasorunu Codex root olarak ac.
- [ ] Baslangic dosyalarini kontrol et:
  - [ ] `PROJE.md`
  - [ ] `DURUM.md`
  - [ ] `KARARLAR.md`
  - [ ] `.pa/project/state.json`
  - [ ] `.pa/agent/AGENTS.md`
  - [ ] `05-haftalik-planlar/YYYY-WNN.md`
  - [ ] `05-haftalik-planlar/YYYY-WNN/schedule.md`
  - [ ] gunluk schedule dosyalari

## 7. Project Workspace Gercek Kullanim Testleri

- [ ] Codex'te su istekleri tek tek dene:

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

- [ ] Dosyalar dogru canonical klasorlere yaziliyor mu kontrol et.
- [ ] `DURUM.md`, active task ve haftalik plan gereksiz yere sisirilmiyor mu kontrol et.
- [ ] Workspace artifact'i kanitli gorevleri otomatik kapatiyor mu kontrol et.
- [ ] Harici aksiyon gerektiren islerde kullanici bildirimi bekliyor mu kontrol et.
- [ ] Final teslim icin acik onay istiyor mu kontrol et.

## 8. Update ve Koruma Testi

- [ ] Project workspace icinde `.pa/agent/scripts/check-update.ps1` ile update kontrolu dene.
- [ ] Yeni surum varsa kullanici onayi olmadan update yapmiyor mu kontrol et.
- [ ] Onayli update icin `.pa/agent/scripts/update-agent.ps1 -Yes` calistir.
- [ ] Update sonrasi su alanlarin korundugunu kontrol et:
  - [ ] `PROJE.md`
  - [ ] `DURUM.md`
  - [ ] `KARARLAR.md`
  - [ ] `.pa/project/`
  - [ ] proje ciktilari
  - [ ] haftalik plan dosyalari

## 9. Pilot Sonrasi Degerlendirme

- [ ] Marketer ilk kullanimda rahat ilerledi mi?
- [ ] Yanlis klasorde acarsa 3 secenekli kurtarma akisi anlasilir mi?
- [ ] Fikir tartismasi tutarli ve gercekci mi?
- [ ] Marketer kendini kisitlanmis degil desteklenmis hissediyor mu?
- [ ] Drive sync yavasliginda kullanici ne yapacagini anliyor mu?
- [ ] Agent eksik tool/plugin durumunda fake veri uretmeden manuel fallback veriyor mu?
- [ ] Proje marketing asamalarinda content, satis, launch, growth, analytics, investor hazirligi gibi alanlarda yeterince yardimci oluyor mu?

## 10. Teslim Karari

- [ ] Pilot bulgularini toparla.
- [ ] Varsa kucuk pürüzleri repo icinde duzelt.
- [ ] Testleri tekrar calistir.
- [ ] Son release/tag/push islemini yap.
- [ ] Marketer'lara kurulum promptu ve kisa kullanim notunu ver.
