# Docker Claude Code v0.4.0

A self-contained Docker setup for running Anthropic's Claude Code with your repository, featuring FCM-compliant architecture and Max plan support.

## What is Claude Code?

Claude Code is an agentic coding tool developed by Anthropic that lives in your terminal, understands your codebase, and helps you code faster through natural language commands. By integrating directly with your development environment, Claude Code streamlines your workflow without requiring additional servers or complex setup.

## New Architecture (v0.4.0)

This version restructures the Docker setup for maximum flexibility:

- **User Repository**: Your project files remain at the root level
- **Claude Configuration**: All Claude-specific files are in the `claude/` folder
- **Clean Separation**: Submodules are optional—this repo can be added directly or as a git submodule
- **Easy Integration**: Drop into any project with minimal setup

## Max Plan Support

This implementation fully supports Anthropic's Max plan:

- **Unified Subscription**: Access both Claude (web, desktop, mobile) and Claude Code (terminal) with one subscription
- **Shared Usage Limits**: Usage limits are shared across both Claude and Claude Code
- **Seamless Authentication**: Log in with the same Claude credentials you use for the web app
- **Max Plan Tiers**: Compatible with both 5x Pro usage ($100/month) and 20x Pro usage ($200/month)

## Prerequisites

- Docker Desktop installed and running
- An Anthropic Max plan subscription or API key with Claude Code access
- Git installed on your host machine

## Quick Start

### Option 1: Add to Existing Project

1. Download this repository into your project:
   ```bash
   curl -L https://github.com/deepworks-net/docker.claude-code/archive/main.zip -o claude-docker.zip
   unzip claude-docker.zip
   mv docker.claude-code-main claude-docker
   rm claude-docker.zip
   ```

2. Build and run:
   ```bash
   cd claude-docker
   docker-compose up -d --build
   ```

3. Enter the container:
   ```bash
   docker-compose exec claude-code bash
   ```

### Option 2: Zero-Config with Docker Hub Image (Recommended)

```bash
# Quick start - no files needed!
docker run -it -v .:/home/coder/project deepworks/claude-code:latest

# Or with docker-compose.yml in your project:
version: '3.8'
services:
  claude-code:
    image: deepworks/claude-code:latest
    volumes:
      - .:/home/coder/project:rw
      # Optional: Add custom config by uncommenting:
      # - ./claude/CLAUDE.md:/home/coder/claude/CLAUDE.md:ro
    environment:
      - ANTHROPIC_API_KEY=${ANTHROPIC_API_KEY}
    working_dir: /home/coder/project
    tty: true
    stdin_open: true

# Run it
docker-compose up -d
docker-compose exec claude-code bash
```

### Option 3: Add as Git Submodule (Legacy/Advanced)

```bash
# If using SSH
git submodule add git@github.com:deepworks-net/docker.claude-code.git claude-docker
# Or using HTTPS
git submodule add https://github.com/deepworks-net/docker.claude-code.git claude-docker
git submodule update --init --recursive
```

Both the download method and submodule method place the files in the same
`claude-docker` directory, so the Docker commands remain identical.

## Project Structure After Setup

```
your-project/
├── src/                    # Your project source code
├── docs/                   # Your project documentation  
├── package.json           # Your project dependencies
├── claude-docker/         # Claude Code Docker setup (Option 1 or 3)
│   ├── Dockerfile
│   ├── docker-compose.yml
│   ├── startup.sh
│   └── claude/           # Claude configuration folder
│       ├── config/       # Claude config files
│       ├── models/       # FCM pattern definitions
│       └── validation/   # FCM validation tools
└── docker-compose.yml    # Simple compose file (Option 2)
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

## Using Claude Code

1. Start Claude Code inside the container:
   ```bash
   claude
   ```

2. If using a Max plan, log in with your Claude credentials:
   ```bash
   /login
   ```

3. Claude Code will have access to your entire repository and can help with:
   - Code analysis and understanding
   - Feature implementation
   - Bug fixing
   - Documentation generation
   - Refactoring

## Rate Limits with Max Plan

With the Max plan, your usage limits are shared across both Claude and Claude Code:

| Plan | Claude Messages | Claude Code Prompts |
|------|----------------|---------------------|
| Max (5x Pro/$100) | ~225 messages / 5 hrs | ~50-200 prompts / 5 hrs |
| Max (20x Pro/$200) | ~900 messages / 5 hrs | ~200-800 prompts / 5 hrs |

*Note: Usage varies based on message length, complexity, file attachments, and other factors.*

## FCM (Formal Conceptual Model) Features

This setup includes FCM compliance for enhanced structural integrity:

- **Progressive Definition**: All concepts build from previously defined foundations
- **Evolution Tracking**: System improves automatically through usage pattern recognition
- **Structural Teaching**: Configuration teaches through structure and errors
- **Resonance Alignment**: Maintains conceptual coherence across all components

FCM resources are available in the `claude/` folder:
- `claude/models/` - Formal FCM pattern definitions
- `claude/config/` - FCM-compliant configuration
- `claude/validation/` - FCM validation and tracking tools

## Customization

### Environment Variables

- `ANTHROPIC_API_KEY` - Your Anthropic API key (if not using Max plan login)
- `CLAUDE_USE_MAX_PLAN` - Set to "true" to show Max plan information on startup

### Volume Mounts

The docker-compose configuration mounts:
- Your project at `/home/coder/project/repository`
- Claude config at `/home/coder/claude`
- Legacy compatibility links for existing configurations

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- [Anthropic](https://www.anthropic.com/) for creating Claude Code
- This project is not officially affiliated with Anthropic

## Migration from v0.3.x

If you're upgrading from a previous version:

1. Move your `config/`, `models/`, and `validation/` folders into a new `claude/` folder
2. Update your docker-compose.yml volume mounts to point to `./claude` instead of individual folders
3. The new working directory is `/home/coder/project/repository` (your actual project)
4. If you previously included this repo as a git submodule, keep it in the `claude-docker/` directory so the compose volumes remain the same
