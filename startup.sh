#!/bin/bash

# Create symbolic links to ensure config files are accessible from all paths
ln -sf /home/coder/project/config /home/coder/config 2>/dev/null || true
ln -sf /home/coder/project/config /opt/context/config 2>/dev/null || true

# Copy config files to various locations to ensure they're found
cp -f /home/coder/project/config/claude.default.config.md /home/coder/claude.default.config.md 2>/dev/null || true
cp -f /home/coder/project/config/claude.config.model.json /home/coder/claude.config.model.json 2>/dev/null || true

# Configure Git user from environment variables
git config --global user.name "${GIT_USER_NAME:-Claude Code User}"
git config --global user.email "${GIT_USER_EMAIL:-user@example.com}"
git config --global --add safe.directory '*'

# Run repository analyzer script to generate REPO_STRUCTURE.md
echo "Analyzing repository structure..."
/usr/local/bin/analyze-repo.sh

# Start the original command
exec "$@"