#!/bin/bash
# sync-skills.sh — sync skills from source to Cursor, Claude, Windsurf
# defaults to $HOME/.claude/skills as the source
SOURCE="${1:-$HOME/.claude/skills}"

TARGETS=(
  "$HOME/.cursor/skills"
  "$HOME/.claude/skills"
  "$HOME/.codeium/windsurf/skills"
)

for target in "${TARGETS[@]}"; do
  if [[ -d "$SOURCE" ]] && [[ "$target" != "$SOURCE" ]]; then
    mkdir -p "$target"
    for skill in "$SOURCE"/*/; do
      [[ -d "$skill" ]] || continue
      skill_name=$(basename "$skill")
      if [[ -f "$skill/SKILL.md" ]]; then
        rm -rf "$target/$skill_name"
        cp -R "$skill" "$target/"
        echo "Synced $skill_name → $target"
      fi
    done
  fi
done
