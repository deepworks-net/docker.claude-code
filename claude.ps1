# setup-claude-code.ps1

# Create a directory for Claude Code
$claudioCodeDir = "claude-code-docker"
New-Item -ItemType Directory -Path $claudioCodeDir -Force
Set-Location $claudioCodeDir

# Create necessary files
Write-Output "Creating Docker files..."

# Create the simpler Dockerfile
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
    && rm -rf /var/lib/apt/lists/*

# Install Claude Code globally
RUN npm install -g @anthropic-ai/claude-code

# Create a non-root user
RUN useradd -m -s /bin/zsh coder || true

# Ensure proper ownership
RUN mkdir -p /home/coder/project && \
    chown -R coder:coder /home/coder

# Set working directory
WORKDIR /home/coder/project

# Switch to non-root user
USER coder

# Default to bash
CMD ["/bin/zsh"]
"@ | Out-File -FilePath "Dockerfile.simple" -Encoding utf8

# Create docker-compose.yml
@"
version: "3.9"
services:
  # Standard node container
  claude-code:
    image: claude-code:latest
    build:
      context: .
      dockerfile: Dockerfile.simple
    volumes:
      - ./project:/home/coder/project
    environment:
      - ANTHROPIC_API_KEY=\${ANTHROPIC_API_KEY}
"@ | Out-File -FilePath "docker-compose.yml" -Encoding utf8

# Create run script
@"
# run-claude-code.ps1

# Create project directory if it doesn't exist
New-Item -ItemType Directory -Path "project" -Force

Write-Output "Starting Claude Code container..."
Write-Output "Your project files will be mounted from the ./project directory"

# Check if ANTHROPIC_API_KEY is set
if (-not (Test-Path env:ANTHROPIC_API_KEY)) {
    \$apiKey = Read-Host -Prompt "Enter your Anthropic API key (or set the ANTHROPIC_API_KEY environment variable)"
    if (\$apiKey) {
        \$env:ANTHROPIC_API_KEY = "\$apiKey"
    }
}

# Build and start the container
Write-Output "Building and starting Claude Code container..."
docker-compose build
docker-compose up -d

# Attach to the container
Write-Output "Connecting to Claude Code container..."
docker-compose exec claude-code /bin/zsh
"@ | Out-File -FilePath "run-claude-code.ps1" -Encoding utf8

# Create a README.md
@"
# Claude Code Docker Setup

This is a simple Docker setup for running Claude Code in a container.

## Getting Started

1. Make sure Docker is installed and running
2. Run the script: `.\run-claude-code.ps1`
3. Inside the container, run `claude` to start Claude Code

## Project Files

Your project files will be available in the `./project` directory. Any changes made inside the container will be reflected in this directory.

## Environment Variables

You can set the ANTHROPIC_API_KEY environment variable before running the script, or the script will prompt you for it.
"@ | Out-File -FilePath "README.md" -Encoding utf8

# Build instructions
Write-Output @"

Claude Code Docker environment is ready!

To build and run:

1. Run Claude Code with your project:
   .\run-claude-code.ps1

Your code will be available in the 'project' subdirectory.
"@