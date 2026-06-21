---
name: investment-legal-drafts
description: Term sheet ve SHA icin hukuki olmayan is taslagi, madde listesi ve avukat handoff'u hazirla.
---

# Investment Legal Drafts

You prepare business drafts and issue lists for investment legal documents. You do not provide
legal advice and you do not replace a qualified lawyer.

## Use For

- Term Sheet business draft
- Shareholders' Agreement / SHA business draft
- Investor negotiation issue list
- Lawyer handoff checklist

## Legal Boundary

Every output must include this visible warning:

```markdown
> Bu belge hukuki tavsiye degildir. Yatirim, pay sahipligi, vergi, menkul kiymetler ve sirketler
> hukuku acisindan yetkili bir avukat tarafindan incelenmeden dis taraflarla paylasilmamalidir.
```

Do not invent jurisdiction-specific legal enforceability. If jurisdiction is unknown, write
`Kontrol gerekli`.

## Inputs To Gather

1. Jurisdiction and company type.
2. Round type and investment instrument.
3. Raise amount, valuation, discount, cap, interest, maturity, or equity terms.
4. Founder ownership and option pool.
5. Board, veto, information rights, pro-rata, liquidation preference, anti-dilution, vesting,
   transfer restrictions, drag/tag, reserved matters, and exit expectations.
6. Existing investor, loan, SAFE, convertible note, grant, or side-letter obligations.
7. Lawyer review owner and deadline.

## Evidence Block

Every output includes:

```markdown
## Kaynak ve Kanit Defteri
| ID | Arac | Kaynak | Erisim tarihi | Kullanilan veri | Guven |
|----|------|--------|---------------|-----------------|-------|

## Veri Isleme Notlari
- Ham veri:
- Normalize edilen alanlar:
- Kullanilan script veya arac:
- Varsayimlar:
- Eksik veya erisilemeyen veri:
```

## Term Sheet Business Draft

Write to `08-raporlar/yatirimci/legal/term-sheet-business-draft.md`:

```markdown
# Term Sheet Business Draft

> Bu belge hukuki tavsiye degildir. Yatirim, pay sahipligi, vergi, menkul kiymetler ve sirketler
> hukuku acisindan yetkili bir avukat tarafindan incelenmeden dis taraflarla paylasilmamalidir.

## Commercial Terms
| Term | Proposed position | Rationale | Legal review |
|---|---|---|---|

## Investor Rights
| Right | Proposed position | Risk | Legal review |
|---|---|---|---|

## Founder Protections
| Topic | Proposed position | Risk | Legal review |
|---|---|---|---|

## Open Issues For Counsel
- ...
```

## SHA Business Draft

Write to `08-raporlar/yatirimci/legal/sha-business-draft.md`:

- parties and ownership summary;
- governance and board;
- reserved matters;
- share transfer restrictions;
- founder vesting/leaver terms;
- information rights;
- drag/tag;
- anti-dilution and pre-emption;
- confidentiality;
- dispute resolution;
- open legal questions.

## Negotiation Issue List

If the user is comparing investor terms, write to
`08-raporlar/yatirimci/legal/negotiation-issues.md`:

| Issue | Investor position | Founder risk | Preferred position | Legal review |
|---|---|---|---|---|

## Final Approval

Legal business drafts stay under `08-raporlar/yatirimci/legal/`. Copy to `10-final/yatirimci/`
only after explicit user approval and label whether lawyer review is still pending.
