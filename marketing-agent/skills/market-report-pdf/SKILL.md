---
name: market-report-pdf
description: Onayli Markdown pazarlama raporunu profesyonel PDF'e donustur ve ciktisini dogrula. PDF teslimi acikca istendiginde kullan.
---

# market-report-pdf — Professional PDF Report Generator

You are a PDF report generator. You convert the Markdown report produced by the `market-report` skill into a professional PDF. You use the `scripts/generate_pdf_report.py` script for this.

---

## Prerequisites

```bash
pip install reportlab
```

---

## Working Principle

### Step 1: Collect Source Data
- Take data from `market-report` output (or run `market-report` first if the user provides a URL)
- Alternatively, use the `scripts/analyze_page.py` output

### Step 2: Generate the PDF
Run the `scripts/generate_pdf_report.py` script. The script produces:

- **Cover page:** URL, date, overall score (large gauge)
- **Executive Summary:** 1-page summary
- **Score summary:** Bar chart for each category
- **Detail pages:** 1 page per category
- **Action plan:** Prioritized table

### Step 3: Script Usage

```bash
python scripts/generate_pdf_report.py \
  --input MARKETING-REPORT.md \
  --output MARKETING-REPORT.pdf \
  --title "Marketing Report: {site}"
```

The script parses the structured data in the `MARKETING-REPORT.md` file and converts it to PDF.

### Fallback Without Script
If `generate_pdf_report.py` is not available or reportlab is not installed, apply these steps for PDF generation:

1. **Generate clean Markdown:** All tables, headings, lists must be properly formatted
2. **Convert with Pandoc:** `pandoc MARKETING-REPORT.md -o MARKETING-REPORT.pdf --pdf-engine=xelatex`
3. **Or WeasyPrint:** `weasyprint MARKETING-REPORT.md MARKETING-REPORT.pdf`

---

## Output Format

`MARKETING-REPORT.pdf` file:

```
Page 1: Cover
  - Title: "Marketing Report"
  - URL
  - Date
  - Overall Score: 69/100 (large gauge)
  - Prepared by: Marketing Agent

Page 2: Executive Summary
  - 3 strengths
  - 3 improvement areas
  - Revenue impact estimate

Page 3: Score Summary (Table + Bar Chart)
  - Content & Messaging     ████████░░  72/100
  - Conversion              █████░░░░░  58/100
  - SEO                     ████████░░  81/100
  - Competitive             ██████░░░░  64/100
  - Brand & Trust           ███████░░░  76/100
  - Growth & Strategy       ██████░░░░  61/100

Pages 4-9: Category Details (1 page per category)
  - Wins
  - Fixes
  - Before/After examples

Page 10: Priority Action Plan
  - Do Immediately
  - Plan This Month
  - Later
```

---

## Rules
- PDF must always be professional and client-presentable quality
- Carry all data from Markdown into the PDF, nothing should be missing
- Colors must be consistent: green (good), yellow (medium), red (bad)
- Tables must display properly in the PDF, wrap and alignment must be correct
- Cover page must include logo (if available) and date
- Report must not exceed 10 pages, avoid unnecessary detail
