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
      - ./project:/home/coder/project
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

# Create project directory if it doesn't exist
New-Item -ItemType Directory -Path "project" -Force

Write-Output "Claude Code Docker with GitHub Submodule Support"
Write-Output "------------------------------------------------"

# Check if ANTHROPIC_API_KEY is set
if (-not (Test-Path env:ANTHROPIC_API_KEY)) {
    \$apiKey = Read-Host -Prompt "Enter your Anthropic API key (or set the ANTHROPIC_API_KEY environment variable)"
    if (\$apiKey) {
        \$env:ANTHROPIC_API_KEY = "\$apiKey"
    }
}

# GitHub repository handling
\$useRepo = Read-Host -Prompt "Do you want to clone a GitHub repository? (y/n)"

if (\$useRepo -eq "y") {
    \$repoUrl = Read-Host -Prompt "Enter the GitHub repository URL (e.g., https://github.com/username/repo.git)"
    \$repoName = \$repoUrl -replace ".*/(.*).git", '\$1'
    \$projectPath = Join-Path -Path "project" -ChildPath \$repoName
    
    # Check if the repository already exists
    if (Test-Path \$projectPath) {
        \$updateRepo = Read-Host -Prompt "Repository already exists. Update it? (y/n)"
        if (\$updateRepo -eq "y") {
            Write-Output "Updating existing repository..."
            Push-Location \$projectPath
            & git pull
            Pop-Location
        }
    } else {
        Write-Output "Cloning repository..."
        & git clone \$repoUrl \$projectPath
        
        # Check for submodules
        if (Test-Path -Path (Join-Path -Path \$projectPath -ChildPath ".gitmodules")) {
            Write-Output "Initializing submodules..."
            Push-Location \$projectPath
            & git submodule update --init --recursive
            Pop-Location
        }
    }
    
    Write-Output "Repository ready at: \$projectPath"
} else {
    Write-Output "Using local project directory: ./project"
}

# Option 1: Build and start in interactive mode directly
Write-Output "Building and starting Claude Code container in interactive mode..."
docker-compose build
docker-compose run --rm claude-code /bin/zsh

# Note: This approach launches the container directly in interactive mode
# rather than starting it detached and then connecting
"@ | Out-File -FilePath "run-claude-code.ps1" -Encoding utf8

# Create a README.md
@"
# Claude Code Docker Setup

This is a simple Docker setup for running Claude Code in a container.

## Getting Started

1. Make sure Docker is installed and running
2. Run the script: .\run-claude-code.ps1
3. Inside the container, run claude to start Claude Code

## Project Files

Your project files will be available in the ./project directory. Any changes made inside the container will be reflected in this directory.

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