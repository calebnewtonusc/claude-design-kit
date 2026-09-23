#!/usr/bin/env bash
# Install the design kit into Claude Code, Codex, or any agent that reads
# markdown skills. Idempotent. Never overwrites a skill you already have
# without saying so.
set -euo pipefail

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="${CLAUDE_DIR:-$HOME/.claude}"
SKILLS_DIR="$CLAUDE_DIR/skills"
RULES_DIR="$CLAUDE_DIR/rules"

say() { printf '  %s\n' "$*"; }

mkdir -p "$SKILLS_DIR" "$RULES_DIR"

echo "Installing design kit from $SRC"

for s in design-refusals interface-presets motion-budget; do
  dest="$SKILLS_DIR/$s"
  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    say "SKIP $s (a real directory already exists there, not touching it)"
    continue
  fi
  ln -sfn "$SRC/skills/$s" "$dest"
  say "link $s"
done

# The doctrine. Appended by reference so your own CLAUDE.md stays yours.
MARKER="# --- claude-design-kit ---"
CM="$CLAUDE_DIR/CLAUDE.md"
touch "$CM"
if grep -qF "$MARKER" "$CM"; then
  say "doctrine already referenced in $CM"
else
  {
    printf '\n%s\n' "$MARKER"
    printf '@%s/CLAUDE.md\n' "$SRC"
    printf '%s\n' "# --- end claude-design-kit ---"
  } >> "$CM"
  say "referenced doctrine from $CM"
fi

# Only linked on a real install. A sandbox run (CLAUDE_DIR set elsewhere)
# must not repoint a binary in the user's real PATH; that happened once.
if [ -x "$SRC/bin/ux-lint" ] && [ "$CLAUDE_DIR" = "$HOME/.claude" ]; then
  mkdir -p "$HOME/.local/bin"
  if [ -e "$HOME/.local/bin/ux-lint" ]; then
    say "SKIP ux-lint (already installed, pointing at $(readlink "$HOME/.local/bin/ux-lint" 2>/dev/null || echo 'a real file'))"
  else
    ln -sfn "$SRC/bin/ux-lint" "$HOME/.local/bin/ux-lint"
    say "link ux-lint -> ~/.local/bin"
  fi
  case ":$PATH:" in
    *":$HOME/.local/bin:"*) ;;
    *) say "NOTE: ~/.local/bin is not on your PATH" ;;
  esac
fi

echo
echo "Done. Start a new session and ask for a landing page."
echo "Verify it took: the agent should name a design system and its refusals"
echo "BEFORE writing any markup. If it opens with a violet gradient, the"
echo "doctrine did not load."
