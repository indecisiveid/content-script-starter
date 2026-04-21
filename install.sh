#!/bin/bash
# content-script-starter installer
# Downloads the /content-script-setup wizard into ~/.claude/commands/
# Run: curl -sL https://raw.githubusercontent.com/indecisiveid/content-script-starter/main/install.sh | bash

set -e

REPO_RAW="https://raw.githubusercontent.com/indecisiveid/content-script-starter/main"
COMMANDS_DIR="$HOME/.claude/commands"
WIZARD_FILE="$COMMANDS_DIR/content-script-setup.md"

echo "→ content-script-starter installer"
echo

# Check Claude Code is installed
if ! command -v claude &> /dev/null; then
  echo "✗ Claude Code not found."
  echo "  Install it first: https://claude.ai/code"
  echo "  Then re-run this installer."
  exit 1
fi
echo "✓ Claude Code detected: $(command -v claude)"

# Warn if Obsidian is missing (macOS check)
if [[ "$(uname)" == "Darwin" ]]; then
  if [ ! -d "/Applications/Obsidian.app" ]; then
    echo
    echo "⚠  Obsidian.app not found in /Applications."
    echo "  Install via: brew install --cask obsidian"
    echo "  Or download from https://obsidian.md"
    echo "  (You can continue — install before running /content-script-setup.)"
  else
    echo "✓ Obsidian.app detected"
  fi
fi

# Create commands directory if it doesn't exist
mkdir -p "$COMMANDS_DIR"
echo "✓ Commands directory ready: $COMMANDS_DIR"

# Warn if wizard already exists
if [ -f "$WIZARD_FILE" ]; then
  echo
  echo "⚠  $WIZARD_FILE already exists."
  read -p "   Overwrite? [y/N] " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Aborted. Existing file preserved."
    exit 0
  fi
fi

# Download the wizard
echo "→ Downloading wizard..."
if curl -sSL -f "$REPO_RAW/commands/content-script-setup.md" -o "$WIZARD_FILE"; then
  echo "✓ Installed: $WIZARD_FILE"
else
  echo "✗ Download failed. Check your internet connection and the repo URL."
  exit 1
fi

echo
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Next step:"
echo
echo "  1. Open Claude Code in any terminal."
echo "  2. Run: /content-script-setup"
echo
echo "The wizard will ask ~7 questions and build the system."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
