#!/usr/bin/env bash
# Symlink every skill in this folder into ~/.claude/skills so Claude Code picks it up.
# Re-run after adding, renaming, or removing a skill here.
set -euo pipefail

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST="$HOME/.claude/skills"
mkdir -p "$DEST"

# Prune symlinks that point into this folder but whose source is gone (renamed/deleted skills).
for link in "$DEST"/*; do
  [ -L "$link" ] || continue
  case "$(readlink "$link")" in
    "$SRC"/*) [ -e "$link" ] || { rm "$link"; echo "prune $(basename "$link")"; } ;;
  esac
done

for dir in "$SRC"/*/; do
  [ -f "$dir/SKILL.md" ] || continue
  name="$(basename "$dir")"
  target="$DEST/$name"
  if [ -e "$target" ] && [ ! -L "$target" ]; then
    echo "skip  $name (a real directory already exists at $target)" >&2
    continue
  fi
  ln -sfn "${dir%/}" "$target"
  echo "link  $name"
done
