#!/bin/bash

# Create symbolic links to ensure config files are accessible from all paths
ln -sf /home/coder/project/config /home/coder/config 2>/dev/null || true
ln -sf /home/coder/project/config /opt/context/config 2>/dev/null || true

# Copy config files to various locations to ensure they're found
cp -f /home/coder/project/config/claude.default.config.md /home/coder/claude.default.config.md 2>/dev/null || true
cp -f /home/coder/project/config/claude.config.model.json /home/coder/claude.config.model.json 2>/dev/null || true

# Setup Max Plan information
if [ "$CLAUDE_USE_MAX_PLAN" = "true" ]; then
    echo ""
    echo "⭐ Max Plan Support Enabled ⭐"
    echo "When you start Claude Code, use '/login' to authenticate with your Claude.ai credentials."
    echo "This connects your Max plan subscription to Claude Code."
    echo ""
    echo "Usage limits are shared across both Claude and Claude Code:"
    echo "- 5x Pro ($100/mo): ~225 Claude messages or ~50-200 Claude Code prompts / 5 hrs"
    echo "- 20x Pro ($200/mo): ~900 Claude messages or ~200-800 Claude Code prompts / 5 hrs"
    echo ""
    echo "For more information, see the MAX-PLAN.md file in the repository."
    echo ""
fi

# Create a welcome message for Claude Code
cat > /home/coder/claude-welcome.txt << EOL
Welcome to Claude Code Docker with Max Plan Support!

This Docker setup provides a clean environment for running Claude Code
with your entire repository mounted for seamless analysis.

To get started:
1. Run 'claude' to launch Claude Code
2. If using Max Plan: You may need to run '/login' and use your Claude.ai credentials
3. See MAX-PLAN.md for more information about Max Plan features

Repository: $(basename $(pwd))
EOL

# Display the welcome message
cat /home/coder/claude-welcome.txt

# Start the original command
exec "$@"