# Docker Claude Code v0.3.1

A self-contained Docker setup for running Anthropic's Claude Code as a FCM-compliant sidecar in your repository, with full Windows compatibility and Max plan support.

## What is Claude Code?

Claude Code is an agentic coding tool developed by Anthropic that lives in your terminal, understands your codebase, and helps you code faster through natural language commands. By integrating directly with your development environment, Claude Code streamlines your workflow without requiring additional servers or complex setup.

Since Claude Code officially requires Linux or macOS (with Windows only supported via WSL), this Docker configuration provides a clean way to run it on Windows machines without WSL configuration.

## Max Plan Support

This implementation now fully supports Anthropic's Max plan:

- **Unified Subscription**: Access both Claude (web, desktop, mobile) and Claude Code (terminal) with one subscription
- **Shared Usage Limits**: Usage limits are shared across both Claude and Claude Code
- **Seamless Authentication**: Log in with the same Claude credentials you use for the web app
- **Max Plan Tiers**: Compatible with both 5x Pro usage ($100/month) and 20x Pro usage ($200/month)

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
- Full support for Max plan authentication and usage

## Prerequisites

- Docker Desktop installed and running
- PowerShell (for Windows users)
- An Anthropic Max plan subscription or API key with Claude Code access
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

4. If using a Max plan, log in with your Claude credentials:

   ```bash
   # If previously logged in with Anthropic Console PAYG
   /login
   ```

## Authentication Options

### Max Plan Authentication
This setup supports logging in with your Claude Max plan credentials:

- When prompted during setup or first use, log in with the same email and password you use for Claude
- This connects your Max plan subscription to Claude Code
- If you're already logged in via Anthropic Console PAYG, run `/login` to switch to Max

### API Key Authentication
You can also use a direct API key:

- Set the ANTHROPIC_API_KEY environment variable before running
- The script will prompt for an API key if not set

## Rate Limits with Max Plan

With the Max plan, your usage limits are shared across both Claude and Claude Code:

| Plan | Claude Messages | Claude Code Prompts |
|------|----------------|---------------------|
| Max (5x Pro/$100) | ~225 messages / 5 hrs | ~50-200 prompts / 5 hrs |
| Max (20x Pro/$200) | ~900 messages / 5 hrs | ~200-800 prompts / 5 hrs |

*Note: Usage varies based on message length, complexity, file attachments, and other factors.*

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
│   ├── Dockerfile                 # Docker image definition
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