# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Fixed
- README example output table arithmetic now matches the stated 63/100 total

### Added
- Worked example below the score formula in SKILL.md
- Manual eval harness (`tests/eval-anchors.md`) with structured procedure for
  validating scorer output against calibration anchors A, B, and C
- Validation scripts now check for eval harness presence and anchor references
- Sources section in SKILL.md with representative citation URLs
- CHANGELOG.md (this file)
- CONTRIBUTING.md with guidelines for rubric changes, eval, and PRs

### Changed
- Removed `"type": "module"` from package.json (no JS modules in this repo)
- Bumped version to 1.0.1 in package.json and plugin.json

## [1.0.0] - 2026-04-13

### Added
- Initial release of SCM AI Resume Scorer skill
- 6-dimension scoring rubric based on BCG, Gartner, McKinsey, and MIT research
- AI Skills Hierarchy (Tiers 1-4) classification
- JD-Fit Mode for non-AI job descriptions
- Calibration anchors (A, B, C) for scoring consistency
- Structural validation scripts (bash and PowerShell)
- Claude Code plugin packaging (`.claude-plugin/plugin.json`)
