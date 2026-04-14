#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
ERRORS=0

# Resolve python command (python3 on macOS/Linux, python on Windows/Git Bash)
PY=""
for cmd in python3 python; do
  if "$cmd" -c "import json" 2>/dev/null; then PY="$cmd"; break; fi
done
[ -z "$PY" ] && { echo "ERROR: No working Python found"; exit 1; }

fail() {
  echo "FAIL: $1" >&2
  ERRORS=$((ERRORS + 1))
}

# --- JSON file validation ---
echo "Validating JSON files..."
for f in \
  .claude-plugin/plugin.json \
  package.json
do
  path="$REPO_ROOT/$f"
  if [ ! -f "$path" ]; then
    fail "Missing JSON file: $f"
  elif ! "$PY" -c "import json,sys; json.load(open(sys.argv[1]))" "$path" 2>/dev/null; then
    fail "Invalid JSON: $f"
  fi
done

# --- Required files ---
echo "Validating required files..."
for f in \
  skills/scm-ai-score/SKILL.md \
  commands/scm-ai-score.md \
  LICENSE \
  README.md
do
  [ -f "$REPO_ROOT/$f" ] || fail "Missing required file: $f"
done

# --- Frontmatter validation ---
echo "Validating frontmatter..."
check_frontmatter() {
  local file="$1"
  local first_line
  first_line=$(head -1 "$file" | tr -d '\r' | sed 's/^\xEF\xBB\xBF//')
  if [ "$first_line" != "---" ]; then
    fail "Missing frontmatter: $file"; return
  fi
  local terminator
  terminator=$(tail -n +2 "$file" | grep -n '^---$' | head -1 | cut -d: -f1)
  if [ -z "$terminator" ]; then
    fail "Missing frontmatter terminator: $file"; return
  fi
  local fm
  fm=$(sed -n "2,$((terminator))p" "$file")
  echo "$fm" | grep -qE '^name:\s*.+' || fail "Missing 'name' in frontmatter: $file"
  echo "$fm" | grep -qE '^description:\s*\|$' || fail "Missing block 'description' in frontmatter: $file"
}

check_frontmatter "$REPO_ROOT/skills/scm-ai-score/SKILL.md"
check_frontmatter "$REPO_ROOT/commands/scm-ai-score.md"

# --- Markdown link validation ---
echo "Validating markdown links..."
check_md_links() {
  local file="$1"
  local dir
  dir=$(dirname "$file")
  local targets
  targets=$(grep -oE '\[([^]]*)\]\(([^)]+)\)' "$file" | grep -oE '\(([^)]+)\)' | tr -d '()' || true)
  [ -z "$targets" ] && return
  while IFS= read -r target; do
    case "$target" in
      \#*|http://*|https://*) continue ;;
    esac
    [ -e "$dir/$target" ] || fail "Broken link '$target' in $file"
  done <<< "$targets"
}

[ -f "$REPO_ROOT/README.md" ] && check_md_links "$REPO_ROOT/README.md"

# --- Result ---
if [ "$ERRORS" -gt 0 ]; then
  echo "Validation FAILED with $ERRORS error(s)."
  exit 1
fi

echo "Validation passed."
