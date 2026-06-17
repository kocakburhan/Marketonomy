# Marketing Agent Architecture - Codex Release

## Vizyon

Marketer, bir degerlendirme veya proje klasorunu Codex root olarak acar ve tek ana agent ile
calisir. Ana agent ihtiyaca gore uzman playbook'larini, pipeline'lari ve skill'leri yukler;
butun kalici durumu PersonalAutonomy workspace dosyalarinda tutar.

```text
Kullanici
  -> Codex ana agent
      -> Orchestrator playbook
          -> Uzman rol playbook'lari
          -> Pipeline'lar
          -> Codex skill'leri ve mevcut araclar
      -> MVP workspace dosyalari
```

## Paket ve Workspace Ayrimi

`.pa/agent/` surumlenen ve merkezi release'ten guncellenen salt davranis paketidir:

```text
AGENTS.md
ARCHITECTURE.md
SKILLS.md
agents/
pipelines/
skills/
scripts/
templates/
mcps.json
release-manifest.json
agent-version.json
```

Kullanici verisi, proje gercekleri, kararlar ve operasyonel durum `.pa/agent/` icine yazilmaz.
Agent guncellemesi degerlendirmede `.pa/evaluation/`, projede `.pa/project/` ve tum kullanici
ciktilarini korur.

## Iki Workspace Turu

### Fikir degerlendirmesi

Kimlik ve kriterler `DEGERLENDIRME.md`, teknik durum `.pa/evaluation/`, ham girdiler
`kaynaklar/`, analizler `ciktilar/`, calisma raporu `RAPOR.md` icinde tutulur. Bu workspace
Project Pool oncesidir ve proje operasyon klasorlerini kullanmaz.

### Proje

Kimlik ve urun gercekleri `PROJE.md`, uzun omurlu baglam `01-baglam/`, kararlar
`KARARLAR.md`, operasyon `DURUM.md` ve `.pa/project/` icinde tutulur. Arastirmadan finale
tum ciktilar numarali MVP klasorlerine gider.

Proje dosya sistemi agent davranisinin merkezi parcasidir. Ana agent her cikti icin once
workspace turunu, sonra cikti turunu, sonra canonical hedef klasoru belirler. Ham kullanici
girdileri `00-gelen-kutusu/` icinde korunur; islenmis arastirma `02-arastirma/`, strateji
`03-strateji/`, urun dokumani `04-urun/`, haftalik plan `05-haftalik-planlar/`, uygulama
ciktilari `06-pazarlama-uygulamalari/`, lansman `07-lansman/`, raporlar `08-raporlar/`,
yeniden kullanilabilir varliklar `09-varliklar/`, onayli teslimler `10-final/` ve eski
versiyonlar `99-arsiv/` altinda tutulur. `.pa/agent/` icine kullanici verisi veya proje ciktisi
yazilmaz.

## Uzmanlik Modeli

11 uzman rolu korunur: onboarding, pazar arastirmasi, strateji, urun mimarisi, lansman,
icerik, buyume, outreach, analitik, marka ve kampanya. Bunlar bagimsiz veri depolari veya
zorunlu ayri islem veya runtime degil, Codex'in goreve gore okudugu odakli talimat dosyalaridir.

Codex subagent calismasi yalnizca kullanici acikca istediginde ya da ana talepte acikca
paralel agent kullanimi belirtildiginde uygulanir. Her durumda ana agent sonuclari workspace
sozlesmesine gore dogrular ve birlestirir.

## Pazarlama Kapsam Modeli

Release, pazarlama talebini tek bir kanal veya tek bir musteri tipine indirgemez. Orchestrator
her istekte musteri modelini, kanal modelini, yasam dongusu asamasini, pazar kapsamını ve satis
hareketini siniflandirir.

```text
Musteri modeli:
  B2B | B2C | Hibrit

Kanal modeli:
  Dijital | Fiziksel/Saha | Hibrit

Yasam dongusu:
  fikir -> dogrulama -> MVP/teklif -> pre-launch -> launch -> satis
  -> buyume -> retention -> feedback -> iyilestirme
```

Ana pipeline'lar tek basina yetmediginde birlestirilir. Ornegin B2B saha satisi
`outbound-sales` ile baslar ama etkinlik, fiziksel materyal veya yerel aktivasyon gerekiyorsa
`local-business-launch`, `content-machine`, `campaign-manager` ve `analytics-master` ciktılarıyla
tamamlanir. B2C fiziksel pazarlamada P9 ana akistir; dijital destek, buyume ve feedback
döngüleri gerektiğinde eklenir.

