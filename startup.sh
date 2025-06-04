#!/bin/bash

echo "🚀 Starting Claude Code with FCM Enhancement..."

# Validate FCM compliance before operation
echo "🔍 Validating FCM compliance..."
if command -v node >/dev/null 2>&1; then
    if [ -f "/home/coder/validation/validate-fcm.js" ]; then
        node /home/coder/validation/validate-fcm.js || {
            echo "❌ FCM validation failed. Configuration violates FCM principles."
            echo "📚 See structural requirements in /home/coder/models/"
            echo "⚙️  Check configuration in /home/coder/config/"
            exit 1
        }
        echo "✅ FCM validation passed"
    else
        echo "⚠️  FCM validation tools not found - skipping validation"
    fi
else
    echo "ℹ️  Node.js not available - skipping FCM validation"
fi

# Track evolution startup
echo "📊 Tracking evolution startup..."
if [ -f "/home/coder/validation/track-evolution.js" ]; then
    node /home/coder/validation/track-evolution.js startup 2>/dev/null || true
fi

# Create symbolic links to ensure config files are accessible from all paths
ln -sf /home/coder/project/config /home/coder/config 2>/dev/null || true
ln -sf /home/coder/project/config /opt/context/config 2>/dev/null || true

# Create symbolic links for models and validation
ln -sf /home/coder/project/models /home/coder/models 2>/dev/null || true
ln -sf /home/coder/project/models /opt/context/models 2>/dev/null || true
ln -sf /home/coder/project/validation /home/coder/validation 2>/dev/null || true
ln -sf /home/coder/project/validation /opt/context/validation 2>/dev/null || true

# Copy config files to various locations to ensure they're found
cp -f /home/coder/project/config/claude.default.config.md /home/coder/claude.default.config.md 2>/dev/null || true
cp -f /home/coder/project/config/claude.config.model.json /home/coder/claude.config.model.json 2>/dev/null || true
cp -f /home/coder/project/config/claude.config.fcm.json /home/coder/claude.config.fcm.json 2>/dev/null || true

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

# Check resonance alignment (optional, non-blocking)
echo "🔄 Checking resonance alignment..."
if [ -f "/home/coder/validation/check-resonance.js" ]; then
    node /home/coder/validation/check-resonance.js 2>/dev/null || {
        echo "⚠️  Resonance check completed with issues - see report for details"
    }
fi

# Create a welcome message for Claude Code
cat > /home/coder/claude-welcome.txt << EOL
Welcome to Claude Code Docker with FCM Enhancement!

This Docker setup provides a FCM-compliant sidecar environment for running Claude Code
with formal conceptual model support and your entire repository mounted for seamless analysis.

FCM Features:
✅ Formal sidecar pattern implementation
✅ Progressive definition validation  
✅ Evolution tracking and learning
✅ Structural teaching through errors
✅ Resonance alignment checking

To get started:
1. Run 'claude' to launch Claude Code
2. If using Max Plan: You may need to run '/login' and use your Claude.ai credentials
3. See MAX-PLAN.md for more information about Max Plan features
4. See /home/coder/models/ for FCM formal definitions

Repository: $(basename $(pwd))
FCM Version: 0.3.0
EOL

# Display the welcome message
cat /home/coder/claude-welcome.txt

echo ""
echo "📚 FCM Resources:"
echo "   - Sidecar Pattern: /home/coder/models/fcm.sidecar.md"
echo "   - Docker Bridge: /home/coder/models/fcm.docker-bridge.md"
echo "   - Configuration: /home/coder/models/fcm.config.md"
echo "   - Validation Tools: /home/coder/validation/"
echo ""

# Start the original command
exec "$@"