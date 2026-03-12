#!/usr/bin/env bash
#
# Validate all .soul.md files in the repository.
# Checks that each file has YAML frontmatter with required fields.
#
# Required fields:
#   - name
#   - identity (with at least: role, personality)
#
# Exit code 1 if any file fails validation.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PASS=0
FAIL=0
ERRORS=()

validate_file() {
  local file="$1"
  local rel_path="${file#$REPO_ROOT/}"
  local errors=()

  # Check file starts with ---
  local first_line
  first_line="$(head -n 1 "$file")"
  if [[ "$first_line" != "---" ]]; then
    errors+=("missing YAML frontmatter (file does not start with ---)")
  fi

  # Extract frontmatter (between first and second ---)
  local frontmatter
  frontmatter="$(awk 'BEGIN{found=0} /^---$/{found++; next} found==1{print} found>=2{exit}' "$file")"

  if [[ -z "$frontmatter" ]]; then
    errors+=("empty or missing YAML frontmatter")
  else
    # Check for required top-level field: name
    if ! echo "$frontmatter" | grep -qE '^name:'; then
      errors+=("missing required field: name")
    fi

    # Check for required top-level field: identity
    if ! echo "$frontmatter" | grep -qE '^identity:'; then
      errors+=("missing required field: identity")
    else
      # Check identity has role
      if ! echo "$frontmatter" | grep -qE '^  role:'; then
        errors+=("identity missing required sub-field: role")
      fi
      # Check identity has personality
      if ! echo "$frontmatter" | grep -qE '^  personality:'; then
        errors+=("identity missing required sub-field: personality")
      fi
    fi
  fi

  if [[ ${#errors[@]} -eq 0 ]]; then
    echo "  PASS  $rel_path"
    PASS=$((PASS + 1))
  else
    echo "  FAIL  $rel_path"
    for err in "${errors[@]}"; do
      echo "        - $err"
    done
    FAIL=$((FAIL + 1))
    ERRORS+=("$rel_path")
  fi
}

echo "Validating .soul.md files..."
echo ""

# Find all .soul.md files
files=()
while IFS= read -r -d '' file; do
  files+=("$file")
done < <(find "$REPO_ROOT" -name "*.soul.md" -type f -print0 | sort -z)

if [[ ${#files[@]} -eq 0 ]]; then
  echo "  No .soul.md files found."
  exit 1
fi

for file in "${files[@]}"; do
  validate_file "$file"
done

echo ""
echo "---"
echo "Results: $PASS passed, $FAIL failed, $((PASS + FAIL)) total"

if [[ $FAIL -gt 0 ]]; then
  echo ""
  echo "Failed files:"
  for f in "${ERRORS[@]}"; do
    echo "  - $f"
  done
  exit 1
else
  echo "All files passed validation."
fi
