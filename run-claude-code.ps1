# run-claude-code.ps1

Write-Output "Claude Code - Submodule Runner with Max Plan Support"
Write-Output "---------------------------------------------------"

# Get repository root directory (parent of claude-code-docker)
$repoRoot = (Get-Item -Path "..").FullName
$repoName = Split-Path -Leaf $repoRoot

# Ask about authentication method
Write-Output ""
Write-Output "Authentication Options:"
Write-Output "1. Max Plan (recommended - use your Claude email/password)"
Write-Output "2. API Key"
$authChoice = Read-Host -Prompt "Choose authentication method (1 or 2)"

if ($authChoice -eq "1") {
    # Using Max Plan authentication
    Write-Output ""
    Write-Output "Using Max Plan Authentication."
    Write-Output "You'll be prompted to log in when you start Claude Code inside the container."
    Write-Output "Use the same credentials as your Claude.ai account."
    
    # Unset API key if it exists to force login prompt
    if (Test-Path env:ANTHROPIC_API_KEY) {
        Remove-Item env:ANTHROPIC_API_KEY
    }

    # Set a flag to indicate Max Plan usage
    $env:CLAUDE_USE_MAX_PLAN = "true"
}
else {
    # Using API Key authentication
    Write-Output ""
    Write-Output "Using API Key Authentication."
    
    # Check if ANTHROPIC_API_KEY is set
    if (-not (Test-Path env:ANTHROPIC_API_KEY)) {
        $apiKey = Read-Host -Prompt "Enter your Anthropic API key (or set the ANTHROPIC_API_KEY environment variable)"
        if ($apiKey) {
            $env:ANTHROPIC_API_KEY = "$apiKey"
        }
    }
}

# Show Max Plan usage information
Write-Output ""
Write-Output "Max Plan Usage Limits (shared across Claude and Claude Code):"
Write-Output "- 5x Pro ($100/mo): ~225 Claude messages or ~50-200 Claude Code prompts / 5 hrs"
Write-Output "- 20x Pro ($200/mo): ~900 Claude messages or ~200-800 Claude Code prompts / 5 hrs"
Write-Output ""

# Build and start in interactive mode
Write-Output "Starting Claude Code for repository: $repoName"
Write-Output "Repository path: $repoRoot"
Write-Output "Building and starting Claude Code container in interactive mode..."

docker-compose build
docker-compose run --rm claude-code /bin/zsh

# Provide instructions after container exit
Write-Output ""
Write-Output "Container exited. Quick reminders:"
Write-Output "- If using Max Plan: Run '/login' inside Claude Code to log in with your Claude credentials"
Write-Output "- If previously using API key: Run '/login' to switch to Max Plan"
Write-Output "- For PAYG users: If you hit rate limits, consider upgrading to Max Plan"