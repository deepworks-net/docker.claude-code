# Docker Claude Code

A self-contained Docker setup for running Anthropic's Claude Code as a submodule in your repository, with full Windows compatibility.

## What is Claude Code?

Claude Code is an agentic coding tool developed by Anthropic that lives in your terminal, understands your codebase, and helps you code faster through natural language commands. By integrating directly with your development environment, Claude Code streamlines your workflow without requiring additional servers or complex setup.

Since Claude Code officially requires Linux or macOS (with Windows only supported via WSL), this Docker configuration provides a clean way to run it on Windows machines without WSL configuration.

## Architectural Approach

This implementation positions Claude Code as a self-contained submodule:

- Everything related to Claude Code stays within its own directory
- The Docker container mounts your entire repository for analysis
- Clear separation between your code and the Claude Code tooling

## Features

- Run Claude Code as a contained submodule in your repository
- Mount your entire repository for seamless analysis
- Works on Windows, macOS, and Linux
- Simple setup process with PowerShell scripts
- No WSL configuration needed for Windows users

## Prerequisites

- Docker Desktop installed and running
- PowerShell (for Windows users)
- An Anthropic API key with Claude Code access
- Git installed on your host machine

## Quick Start

1. Add this repository as a submodule:

   ```bash
   git submodule add https://github.com/yourusername/docker.claude-code.git claude-code-docker
   git submodule update --init --recursive
   ```

2. Run Claude Code:

   ```powershell
   cd claude-code-docker
   .\run-claude-code.ps1
   ```

3. Inside the container, start Claude Code:

   ```bash
   claude
   ```

## How It Works

This project creates a Docker container with:

- Node.js environment required for Claude Code
- All necessary dependencies pre-installed
- Volume mounting for your entire repository
- Complete isolation of Claude Code infrastructure

When you run the container:

1. Your entire repository is mounted inside the container
2. Claude Code can analyze and work with your entire codebase
3. All Claude Code infrastructure stays within its own directory

## Project Structure

```DIRECTORY
your-repository/
├── .git/                          # Your repository's Git data
├── src/                           # Your project source code
├── claude-code-docker/            # Claude Code submodule (completely self-contained)
│   ├── claude.ps1                 # Setup script
│   ├── Dockerfile.simple          # Docker image definition
│   ├── docker-compose.yml         # Docker Compose configuration
│   ├── README.md                  # Submodule-specific instructions
│   └── run-claude-code.ps1        # Script to run the container
└── [Other project files]          # Your project files
```

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- [Anthropic](https://www.anthropic.com/) for creating Claude Code
- This project is not officially affiliated with Anthropic
