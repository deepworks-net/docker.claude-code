# run-claude-code.ps1

# Create project directory if it doesn't exist
New-Item -ItemType Directory -Path "project" -Force

Write-Output "Claude Code Docker with GitHub Submodule Support"
Write-Output "------------------------------------------------"

# Check if ANTHROPIC_API_KEY is set
if (-not (Test-Path env:ANTHROPIC_API_KEY)) {
    $apiKey = Read-Host -Prompt "Enter your Anthropic API key (or set the ANTHROPIC_API_KEY environment variable)"
    if ($apiKey) {
        $env:ANTHROPIC_API_KEY = "$apiKey"
    }
}

# GitHub repository handling
$useRepo = Read-Host -Prompt "Do you want to clone a GitHub repository? (y/n)"

if ($useRepo -eq "y") {
    $repoUrl = Read-Host -Prompt "Enter the GitHub repository URL (e.g., https://github.com/username/repo.git)"
    $repoName = $repoUrl -replace ".*/(.*).git", '$1'
    $projectPath = Join-Path -Path "project" -ChildPath $repoName
    
    # Check if the repository already exists
    if (Test-Path $projectPath) {
        $updateRepo = Read-Host -Prompt "Repository already exists. Update it? (y/n)"
        if ($updateRepo -eq "y") {
            Write-Output "Updating existing repository..."
            Push-Location $projectPath
            & git pull
            Pop-Location
        }
    } else {
        Write-Output "Cloning repository..."
        & git clone $repoUrl $projectPath
        
        # Check for submodules
        if (Test-Path -Path (Join-Path -Path $projectPath -ChildPath ".gitmodules")) {
            Write-Output "Initializing submodules..."
            Push-Location $projectPath
            & git submodule update --init --recursive
            Pop-Location
        }
    }
    
    Write-Output "Repository ready at: $projectPath"
} else {
    Write-Output "Using local project directory: ./project"
}

# Option 1: Build and start in interactive mode directly
Write-Output "Building and starting Claude Code container in interactive mode..."
docker-compose build
docker-compose run --rm claude-code /bin/zsh

# Note: This approach launches the container directly in interactive mode
# rather than starting it detached and then connecting