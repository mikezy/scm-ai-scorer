# scm-ai-scorer

Score the AI skills on your supply chain resume — based on what employers actually pay premium for, not what LinkedIn says.

## The Problem

95% of AI pilots show zero ROI. Yet candidates keep listing "prompt engineering" and "ChatGPT proficiency" as headline skills. Meanwhile, employers are paying 11-15% above market for professionals who combine AI capability with domain execution — and they can't find enough of them.

The gap isn't awareness. It's calibration.

## What This Does

`scm-ai-scorer` is a [Claude Code](https://docs.anthropic.com/en/docs/claude-code) skill that evaluates your resume's AI positioning against a data-driven rubric built from BCG, Gartner, McKinsey, and MIT research (2025-2026). It tells you:

- **Where you stand** — a 0-100 score across 6 employer-valued dimensions
- **What's working** — AI skills classified by market signal strength (Tier 1-4)
- **What to fix** — 5 specific, paste-ready recommendations prioritized by impact
- **How you match** — optional job description alignment with automatic JD-Fit Mode for non-AI roles

Built for supply chain and MSCM professionals.

## Requirements

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) CLI

## Quick Start

### Install

```bash
# From GitHub
claude install-skill https://github.com/mikezy/scm-ai-scorer

# Or clone and install locally
git clone https://github.com/mikezy/scm-ai-scorer.git
claude install-skill ./scm-ai-scorer
```

### Use

**Score your resume** — paste your resume text or provide a file path:
```
/scm-ai-score
> paste your resume text here
```

**Score a resume file:**
```
/scm-ai-score ./resume.pdf
```

**Score against a job description** — add a `---` separator, then paste the JD:
```
/scm-ai-score
> [resume text]
> ---
> [job description text]
```

If the JD is AI-heavy, you get an AI skills alignment analysis. If the JD has minimal AI requirements (e.g., a general PM or strategy role), the skill automatically switches to **JD-Fit Mode** — a general resume-vs-JD alignment focused on what the role actually demands.

### Example Output

```
## AI Resume Score: 63/100 — AI Aware

### Score Breakdown

| Dimension              | Score | Weight | Weighted | Key Evidence                              |
|------------------------|-------|--------|----------|-------------------------------------------|
| D1: AI Sophistication  | 14/20 | 25%    | 3.50     | ML forecasting model — Tier 2-3 skills    |
| D2: Domain Integration | 15/20 | 25%    | 3.75     | AI applied to demand planning, 500+ SKUs  |
| D3: Agentic Thinking   | 12/20 | 15%    | 1.80     | Automated procurement workflow with GPT-4  |
| D4: Business Impact    | 13/20 | 15%    | 1.95     | 18% forecast accuracy improvement          |
| D5: Governance & Risk  |  4/20 | 10%    | 0.40     | No governance evidence                     |
| D6: People & Process   | 12/20 | 10%    | 1.20     | Trained cross-functional team of 12        |

### Top 5 Recommendations

1. **Add AI governance to your demand planning role** — "Established data quality
   standards and model monitoring for ML forecasting pipeline" — demand up 81% YoY
   — Expected impact: +6 points
...
```

## Scoring Rubric

| Dimension | Weight | What Employers Look For |
|-----------|--------|------------------------|
| AI Skill Sophistication | 25% | Context engineering and agentic workflows, not just "knows ChatGPT" |
| Domain + AI Integration | 25% | AI applied to SCM problems — demand forecasting, inventory, logistics |
| Agentic & Systems Thinking | 15% | Designing autonomous multi-step workflows, not chatbot conversations |
| Business Impact Quantification | 15% | Measurable outcomes: $, %, time saved, scale |
| AI Governance & Risk | 10% | Responsible AI, compliance, monitoring — demand up 81% YoY |
| People & Process | 10% | Driving AI adoption, the 70% of success most candidates ignore |

### Score Bands

| Score | Band | What It Means |
|-------|------|--------------|
| 85-100 | AI-Forward Leader | Employers will compete for you |
| 70-84 | AI Practitioner | Solid foundation, sharpen strategic depth |
| 50-69 | AI Aware | Reads "I use AI" not "I direct AI" |
| 30-49 | AI Curious | At risk of blending in with everyone else |
| 0-29 | AI Gap | Urgent action needed |

## The AI Skills Hierarchy

Not all AI skills carry equal weight. The rubric classifies skills into four tiers based on employer demand signals:

| Tier | Example | Market Signal |
|------|---------|--------------|
| **Tier 4: Unicorn** | "Architected agentic procurement system reducing cycles from 5 days to 16 min" | Commands salary premium |
| **Tier 3: High-Value** | "Designed context engineering framework for supply chain AI agents" | Maps to fastest-growing demand |
| **Tier 2: Applied** | "Automated demand reports using AI-driven analytics pipeline" | Shows real application |
| **Tier 1: Table Stakes** | "Proficient in ChatGPT and Copilot" | Expected of everyone, differentiates no one |

## Research Foundation

The scoring rubric is grounded in:
- **BCG 10-20-70 Principle** — 10% algorithms, 20% technology, 70% people/process/culture
- **MIT Project NANDA** — 95% of AI pilots show zero return
- **Gartner** — 40% of enterprise apps to integrate agentic AI by end of 2026; SCM AI market $2B → $53B by 2030
- **McKinsey** — AI-driven supply chains: logistics costs -15%, inventory +35%, lost sales -65%
- **BCG 2026** — Domain-aligned AI leaders deliver 3x cost reduction, 2.7x ROIC

## Platform Support

This skill is built for Claude Code. It follows the `.claude-plugin` specification and can be installed as a plugin.

For other AI coding assistants, the core rubric lives in [`skills/scm-ai-score/SKILL.md`](skills/scm-ai-score/SKILL.md) — it's a self-contained markdown document that any LLM can follow as instructions.

## Contributing

The AI job market moves fast. If you have updated employer demand data, new research citations, or suggestions for the rubric, PRs are welcome. Please include your data source.

## Credits

Built by [Mike Zhuo](https://github.com/mikezy) — based on research presented at the University of Michigan Ross School of Business.

Built with [Claude Code](https://docs.anthropic.com/en/docs/claude-code).

## License

[MIT](LICENSE)
