#!/bin/bash

# Setup script for adding Claude Code Docker to an existing project
# Run this from your project root directory

set -e

echo "🚀 Setting up Claude Code Docker for your project..."

# Check if we're in a git repository
if [ ! -d ".git" ]; then
    echo "⚠️  Warning: This doesn't appear to be a git repository."
    echo "   Claude Code works best with git repositories."
    read -p "   Continue anyway? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "❌ Setup cancelled."
        exit 1
    fi
fi

# Check if claude-docker directory already exists
if [ -d "claude-docker" ]; then
    echo "❌ claude-docker directory already exists!"
    echo "   Please remove it first or choose a different name."
    exit 1
fi

# Check if claude directory already exists
if [ -d "claude" ]; then
    echo "❌ claude directory already exists!"
    echo "   Please remove it first or move it to a different location."
    exit 1
fi

# Download the docker.claude-code repository
echo "📥 Downloading Docker Claude Code setup..."
if command -v curl >/dev/null 2>&1; then
    curl -L https://github.com/deepworks-net/docker.claude-code/archive/main.zip -o claude-docker.zip
elif command -v wget >/dev/null 2>&1; then
    wget -O claude-docker.zip https://github.com/deepworks-net/docker.claude-code/archive/main.zip
else
    echo "❌ Neither curl nor wget found. Please install one of them."
    exit 1
fi

# Extract and rename
echo "📂 Extracting files..."
unzip -q claude-docker.zip
mv docker.claude-code-main claude-docker
rm claude-docker.zip

# Copy Claude configuration to project root
echo "⚙️  Setting up Claude configuration..."
cp -r claude-docker/claude ./claude

# Create .env file if it doesn't exist
if [ ! -f ".env" ]; then
    echo "📄 Creating .env file..."
    cat > .env << 'EOF'
# Anthropic API Key (optional if using Max plan login)
# ANTHROPIC_API_KEY=your_api_key_here

# Enable Max plan startup information
CLAUDE_USE_MAX_PLAN=true
EOF
    echo "   Please edit .env and add your ANTHROPIC_API_KEY if not using Max plan login."
fi

# Create docker-compose.yml if it doesn't exist
if [ ! -f "docker-compose.yml" ]; then
    echo "🐳 Creating docker-compose.yml..."
    cp claude-docker/example-docker-compose.yml docker-compose.yml
    echo "   You can customize docker-compose.yml as needed."
else
    echo "⚠️  docker-compose.yml already exists. You'll need to manually integrate Claude Code."
    echo "   See claude-docker/example-docker-compose.yml for reference."
fi

# Add to .gitignore if it exists
if [ -f ".gitignore" ]; then
    if ! grep -q "claude-docker" .gitignore; then
        echo "" >> .gitignore
        echo "# Claude Code Docker setup" >> .gitignore
        echo "claude-docker/" >> .gitignore
        echo "✅ Added claude-docker/ to .gitignore"
    fi
else
    echo "claude-docker/" > .gitignore
    echo "✅ Created .gitignore with claude-docker/"
fi

echo ""
echo "✅ Setup complete!"
echo ""
echo "📋 Next steps:"
echo "   1. Review and edit .env file with your API key (if needed)"
echo "   2. Start the container: docker-compose up -d --build"
echo "   3. Enter the container: docker-compose exec claude-code bash"
echo "   4. Start Claude Code: claude"
echo "   5. If using Max plan: /login"
echo ""
echo "📚 Documentation:"
echo "   - README: claude-docker/README.md"
echo "   - Configuration: claude/config/"
echo "   - FCM Models: claude/models/"
echo ""
echo "🎉 Happy coding with Claude!"