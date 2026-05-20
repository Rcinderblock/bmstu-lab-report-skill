#!/usr/bin/env bash
set -euo pipefail

SKILL_NAME="${SKILL_NAME:-bmstu-lab-report}"
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET="${SKILL_TARGET:-$REPO_ROOT}"

DEFAULT_HOMES=(
  "$HOME/.codex"
  "$HOME/.codex-personal"
  "$HOME/.codex-plus"
  "$HOME/.codex-shared"
  "$HOME/.codex-test"
  "$HOME/.codex-work"
)

if [[ -n "${CODEX_HOMES:-}" ]]; then
  IFS=':' read -r -a HOMES <<< "$CODEX_HOMES"
else
  HOMES=("${DEFAULT_HOMES[@]}")
fi

if [[ ! -f "$TARGET/SKILL.md" ]]; then
  echo "Target does not look like a skill directory: $TARGET" >&2
  exit 1
fi

echo "Skill:  $SKILL_NAME"
echo "Target: $TARGET"
echo

for home in "${HOMES[@]}"; do
  [[ -n "$home" ]] || continue

  skills_dir="$home/skills"
  dest="$skills_dir/$SKILL_NAME"

  mkdir -p "$skills_dir"

  if [[ -L "$dest" ]]; then
    current="$(readlink "$dest")"
    if [[ "$current" == "$TARGET" ]]; then
      echo "ok      $dest -> $TARGET"
      continue
    fi
    rm "$dest"
  elif [[ -e "$dest" ]]; then
    rm -rf "$dest"
  fi

  ln -s "$TARGET" "$dest"
  echo "linked  $dest -> $TARGET"
done