Bu nedenle uyumluluk, her senaryoda ayni dosya setinin uretilecegi anlamina gelmez. Dogru
uyumluluk; arastirma, strateji, teklif, kanal, materyal, uygulama, olcum ve iyilestirme
katmanlarinin proje tipine uygun ciktilara donusmesidir.

## Skill Modeli

Her `skills/<ad>/SKILL.md` Codex Agent Skills standardinda `name` ve `description`
frontmatter'i tasir. Skill metadata'si Codex'in gorevle eslestirmesi icindir; ayrintili
talimatlar yalnizca skill secildiginde yuklenir.

Canonical release kopyasi `.pa/agent/skills/` altindadir. Workspace olusturma veya release
dagitim scripti, Codex'in repo-scope skill kesfi icin destekledigi alana ayni skill'leri
ayrica yayinlayabilir. Paket, bu yayin olmadan da ana AGENTS.md talimatiyla canonical skill
dosyalarini acikca okuyarak calisir.

## Pipeline Durumu

Pipeline dosyalari hazir is akislaridir; kendi state deposunu olusturmaz. Aktif pipeline ve
adim insan tarafindan okunabilir bicimde `DURUM.md`, makine tarafindan okunabilir gereken
alanlariyla ilgili state JSON ve `active-task.md` icinde tutulur.

Gorev odakli haftalik takvim proje operasyonunun ana ritmidir. Her ISO hafta
`05-haftalik-planlar/YYYY-WNN.md` dosyasinda tutulur; plan Pazartesi-Pazar sinirlarini
`Europe/Istanbul` saat dilimine gore izler. Pipeline ve skill'ler bu dosyadaki gorevleri
ilerletebilir, ancak dosya uretimi gorev kapanisi sayilmaz. Gorev yalnizca kullanicinin acik
tamamlanma onayindan sonra `[x]` ve `Tamamlandi` olur; ertelenen veya iptal edilen gorevler
gerekcesiyle kaydedilir.

## Araclar ve MCP

Dis capability'ler Codex host tarafinda saglanir. `mcps.json`, gerekli veya opsiyonel
capability'leri ve manuel fallback'i tanimlar; kurulum kaniti degildir. Ana agent yalnizca
aktif arac listesinde gordugu capability'yi kullanir.

Web arastirmasinda mevcut resmi web, Browser veya Chrome araci kullanilir. Kaynaklar,
erisim tarihi ve kanit ile ciktida saklanir. Arac yoksa script veya manuel veri akisi secilir.

## Research ve Veri Isleme Omurgasi

Arastirma ve veri isleme release'in birinci sinif davranisidir. Agent sadece nihai yorum
uretmez; kaynak toplama, kanit defteri, ham veri korunumu, normalizasyon, analiz ve karar
etkisini ayri katmanlar olarak yurutur.

```text
Codex araclari / MCP / script / manuel export
  -> ham kaynak ve kanit notu
  -> normalize JSON/CSV/Markdown calisma verisi
  -> analiz, skor, tahmin ve karar etkisi
  -> RAPOR.md veya ilgili MVP cikti klasoru
```

Bu katmanlarin karismasi release hatasidir. Kaynaksiz sayisal iddia, arac listesinde
gorunmeyen capability varsayimi veya ham veriyi silen ozetleme Codex uyumlu kabul edilmez.

## Durum ve Onay Ilkeleri

- Dosya uretimi gorev tamamlanmasi degildir.
- Final teslim ve haftalik gorev kapanisi acik kullanici onayi ister.
- Proje davranis tercihi degisikligi `overrides.md`, `overrides-approved.md`, SHA-256 state ve
  `KARARLAR.md` kaydini birlikte gunceller.
- Proje gercekleri override dosyasina kopyalanmaz.
- Operasyonel zaman `Europe/Istanbul`, haftalar Pazartesi-Pazar ISO standardindadir.

## Hata Sinirlari

Kimlik uyusmazligi, bozuk workspace turu, okunamayan state veya gecersiz release normal
calismayi durdurur. Dis veri/arac eksigi ise kanitla belirtilir ve guvenli manuel fallback
sunulur. Hicbir durumda eksik veri uydurulmaz.
