#!/usr/bin/env bash
# Docs lint for awesome-ai-prompts.
# Verifies that:
#   1. every category folder has a README.md linking back to the main index
#   2. every relative link in README.md and in each category README.md
#      resolves to a real file
#   3. every *-prompt.md follows the repo structure (H1 first line, --- separator,
#      a non-empty Keywords: line in the intro)
#   4. prompt files live in a category folder, not at the repo root
set -uo pipefail

repo="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo" || exit 1

fail=0

# 1. Every top-level folder that holds prompts must carry a README.md with a
# backlink to the index. Derived from the tracked prompt files so a new category
# is caught the moment its first prompt lands, with no list to keep in sync by
# hand.
#
# Only the top-level folder is checked. Translations nest one level deeper
# (i18n/<lang>/<category>/), and requiring a README in each of those would mean
# thirteen boilerplate files per language; i18n/<lang>/README.md carries the
# per-language index instead.
while IFS= read -r d; do
  if [[ ! -f "$d/README.md" ]]; then
    echo "Category folder without a README.md: $d/"
    fail=1
  fi
done < <(git ls-files -- '*-prompt.md' | cut -d/ -f1 | sort -u)

# 2. Relative links in README.md and in each category README.md resolve to a
# real file. Paths resolve against the directory holding the link, so a
# category README's `../README.md` and its bare prompt filenames are checked
# the way a browser would resolve them.
check_links_in() {
  local file="$1" base link path src
  base="$(dirname "$file")"
  if [[ ! -f "$file" ]]; then
    return 0
  fi
  # sort -u: the [spec] badge repeats on many lines, so report it once.
  while IFS= read -r link; do
    case "$link" in
      http* | '#'* | mailto:*) continue ;;
    esac
    path="${link%%#*}"
    path="${path%%\?*}"
    [[ -z "$path" ]] && continue
    if [[ ! -e "$base/$path" ]]; then
      echo "$file: broken link: $link"
      fail=1
    fi
  done < <(grep -oE '\]\([^)]*\)' "$file" | sed -E 's/^\]\(//; s/\)$//' | sort -u)

  while IFS= read -r src; do
    case "$src" in
      http* | '#'* | mailto:*) continue ;;
    esac
    path="${src%%#*}"
    path="${src%%\?*}"
    [[ -z "$path" ]] && continue
    if [[ ! -e "$base/$path" ]]; then
      echo "$file: broken <img> src: $src"
      fail=1
    fi
  done < <(grep -oE 'src="[^"]*"' "$file" | sed -E 's/^src="//; s/"$//' | sort -u)
}

check_links_in README.md
cat_readme_count=0
while IFS= read -r cat_readme; do
  check_links_in "$cat_readme"
  cat_readme_count=$((cat_readme_count + 1))
done < <(git ls-files -- '*/README.md' | sort)

# 3b. Every prompt carries a `Keywords:` line in its intro, so GitHub search
# and any future tooling can find it by the words a reader would actually type
# ("perf", "slow query", "speed up") rather than by title alone. The line sits
# above the --- divider, which is where scripts/build-all.py splits the intro
# from the copy-paste block, so it flows into the generated catalog with no
# generator change.
#
# Derived from the file itself, so this adds no hand-maintained list.
check_keywords() {
  local file="$1" intro terms found
  intro="$(sed -n '1,/^---$/p' "$file")"

  found="$(grep -c '^Keywords:' <<<"$intro" || true)"
  if [[ "$found" -eq 0 ]]; then
    echo "$file: missing Keywords: line above the --- divider"
    fail=1
    return 0
  fi
  if [[ "$found" -gt 1 ]]; then
    echo "$file: $found Keywords: lines in the intro, expected exactly 1"
    fail=1
    return 0
  fi

  terms="$(sed -n 's/^Keywords: //p' <<<"$intro")"
  # Lowercase and comma separated, and non-empty: a leading, trailing, or
  # doubled comma would otherwise pass as a term and render as an unsearchable
  # blank.
  if ! grep -qE '^[a-z0-9][a-z0-9 .-]*(, [a-z0-9][a-z0-9 .-]*)*$' <<<"$terms"; then
    echo "$file: Keywords: must be lowercase, comma separated, and non-empty"
    fail=1
  fi
}

# 3. Prompt files follow the structure conventions.
count=0
while IFS= read -r f; do
  count=$((count + 1))
  first="$(head -n 1 "$f")"
  case "$first" in
    \#\ *) ;;
    *)
      echo "$f: first line must be an H1 title (# ...)"
      fail=1
      ;;
  esac
  if ! grep -q '^---$' "$f"; then
    echo "$f: missing --- separator before the prompt block"
    fail=1
  fi
  check_keywords "$f"
done < <(find . -name '*-prompt.md' -not -path './.git/*' | sort)
if [[ "$count" -eq 0 ]]; then
  echo "No prompt files found"
  exit 1
fi

# 4. No prompt files at the repo root.
while IFS= read -r f; do
  if [[ "$(dirname "$f")" == "." ]]; then
    echo "Prompt file at repo root, should be in a category folder: $f"
    fail=1
  fi
done < <(find . -maxdepth 1 -name '*-prompt.md')

if [[ "$fail" -ne 0 ]]; then
  echo "check-links.sh: FAILED"
  exit 1
fi
echo "check-links.sh: OK ($count prompts, $cat_readme_count category READMEs, links verified)"
