# run-claude-code.ps1

# Create project directory if it doesn't exist
New-Item -ItemType Directory -Path "project" -Force

Write-Output "Starting Claude Code container..."
Write-Output "Your project files will be mounted from the ./project directory"

# Check if ANTHROPIC_API_KEY is set
if (-not (Test-Path env:ANTHROPIC_API_KEY)) {
    $apiKey = Read-Host -Prompt "Enter your Anthropic API key (or set the ANTHROPIC_API_KEY environment variable)"
    if ($apiKey) {
        $env:ANTHROPIC_API_KEY = "$apiKey"
    }
}

# Option 1: Build and start in interactive mode directly
Write-Output "Building and starting Claude Code container in interactive mode..."
docker-compose build
docker-compose run --rm claude-code /bin/zsh

# Note: This approach launches the container directly in interactive mode
# rather than starting it detached and then connecting