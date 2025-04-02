# Docker Claude Code

A Docker container setup for running Anthropic's Claude Code on Windows machines using Docker.

## What is Claude Code?

Claude Code is an agentic coding tool developed by Anthropic that lives in your terminal, understands your codebase, and helps you code faster through natural language commands. By integrating directly with your development environment, Claude Code streamlines your workflow without requiring additional servers or complex setup.

Since Claude Code officially requires Linux or macOS (with Windows only supported via WSL), this Docker configuration provides a clean way to run it on Windows machines without WSL configuration.

## Features

- Run Claude Code in an isolated Docker container with proper permissions
- Mount your local project files for seamless editing
- Works on Windows, macOS, and Linux
- Simple setup process with PowerShell scripts
- No WSL configuration needed for Windows users

## Prerequisites

- Docker Desktop installed and running
- PowerShell (for Windows users)
- An Anthropic API key with Claude Code access

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

3. Start the container:
   ```powershell
   cd claude-code-docker
   .\run-claude-code.ps1
   ```

4. Inside the container, start Claude Code:
   ```bash
   claude
   ```

## How It Works

This project creates a Docker container with:
- Node.js environment required for Claude Code
- All necessary dependencies pre-installed
- A non-root user to run Claude Code securely
- Volume mounting for your project files

The PowerShell scripts automate the process of:
1. Creating the Docker configuration files
2. Building the Docker image
3. Running the container with proper environment variables
4. Connecting to the container's shell

## Project Structure

```
docker.claude-code/
├── claude.ps1                    # Main setup script
├── claude-code-docker/           # Generated container configuration
│   ├── Dockerfile.simple         # Docker image definition
│   ├── docker-compose.yml        # Docker Compose configuration
│   ├── README.md                 # Container-specific instructions
│   ├── run-claude-code.ps1       # Script to run the container
│   └── project/                  # Mounted directory for your code
```

## Usage

### Adding Your Project Files

Place your project files in the `claude-code-docker/project/` directory. These files will be available inside the container.

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

### Environment Variables

The container uses the following environment variables:

- `ANTHROPIC_API_KEY`: Your Anthropic API key for authentication

You can set this before running the container or the script will prompt you for it.

## Troubleshooting

### Container Exits Immediately

If the container exits immediately after starting, check that your Docker engine is running properly and that the docker-compose.yml file includes the correct TTY settings.

### API Key Not Working

Verify that your Anthropic API key is correct and has access to Claude Code. You should be able to access the Claude Console at console.anthropic.com.

### Docker Build Errors

Make sure Docker Desktop is running and has sufficient resources allocated. Also ensure you have an active internet connection for the container to download packages.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- [Anthropic](https://www.anthropic.com/) for creating Claude Code
- This project is not officially affiliated with Anthropic