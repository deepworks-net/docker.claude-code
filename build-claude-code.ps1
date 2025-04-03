# claude.ps1 - Sets up Claude Code as a contained submodule

Write-Output "Setting up Claude Code as a contained submodule..."

# Create the Dockerfile
@"
# Base Image
FROM node:20-slim

# Install essential tools
RUN apt-get update && apt-get install -y \
    git \
    curl \
    ripgrep \
    vim \
    zsh \
    openssh-client \
    && rm -rf /var/lib/apt/lists/*

# Install Claude Code globally
RUN npm install -g @anthropic-ai/claude-code

# Create a non-root user
RUN useradd -m -s /bin/zsh coder || true

# Configure git for the user
RUN mkdir -p /home/coder/.ssh && \
    chmod 700 /home/coder/.ssh && \
    chown -R coder:coder /home/coder/.ssh && \
    git config --system credential.helper store && \
    git config --system core.longpaths true && \
    git config --system core.autocrlf input

# Ensure proper ownership
RUN mkdir -p /home/coder/project && \
    chown -R coder:coder /home/coder

# Set working directory
WORKDIR /home/coder/project

# Switch to non-root user
USER coder

# Configure git for the user
RUN git config --global user.name "Claude Code User" && \
    git config --global user.email "user@example.com" && \
    git config --global --add safe.directory '*'

# Default to bash
CMD ["/bin/zsh"]
"@ | Out-File -FilePath "Dockerfile.simple" -Encoding utf8

# Create docker-compose.yml
@"
services:
  # Standard node container
  claude-code:
    image: claude-code:latest
    build:
      context: .
      dockerfile: Dockerfile.simple
    volumes:
      - ..:/home/coder/project:rw
      - ../claude-code-docker:/home/coder/claude-code-docker:ro
    environment:
      - ANTHROPIC_API_KEY=\${ANTHROPIC_API_KEY}
    # Keep container running
    tty: true
    stdin_open: true
    # Override the default command to keep container alive
    command: tail -f /dev/null
"@ | Out-File -FilePath "docker-compose.yml" -Encoding utf8

# Create run script
@"
# run-claude-code.ps1

Write-Output "Claude Code - Submodule Runner"
Write-Output "----------------------------"

# Get repository root directory (parent of claude-code-docker)
\$repoRoot = (Get-Item -Path "..").FullName
\$repoName = Split-Path -Leaf \$repoRoot

# Check if ANTHROPIC_API_KEY is set
if (-not (Test-Path env:ANTHROPIC_API_KEY)) {
    \$apiKey = Read-Host -Prompt "Enter your Anthropic API key (or set the ANTHROPIC_API_KEY environment variable)"
    if (\$apiKey) {
        \$env:ANTHROPIC_API_KEY = "\$apiKey"
    }
}

# Build and start in interactive mode
Write-Output "Starting Claude Code for repository: \$repoName"
Write-Output "Repository path: \$repoRoot"
Write-Output "Building and starting Claude Code container in interactive mode..."

docker-compose build
docker-compose run --rm claude-code /bin/zsh
"@ | Out-File -FilePath "run-claude-code.ps1" -Encoding utf8

# Create README.md
@"
# Claude Code Docker Submodule

This is a self-contained Docker setup for running Claude Code as a submodule within your repository.

## Getting Started

1. Make sure Docker is installed and running
2. From this directory, run: `.\run-claude-code.ps1`
3. Inside the container, run `claude` to start Claude Code

## How It Works

This setup mounts your entire repository into the Docker container, giving Claude Code access to your project files. Claude Code operates within its own contained submodule and can access your project files without interfering with your main codebase.

## Environment Variables

You can set the ANTHROPIC_API_KEY environment variable before running the script, or the script will prompt you for it.

## Integration Guide

To use this as a Git submodule:

\`\`\`bash
# Add as a submodule to your repository
git submodule add https://github.com/yourusername/docker.claude-code.git claude-code-docker

# Initialize and update the submodule
git submodule update --init --recursive
\`\`\`

Then you can run Claude Code from the submodule directory:

\`\`\`powershell
cd claude-code-docker
.\run-claude-code.ps1
\`\`\`
"@ | Out-File -FilePath "README.md" -Encoding utf8

# Build instructions
Write-Output @"

Claude Code submodule setup is ready!

To run Claude Code:

1. From this directory:
   .\run-claude-code.ps1

Claude Code will have access to your entire repository as a contained submodule.
"@