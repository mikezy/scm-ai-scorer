# Contributing to scm-ai-scorer

Thank you for considering a contribution. This guide covers how to propose
changes, run validation, and submit a clean PR.

## Proposing Rubric Changes

The scoring rubric in `skills/scm-ai-score/SKILL.md` is research-grounded.
To change weights, tier definitions, or scoring criteria:

1. **Cite a source.** Every rubric change must reference published research,
   employer survey data, or job market analysis. Add the citation to the
   Sources section at the bottom of SKILL.md.
2. **Explain the impact.** Describe how the change would shift scores for the
   three calibration anchors (A, B, C).
3. **Run the eval harness** before and after (see below).

## Updating Calibration Anchors

The anchors in Section 6 of SKILL.md define expected scoring behavior.
They matter because:

- They prevent score inflation drift over time
- They give reviewers a concrete way to verify rubric changes
- They serve as regression tests for LLM behavior

To update an anchor:

1. Update the anchor text and expected scores in SKILL.md Section 6
2. Update the corresponding entry in `tests/eval-anchors.md`
3. Run the eval harness to confirm the new anchor produces scores in the
   expected band
4. Document why the change was necessary in your PR description

## Running Validation Scripts

Structural validation checks JSON validity, required files, frontmatter,
and eval harness integrity:

```bash
# macOS / Linux
bash tests/validate.sh

# Windows (PowerShell)
powershell -NoLogo -NoProfile -ExecutionPolicy Bypass -File tests/validate.ps1

# Via npm
npm test
```

All validation checks must pass before submitting a PR.

## Running the Eval Harness

Before submitting PRs that touch `SKILL.md`:

1. Install the skill locally: `claude install-skill .`
2. Follow the procedure in `tests/eval-anchors.md`
3. Run at minimum Anchor A (quick sanity check)
4. For rubric changes, run all three anchors and include results in your PR

## Style Guidelines

- **Markdown:** Use ATX headings (`#`), fenced code blocks, pipe tables
- **Line length:** Wrap prose at ~80 characters where practical
- **Trailing whitespace:** None (configure your editor to trim)
- **File encoding:** UTF-8, LF line endings
- **No trailing newlines:** Files should end with exactly one newline character

## PR Process

1. Fork the repository and create a feature branch
2. Make your changes with clear, atomic commits (Conventional Commits style)
3. Run `bash tests/validate.sh` and confirm it passes
4. If you touched SKILL.md, run the eval harness and include results
5. Open a PR with:
   - A summary of what changed and why
   - Source citations for any rubric changes
   - Eval harness results (if applicable)
6. Address review feedback

## Questions?

Open an issue if you are unsure whether a change is in scope or need guidance
on the rubric methodology.
