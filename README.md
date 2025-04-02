# Docker Claude Code

A Docker container setup for running Anthropic's Claude Code on Windows machines using Docker, with GitHub repository integration.

## What is Claude Code?

Claude Code is an agentic coding tool developed by Anthropic that lives in your terminal, understands your codebase, and helps you code faster through natural language commands. By integrating directly with your development environment, Claude Code streamlines your workflow without requiring additional servers or complex setup.

Since Claude Code officially requires Linux or macOS (with Windows only supported via WSL), this Docker configuration provides a clean way to run it on Windows machines without WSL configuration.

## Features

- Run Claude Code in an isolated Docker container with proper permissions
- Mount your local project files for seamless editing
- **Clone GitHub repositories directly into the project environment**
- **Support for Git submodules to manage complex projects**
- Works on Windows, macOS, and Linux
- Simple setup process with PowerShell scripts
- No WSL configuration needed for Windows users

## Prerequisites

- Docker Desktop installed and running
- PowerShell (for Windows users)
- An Anthropic API key with Claude Code access
- Git installed on your host machine

## Quick Start

1. Clone this repository:
   ```
   git clone https://github.com/yourusername/docker.claude-code.git
   cd docker.claude-code
   ```

2. Run the setup script:
   ```powershell
   .\claude.ps1
   ```

3. Start the container with GitHub integration:
   ```powershell
   cd claude-code-docker
   .\run-claude-code.ps1
   ```
   - When prompted, choose whether to clone a GitHub repository
   - If yes, provide the repository URL
   - The script will clone the repository and initialize any submodules

4. Inside the container, start Claude Code:
   ```bash
   claude
   ```

## How It Works

This project creates a Docker container with:
- Node.js environment required for Claude Code
- All necessary dependencies pre-installed
- Git configured for repository operations
- A non-root user to run Claude Code securely
- Volume mounting for your project files

When you run the container:
1. You can choose to clone a GitHub repository directly
2. The repository is cloned into the project directory
3. Any Git submodules in the repository are automatically initialized
4. Claude Code can immediately access the entire project structure

## GitHub Integration

The setup supports:
- Cloning repositories during container startup
- Updating existing repositories
- Initializing and updating Git submodules
- Working with your local project files

This enables you to work on complex projects with Claude Code's assistance, even when they have dependencies managed as submodules.

## Project Structure

```
docker.claude-code/
├── claude.ps1                    # Main setup script
├── claude-code-docker/           # Generated container configuration
│   ├── Dockerfile.simple         # Docker image definition
│   ├── docker-compose.yml        # Docker Compose configuration
│   ├── README.md                 # Container-specific instructions
│   ├── run-claude-code.ps1       # Script to run the container with Git support
│   └── project/                  # Mounted directory for your code
│       └── your-repo/            # (Optional) Cloned GitHub repository
│           └── .git/             # Git metadata for the repository
│           └── .gitmodules       # (If present) Submodule definitions
```

## Usage

### GitHub Repository Integration

When running `run-claude-code.ps1`, you'll be prompted:
```
Do you want to clone a GitHub repository? (y/n)
```

If you answer "y":
1. Enter the GitHub repository URL
2. The script will clone the repository into the project directory
3. If the repository contains submodules, they will be initialized
4. Claude Code will have access to the complete project structure

### Local Project Files

If you answer "n" to the repository prompt, you can:
1. Place your project files in the `claude-code-docker/project/` directory
2. These files will be available inside the container

### Claude Code Commands

Inside the container, you can use commands like:

```bash
# Ask about your codebase
claude "how does this project work?"

# Explore code structure
claude "explain the file structure"

# Initialize project
claude /init

# Get help
claude /help
```

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- [Anthropic](https://www.anthropic.com/) for creating Claude Code
- This project is not officially affiliated with Anthropic