# AI-Assisted Business Reporting

This directory contains the resources and deliverables used to transform validated SQL analysis results into structured, management-ready business reports.

## Project Deliverables

| File | Description |
|---|---|
| [`validated_analysis.md`](validated_analysis.md) | Source of truth for validated metrics, business definitions, findings, and data limitations. |
| [`reporting_prompt.md`](reporting_prompt.md) | Prompt used to guide Claude in generating the management report. |
| [`management_report_draft.md`](management_report_draft.md) | AI-generated management report draft, reviewed and refined before publication. |
| [`Retail_Sales_Management_Report.pdf`](Retail_Sales_Management_Report.pdf) | Final formatted management report with KPI cards, data visualizations, validation results, and business recommendations. |

## Reporting Workflow

1. **SQL Analysis:** Extract business insights using SQL Server.
2. **Data Validation:** Run SQL validation checks to assess consistency and data quality.
3. **AI-Assisted Reporting:** Use Claude to transform validated findings into a structured management report.
4. **Human Review:** Review AI-generated content for numerical accuracy, unsupported assumptions, and analytical limitations.
5. **Final Presentation:** Format the reviewed report into a professional PDF deliverable.

## Tools & Technologies

- Microsoft SQL Server
- SQL Server Management Studio (SSMS)
- T-SQL
- Claude (AI-assisted reporting)
- GitHub

## Reporting Principles

- Use validated source metrics as the single source of truth.
- Preserve the distinction between completed and cancelled revenue.
- Never interpret revenue as profit.
- Clearly distinguish validated findings from interpretations and recommendations.
- Disclose data limitations and unsupported analysis.
- Require human review before publishing AI-generated reports.

**Note:** The dataset is fictional and small. All monetary values are in an unspecified currency. The results do not represent actual company performance.
