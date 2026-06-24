# Projects Root Onboarding v5.5.0 Design

## Amaç

Elinde yalnızca Marketonomy GitHub repo URL'si bulunan marketer'ın boş bir Google Drive
`Projects/` klasörünü kalıcı bir onboarding workspace'ine dönüştürmesini sağlamak. Ana kök yalnızca
onboarding, plugin/MCP kontrolü, reusable marketer profili ve proje oluşturma için kullanılacak.

## Projects Kök Yapısı

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
  x-projesi/
```

`Projects/AGENTS.md` ince bootstrap'tır. Her oturumda `onboarding-guide.md` dosyasını okutur,
proje çıktılarının ana köke yazılmasını engeller ve update işlemlerini kullanıcı onayına bağlar.

`Projects/onboarding-guide.md`, canonical
`marketing-agent/agents/onboarding-guide.md` dosyasının doğrulanmış kopyasıdır. İkinci bağımsız
bir onboarding metni tutulmaz.

## Marketer Profili

Profilin ana kaynağı `Projects/.pa/marketer-profile.md` olur. Altı mevcut soruya yedinci açık uçlu
soru eklenir:

> Sizi daha iyi tanıyabilmem için eklemek istediğiniz herhangi bir şey var mı? Örneğin çalışma
> biçiminizi etkileyen "otistiğim", "ADHD'im var" veya benzeri bir bilgiyi yalnızca paylaşmak
> isterseniz belirtebilirsiniz.

Bu alan isteğe bağlıdır. Agent teşhis istemez, çıkarım yapmaz ve paylaşılmayan sağlık bilgisini
tahmin etmez. Kullanıcının gönüllü verdiği ek bilgiler `Ek kullanıcı bağlamı` başlığı altında
olduğu gibi saklanır ve yalnızca çalışma biçimini kişiselleştirmek için kullanılır.

`create-project.ps1/.sh`, ana profili yeni projenin
`.pa/project/marketer-profile.md` yoluna kopyalar. Proje bootstrap `AGENTS.md`, başlangıçta bu
dosyayı varsa okumasını Codex'e açıkça söyler.

## Installer

`scripts/install-projects-root.ps1` ve `scripts/install-projects-root.sh`:

1. Hedefin klasör olduğunu ve proje workspace'i olmadığını doğrular.
2. Repo URL'sinden `latest` veya sabit semver tag'ini çözer.
3. Kaynak Marketing Agent manifestini doğrular.
4. Onboarding guide, bootstrap ve update scriptlerini staging alanında hazırlar.
5. Yönetilen dosyaları atomik olarak yayınlar.
6. Mevcut marketer profilini ve proje klasörlerini değiştirmez.
7. `.pa/onboarding-install.json` içine repo ve sürüm bilgisini yazar.

## Update

`check-update` salt okunurdur. `update-onboarding` açık `-Yes`/`--yes` onayı olmadan çalışmaz.
Update yalnızca onboarding tarafından yönetilen dosyaları değiştirir; marketer profili ve projeler
korunur.

## Sürüm ve Yayın

Release sürümü `v5.5.0` olacaktır. Kod, doküman, manifest ve testler tamamlandıktan sonra `main`
push edilecek, annotated tag oluşturulacak ve gerçek GitHub Release yayınlanacaktır.

## Doğrulama

- Projects root install/update regresyon testi
- Project create ve marketer profile kopyalama testi
- Proje bootstrap profile referansı testi
- macOS script sözleşme testi
- MVP compatibility ve healthcheck
- Manifest doğrulaması
- Temiz `v5.5.0` GitHub tag kurulum smoke testi
- GitHub Release API doğrulaması
