# Marketing Agent - Codex App Hizli Baslangic

## Kullanici Akisi

1. Google Drive for desktop senkronizasyonunun tamamlandigini kontrol et.
2. Gercek calisma icin ilgili fikir degerlendirme veya proje klasorunu Codex root olarak ac.
3. Her workspace icin ayri bir Codex thread baslat.
4. Dogal dille hedefini yaz: "Bu fikri degerlendir", "Bu hafta icin plan hazirla" veya
   "B2B coder brief olustur" gibi.
5. Codex'in belirttigi kaynak dosyalari, cikti yolunu ve bekleyen onayi incele.

Ust `idea-workspace/` veya `projects/` klasorunu analiz root'u olarak kullanma. Bu klasorler
yalnizca mevcut workspace'leri listelemek ve onayli create scriptini calistirmak icindir.

## Yeni Workspace

Yeni degerlendirme veya proje klasorlerini elle olusturma. Web app'ten gelen degismez
kimliklerle, marketer'in kendi ust klasorunde onayli PowerShell scriptini Codex'e
calistirt. Scriptin basari mesajindan sonra olusan klasoru yeni Codex root olarak ac.

## Ilk Proje Calismasi

1. `PROJE.md` ve `01-baglam/` dosyalarini agent ile tamamla.
2. Web app Drive aktivasyon checklist'ini tamamla.
3. `Europe/Istanbul` tarihine gore aktif ISO haftalik plani kalan gunler icin doldur.
4. Ciktilari numarali proje klasorlerinde uret.
5. Bir isi tamamladiginda agent'in haftalik gorevi kapatabilmesi icin acik onay ver.

## Dis Araclar

Codex'te etkin olan Browser, Chrome, web veya MCP araclari kullanilabilir. `mcps.json`
yalnizca capability envanteridir. Bir arac gorunmuyorsa kurulu varsayilmaz; agent alternatif
script veya manuel veri listesi sunar.

## Saglik Kontrolu

Release paketinde:

```powershell
.\scripts\healthcheck.ps1
.\scripts\test_mvp_compatibility.ps1
```

Bir kimlik, release, state veya erisim hatasi giderilemiyorsa tekrar tekrar denemek yerine
gosterilen sanitize edilmis log adiyla Yonetici Burhan Kocak'a basvur.
