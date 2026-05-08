# Evaluation Harness: Calibration Anchors

This document defines a manual evaluation procedure using the three calibration
anchors from `skills/scm-ai-score/SKILL.md`. It verifies that the scorer
produces scores within the expected bands for known-good inputs.

## Why Manual?

Deterministic automated evaluation of LLM output requires inference
infrastructure and statistical methods beyond this repository's scope. This
harness provides a structured, reproducible procedure a human reviewer can
follow to validate scorer behavior after any rubric change.

---

## Anchor Definitions

### Anchor A — Tier-1-Only Resume

**ID:** `ANCHOR_A`

**Input text:**
> Skills: Python, SQL, Tableau, ChatGPT, Microsoft Copilot, Excel. Experience:
> Used AI tools to streamline reporting workflows. Familiar with machine
> learning concepts.

**Expected score band:** 25-35 (AI Curious)

**Expected dimension profile:** D1: 5-8, D2: 0-4, D3: 0-4, D4: 0-4, D5: 0-4, D6: 0-4

---

### Anchor B — Tier 2-3 Resume

**ID:** `ANCHOR_B`

**Input text:**
> Led implementation of ML-based demand forecasting model for 500+ SKUs,
> improving forecast accuracy by 18%. Designed automated procurement workflow
> integrating GPT-4 for supplier communication drafting. Trained
> cross-functional team of 12 on AI-assisted inventory planning tools.

**Expected score band:** 55-70 (AI Aware)

**Expected dimension profile:** D1: 9-14, D2: 12-16, D3: 9-12, D4: 11-15, D5: 0-4, D6: 9-13

---

### Anchor C — Tier 3-4 Resume

**ID:** `ANCHOR_C`

**Input text:**
> Architected agentic AI system for end-to-end procurement, compressing review
> cycles from 5 days to 16 minutes with 325% accuracy improvement. Designed
> context engineering framework ensuring AI agents operate within regulatory and
> business constraints. Led enterprise-wide AI governance policy for supply
> chain operations, establishing model monitoring, bias auditing, and
> escalation protocols. Drove organizational AI transformation across 3
> business units (200+ people), shifting from ad-hoc AI usage to systematic
> agentic workflows.

**Expected score band:** 80-95 (AI-Forward Leader)

**Expected dimension profile:** D1: 17-20, D2: 16-20, D3: 16-20, D4: 15-20, D5: 14-18, D6: 13-17

---

## Evaluation Procedure

### Prerequisites

- Claude Code CLI installed and working
- `scm-ai-scorer` skill installed (`claude install-skill .` from repo root)

### Steps (repeat for each anchor)

1. Open a new Claude Code session
2. Invoke the skill with the anchor input text:
   ```
   /scm-ai-score
   > [paste anchor input text here]
   ```
3. Record the overall score and each dimension score
4. Verify the overall score falls within the expected band
5. Verify each dimension score is within the expected range (allow +/-2 tolerance for adjacent anchors)
6. Note any deviations and whether they represent a calibration drift

### Pass Criteria

- All three anchors must score within their expected band
- No dimension should deviate more than 4 points from the expected profile midpoint
- The ordering must be preserved: Anchor A < Anchor B < Anchor C

---

## Results Template

Copy this table and fill in after running the eval:

| Anchor | Expected Band | Actual Score | Within Band? | Notes |
|--------|---------------|--------------|--------------|-------|
| A      | 25-35         |              |              |       |
| B      | 55-70         |              |              |       |
| C      | 80-95         |              |              |       |

### Dimension Detail (fill per anchor as needed)

| Anchor | D1 | D2 | D3 | D4 | D5 | D6 | Total |
|--------|----|----|----|----|----|----|-------|
| A      |    |    |    |    |    |    |       |
| B      |    |    |    |    |    |    |       |
| C      |    |    |    |    |    |    |       |

**Evaluator:** _______________
**Date:** _______________
**Skill version:** _______________
**Pass/Fail:** _______________
