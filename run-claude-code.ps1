# run-claude-code.ps1

Write-Output "Claude Code - Submodule Runner"
Write-Output "----------------------------"

# Get repository root directory (parent of claude-code-docker)
$repoRoot = (Get-Item -Path "..").FullName
$repoName = Split-Path -Leaf $repoRoot

# Check if ANTHROPIC_API_KEY is set
if (-not (Test-Path env:ANTHROPIC_API_KEY)) {
    $apiKey = Read-Host -Prompt "Enter your Anthropic API key (or set the ANTHROPIC_API_KEY environment variable)"
    if ($apiKey) {
        $env:ANTHROPIC_API_KEY = "$apiKey"
    }
}

# Build and start in interactive mode
Write-Output "Starting Claude Code for repository: $repoName"
Write-Output "Repository path: $repoRoot"
Write-Output "Building and starting Claude Code container in interactive mode..."

docker-compose build
docker-compose run --rm claude-code /bin/zsh