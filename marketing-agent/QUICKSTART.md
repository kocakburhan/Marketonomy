# Marketing Agent - Codex App Hizli Baslangic

## Kurulum Mantigi

Bu klasor tek basina gercek proje workspace'i degildir. Ilk product fazi Codex + Google Drive
first modelidir: marketer Google Drive ile senkronize edilen yerel klasorde onayli create
scriptleriyle workspace olusturur, olusan workspace'i Codex root olarak acar ve agent bu dosya
sistemi uzerinden calisir. Web app is deferred; ilk fazda agent kullanimi icin zorunlu degildir.

Kurulumdan sonra hedef workspace'te:

- kok `AGENTS.md` bootstrap dosyasi bulunur,
- asil agent paketi `.pa/agent/` altinda bulunur,
- asil davranis talimati `.pa/agent/AGENTS.md` dosyasindan okunur,
- `.pa/agent-install.json` dosyasi kurulum kaynagini ve guncelleme politikasini saklar.

## Yeni Workspace

Yeni degerlendirme veya proje klasorlerini elle olusturma. Marketer'in Drive ile senkronize
edilen uygun ust klasorunde onayli PowerShell create scriptini calistir.

Evaluation workspace:

```powershell
.\scripts\create-evaluation.ps1 -TargetRoot "G:\Drive\PersonalAutonomy\idea-workspace\ornek-fikir" -Title "Ornek Fikir" -SourceAgentRoot .\marketing-agent
```

Project workspace:

```powershell
.\scripts\create-project.ps1 -TargetRoot "G:\Drive\PersonalAutonomy\projects\ornek-proje" -Title "Ornek Proje" -SourceAgentRoot .\marketing-agent
```

Scriptler `idea_id` ve `project_id` degerlerini approved create flow ile uretir; istenirse
parametre olarak verilebilir. Scriptin basari mesajindan sonra olusan klasoru yeni Codex root
olarak ac.

Installer yalnizca kimlik dosyasi ile state kimlikleri eslesen gecerli bir project veya
evaluation workspace'ine kurulur. Yanlis veya bos klasore agent paketi birakmaz.

## Guncelleme Mantigi

Drive bu etapta agent guncelleme kaynagi degildir. Kurulu workspace kendi icindeki
`.pa/agent-install.json` dosyasindan GitHub repo bilgisini okur. Her yeni oturumda Codex once
`.pa/agent/scripts/check-update.ps1` ile kontrol yapar. Yeni surum varsa kullaniciya sorar.
Kullanici onayi olmadan guncelleme yapilmaz.

Onaydan sonra:

```powershell
.\.pa\agent\scripts\update-agent.ps1 -TargetRoot . -Yes
```

Guncelleme yalnizca `.pa/agent/` paketini degistirir. `PROJE.md`, `DURUM.md`, `KARARLAR.md`,
calisma ciktilari, `.pa/project/` ve `.pa/evaluation/` korunur.

## Marketer Promptu

```text
Bu klasor PersonalAutonomy proje workspace'i.

Su resmi GitHub reposundaki PersonalAutonomy Marketing Agent'i bu projeye kur:
<GITHUB_REPO_URL>

Kurulumu serbest elle yapma. Repodaki scripts/install-marketing-agent.ps1 installer'ini kullan.
Installer'i -RepoUrl <GITHUB_REPO_URL> -Version latest parametreleriyle calistir.
Hedef proje koku su anda Codex'te acik olan klasordur.

Kurulumdan sonra .pa/agent/ paketini, kok AGENTS.md bootstrap dosyasini ve
release-manifest.json dogrulamasini kontrol et. Var olan proje dosyalarimi silme.
```

## Kullanici Akisi

1. Google Drive for desktop senkronizasyonunun tamamlandigini kontrol et.
2. Gercek calisma icin ilgili fikir degerlendirme veya proje klasorunu Codex root olarak ac.
3. Her workspace icin ayri bir Codex thread baslat.
4. Marketing Agent kurulu degilse yukaridaki kurulum promptunu kullan.
5. Kurulumdan sonra dogal dille hedefini yaz: "Bu fikri degerlendir", "Bu hafta icin plan
   hazirla" veya "B2B coder brief olustur" gibi.
6. Codex'in belirttigi kaynak dosyalari, cikti yolunu ve bekleyen onayi incele.

Ust `idea-workspace/` veya `projects/` klasorunu analiz root'u olarak kullanma. Bu klasorler
yalnizca mevcut workspace'leri listelemek ve onayli create scriptini calistirmak icindir.

## Calisma Esnekligi

Marketing Agent her istegi pipeline'a zorlamaz:

- `Quick advisory`: kisa soru, aciklama veya degerlendirme; dosya ve state degismez.
- `Workspace task`: tek ve somut cikti; yalnizca ilgili dosyalar guncellenir.
- `Pipeline mode`: cok asamali, kanit-agir veya ozellikle siki yurutulmesi istenen calisma.

Mevcut projelerde dogrulama eksik olsa bile dusuk riskli taslaklar ve acil taktik isler
yapilabilir; varsayimlar acikca yazilir. Yuksek maliyetli, geri dondurulemez, hukuken hassas
veya final yayin kararlar gerekli kanit ve onay olmadan ilerletilmez.

## Ilk Proje Calismasi

1. `PROJE.md` ve `01-baglam/` dosyalarini agent ile tamamla.
2. Drive senkronizasyonu ve gerekiyorsa manuel paylasim durumunu kontrol et.
3. `Europe/Istanbul` tarihine gore aktif ISO haftalik plani kalan gunler icin doldur.
4. Ciktilari numarali proje klasorlerinde uret.
5. Workspace dosyasi isi acikca kanitliyorsa agent gorevi otomatik kapatir ve seni
   bilgilendirir. Harici aksiyonlarda tamamladigini sen bildirirsin; final yayin veya teslim icin
   acik onay verirsin.

## Durum Uzlastirma

Kimlik veya operasyonel durumdan suphelenirsen kurulu workspace kokunde:

```powershell
.\.pa\agent\scripts\reconcile-workspace-state.ps1 -WorkspaceRoot .
```

Bu script read-only rapor verir; gizli onarim yapmaz.

## Dis Araclar

Codex'te etkin olan Browser, Chrome, web veya MCP araclari kullanilabilir. `mcps.json` yalnizca
capability envanteridir. Bir arac gorunmuyorsa kurulu varsayilmaz; agent alternatif script veya
manuel veri listesi sunar.

## Saglik Kontrolu

Kurulu agent paketinde:

```powershell
.\.pa\agent\scripts\healthcheck.ps1 -AgentRoot .\.pa\agent
.\.pa\agent\scripts\test_mvp_compatibility.ps1 -AgentRoot .\.pa\agent
```

Bir kimlik, release, state veya erisim hatasi giderilemiyorsa tekrar tekrar denemek yerine
gosterilen sanitize edilmis log adiyla Yonetici Burhan Kocak'a basvur.
