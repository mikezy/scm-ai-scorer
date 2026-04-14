---
name: scm-ai-score
description: |
  Score AI skills on a supply chain resume and provide prioritized improvement recommendations.
  Optionally compare against a specific job description for targeted alignment analysis.
---

Read and follow `skills/scm-ai-score/SKILL.md`.

Resume content and optional job description to evaluate:
$ARGUMENTS

Output requirements:
1. Extract and list all AI-related skills, experiences, and keywords from the resume.
2. Classify each item into the AI Skills Hierarchy (Tier 1-4) and flag Dead Zone items.
3. Score across all 6 rubric dimensions with justification for each score.
4. Produce an overall weighted score (0-100) with band label.
5. Provide exactly 5 specific, actionable recommendations prioritized by impact.
6. If a job description was provided (after a `---` separator), include a JD alignment analysis.
