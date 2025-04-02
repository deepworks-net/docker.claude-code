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
