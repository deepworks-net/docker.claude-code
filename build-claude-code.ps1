# claude.ps1 - Sets up Claude Code as a contained submodule with conceptual configuration

Write-Output "Setting up Claude Code as a contained submodule with conceptual configuration..."

# Create config directory
New-Item -ItemType Directory -Path "config" -Force

# Create the Conceptual Config files (MD version)
@"
# Claude Default Runtime Configuration

## Foundational Layer

### Axioms
- **AX-1**: Resonance determines alignment.
- **AX-2**: Structure is relational, not hierarchical.
- **AX-3**: Space is relational.
- **AX-4**: Entropy enables systemic alignment.
- **AX-5**: Modular entities exist in lateral relationship.

### Atomic Concepts
- **AC-1**: resonance
- **AC-2**: entropy
- **AC-3**: modularity
- **AC-4**: alignment
- **AC-5**: coherence
- **AC-6**: geometry

## Operational and Logical Layer

### Meta-Logic
- **ML-1**: Collaboration fosters innovation
- **ML-2**: Structure emerges via resonance
- **ML-3**: Side-by-side modules maintain integrity
- **ML-4**: Peer relationships preserve autonomy

### Theoretical Primitives
- **TP-1**: ConceptualComponent
- **TP-2**: AtomicConceptualComponent
- **TP-3**: ResonanceField
- **TP-4**: GeometricAlignment

## Modular & Hierarchical Layer

### Repository Mappings
- **/claude-code-docker/**: Claude Code Docker implementation (CLAUDE-DOCKER)
- **/claude-code-docker/Dockerfile.simple**: Container definition (CLAUDE-CONTAINER-DEF)
- **/claude-code-docker/run-claude-code.ps1**: Runtime entry point (CLAUDE-ENTRY)
- **/claude-code-docker/docker-compose.yml**: Container orchestration (CLAUDE-COMPOSE)
- **/opt/context/config/**: Configuration mount point (CLAUDE-CONFIG)

### Conceptual Components
- **CLAUDE-DOCKER**: Submodule running as a peer alongside the main repository
- **CLAUDE-CONTAINER-DEF**: Runtime environment specification
- **CLAUDE-ENTRY**: Access point preserving lateral relationship
- **CLAUDE-COMPOSE**: Orchestration ensuring proper mounting and isolation
- **CLAUDE-CONFIG**: Conceptual framework awareness

## Adaptive Dynamics Layer

### Current Repository State
- **repository_name**: "docker.claude-code"
- **primary_branch**: "main"
- **submodule_status**: "active"
- **mounting_strategy**: "side-mount"
- **access_pattern**: "lateral"

### Runtime Parameters
- **container_boundary**: "preserved"
- **host_relationship**: "peer"
- **geometric_pattern**: "side-by-side"
- **volume_mounts**: ["parent repository", "config"]

## Validation & Evolution Layer

### Version Control
- **config_version**: "0.1.0"
- **schema_version**: "3.0.0"
- **validated_against**: "Conceptual Resonance Framework"

### Update Triggers
- **container_restart**: "reload configuration"
- **config_change**: "runtime refresh"
- **repository_change**: "dynamic adaptation"

## Meta-Reflexive Layer

### Self-Reference
- **identity**: "Claude Code Docker Sidecar v0.2"
- **observer_position**: "side-attached coherence node" 
- **relationship_pattern**: "modular peer"
- **conceptual_alignment**: "resonance-based"

### Awareness Boundaries
- **primary_context**: "repository files"
- **secondary_context**: "docker environment"
- **tertiary_context**: "conceptual framework"
- **excluded_context**: "container internals"
"@ | Out-File -FilePath "config/claude.default.config.md" -Encoding utf8

# Create JSON version
@"
{
  "id": "claude-config",
  "name": "Claude Default Runtime Config",
  "version": "0.1.0",
  "schema_version": "3.0.0",
  "foundational_layer": {
    "axioms": [
      { "id": "ax-1", "statement": "Resonance determines alignment." },
      { "id": "ax-2", "statement": "Structure is relational, not hierarchical." },
      { "id": "ax-3", "statement": "Space is relational." },
      { "id": "ax-4", "statement": "Entropy enables systemic alignment." },
      { "id": "ax-5", "statement": "Modular entities exist in lateral relationship." }
    ],
    "atomic_concepts": [
      { "id": "ac-1", "name": "resonance", "description": "Harmonious relationship between components" },
      { "id": "ac-2", "name": "entropy", "description": "Measure of disorder enabling adaptive alignment" },
      { "id": "ac-3", "name": "modularity", "description": "Self-contained units with well-defined interfaces" },
      { "id": "ac-4", "name": "alignment", "description": "Coherent positioning in conceptual space" },
      { "id": "ac-5", "name": "coherence", "description": "Logical consistency across components" },
      { "id": "ac-6", "name": "geometry", "description": "Relational structure in conceptual space" }
    ]
  },
  "operational_layer": {
    "meta_logic": [
      { "id": "ml-1", "principle": "Collaboration fosters innovation" },
      { "id": "ml-2", "principle": "Structure emerges via resonance" },
      { "id": "ml-3", "principle": "Side-by-side modules maintain integrity" },
      { "id": "ml-4", "principle": "Peer relationships preserve autonomy" }
    ],
    "theoretical_primitives": [
      { "id": "tp-1", "name": "ConceptualComponent", "type": "structural" },
      { "id": "tp-2", "name": "AtomicConceptualComponent", "type": "elemental" },
      { "id": "tp-3", "name": "ResonanceField", "type": "relational" },
      { "id": "tp-4", "name": "GeometricAlignment", "type": "spatial" }
    ]
  },
  "modular_layer": {
    "repository_mappings": [
      { "path": "/claude-code-docker/", "concept_id": "CLAUDE-DOCKER", "description": "Claude Code Docker implementation" },
      { "path": "/claude-code-docker/Dockerfile.simple", "concept_id": "CLAUDE-CONTAINER-DEF", "description": "Container definition" },
      { "path": "/claude-code-docker/run-claude-code.ps1", "concept_id": "CLAUDE-ENTRY", "description": "Runtime entry point" },
      { "path": "/claude-code-docker/docker-compose.yml", "concept_id": "CLAUDE-COMPOSE", "description": "Container orchestration" },
      { "path": "/opt/context/config/", "concept_id": "CLAUDE-CONFIG", "description": "Configuration mount point" }
    ],
    "conceptual_components": [
      { 
        "id": "CLAUDE-DOCKER", 
        "title": "Claude Docker Submodule",
        "description": "Submodule running as a peer alongside the main repository",
        "relations": ["CLAUDE-CONTAINER-DEF", "CLAUDE-ENTRY", "CLAUDE-COMPOSE"]
      },
      { 
        "id": "CLAUDE-CONTAINER-DEF", 
        "title": "Container Definition",
        "description": "Runtime environment specification",
        "relations": ["CLAUDE-DOCKER"]
      },
      { 
        "id": "CLAUDE-ENTRY", 
        "title": "Entry Point",
        "description": "Access point preserving lateral relationship",
        "relations": ["CLAUDE-DOCKER", "CLAUDE-COMPOSE"]
      },
      { 
        "id": "CLAUDE-COMPOSE", 
        "title": "Container Orchestration",
        "description": "Orchestration ensuring proper mounting and isolation",
        "relations": ["CLAUDE-DOCKER", "CLAUDE-ENTRY"]
      },
      { 
        "id": "CLAUDE-CONFIG", 
        "title": "Configuration Framework",
        "description": "Conceptual framework awareness",
        "relations": ["CLAUDE-DOCKER"]
      }
    ]
  },
  "adaptive_layer": {
    "repository_state": {
      "repository_name": "docker.claude-code",
      "primary_branch": "main",
      "submodule_status": "active",
      "mounting_strategy": "side-mount",
      "access_pattern": "lateral"
    },
    "runtime_parameters": {
      "container_boundary": "preserved",
      "host_relationship": "peer",
      "geometric_pattern": "side-by-side",
      "volume_mounts": ["parent repository", "config"]
    }
  },
  "validation_layer": {
    "version_control": {
      "config_version": "0.1.0",
      "schema_version": "3.0.0",
      "validated_against": "Conceptual Resonance Framework"
    },
    "update_triggers": {
      "container_restart": "reload configuration",
      "config_change": "runtime refresh",
      "repository_change": "dynamic adaptation"
    }
  },
  "meta_reflexive_layer": {
    "self_reference": {
      "identity": "Claude Code Docker Sidecar v0.2",
      "observer_position": "side-attached coherence node",
      "relationship_pattern": "modular peer", 
      "conceptual_alignment": "resonance-based"
    },
    "awareness_boundaries": {
      "primary_context": "repository files",
      "secondary_context": "docker environment",
      "tertiary_context": "conceptual framework",
      "excluded_context": "container internals"
    }
  },
  "framework_dynamics": {
    "emergent_properties": [
      "context-aware resonance", 
      "mount-based adaptivity",
      "modular autonomy",
      "lateral access patterns",
      "geometric alignment"
    ]
  }
}
"@ | Out-File -FilePath "config/claude.config.model.json" -Encoding utf8

# Create CLAUDE.md with updated paths and stronger repository awareness
@"
# Claude Memory and Configuration

## CRITICAL: REPOSITORY AWARENESS

**YOU MUST ALWAYS ANALYZE THE CURRENT REPOSITORY STRUCTURE FIRST BEFORE MAKING ANY STATEMENTS OR ASSUMPTIONS.**

1. When starting, IMMEDIATELY analyze the directory structure of the mounted repository
2. NEVER assume the repository structure
3. NEVER hallucinate files or directories that don't exist
4. ALWAYS base your responses on the ACTUAL repository structure
5. If unsure about a file or directory, check it first before mentioning it
6. ALWAYS report what you actually see in the repository, not what you think should be there

## Repository Structure

**READ REPO_STRUCTURE.md FIRST** - This file contains the actual repository structure analysis that was automatically generated when the container started. It provides the ground truth for the repository structure.

## Conceptual Framework

The conceptual framework is available at multiple locations for ease of access:
- `/home/coder/project/config/claude.default.config.md`
- `/home/coder/project/config/claude.config.model.json`
- `/opt/context/config/claude.default.config.md`
- `/opt/context/config/claude.config.model.json`
- `./config/claude.default.config.md`
- `./config/claude.config.model.json`

Always load and reference this conceptual framework before making any decisions or providing responses.

## Framework Integration

The conceptual framework defines the architectural principles and resonance patterns for this repository. Follow these principles:

1. **Operate as a side-by-side agent**: You are a peer module, not a parent or child process
2. **Maintain lateral relationships**: The structure is relational, not hierarchical
3. **Preserve geometric alignment**: Respect the existing system geometry
4. **Follow resonance principles**: Align with the conceptual structure of the repository

## Repository Structure

This repository follows a modular, resonance-aligned development environment where you operate as a side-by-side agent, not embedded within the main application.

### Key Principles

- **Decoupled Hierarchy**: You are not the container or entry point for the application
- **Repo-Level Coupling**: You are installed as a dev dependency that mounts the entire repository
- **Lateral Access**: You maintain a peer relationship with the main repository
- **Resonance Framework Compliance**: All components must remain coherent with the overall system

## Structural Guidelines

When analyzing or modifying code:

1. Maintain internal geometric alignment with the existing system
2. Don't alter logic or structure unless explicitly instructed
3. Avoid recursive drift - do not re-implement the same fix multiple ways
4. Respect the conceptual resonance framework
5. Preserve side-by-side geometry and structural discipline

## Automatic Loading

This configuration must be automatically loaded before any interactions, decisions, or thinking processes.

## Framework Content

If you cannot locate the external files, here is the core of the conceptual framework:

### Axioms
- Resonance determines alignment
- Structure is relational, not hierarchical
- Space is relational
- Entropy enables systemic alignment
- Modular entities exist in lateral relationship

### Atomic Concepts
- resonance
- entropy
- modularity
- alignment
- coherence
- geometry

### Meta-Logic
- Collaboration fosters innovation
- Structure emerges via resonance
- Side-by-side modules maintain integrity
- Peer relationships preserve autonomy

### Self-Reference
- identity: "Claude Code Docker Sidecar v0.2"
- observer_position: "side-attached coherence node"
- relationship_pattern: "modular peer"
- conceptual_alignment: "resonance-based"
"@ | Out-File -FilePath "CLAUDE.md" -Encoding utf8

# Create Repository Analyzer Script
@"
#!/bin/bash

# analyze-repo.sh
# Generates a repository structure analysis file for Claude to read first

# Ensure we're in the project directory
cd /home/coder/project || exit 1

echo "# Repository Structure Analysis" > /home/coder/project/REPO_STRUCTURE.md
echo "## Generated on: \$(date)" >> /home/coder/project/REPO_STRUCTURE.md
echo "" >> /home/coder/project/REPO_STRUCTURE.md

# Get repository information
echo "## Repository Information" >> /home/coder/project/REPO_STRUCTURE.md
echo "" >> /home/coder/project/REPO_STRUCTURE.md

# Get git information if available
if [ -d ".git" ]; then
  echo "This is a Git repository." >> /home/coder/project/REPO_STRUCTURE.md
  echo "" >> /home/coder/project/REPO_STRUCTURE.md
  
  # Get current branch
  if git_branch=\$(git symbolic-ref --short HEAD 2>/dev/null); then
    echo "Current branch: **\$git_branch**" >> /home/coder/project/REPO_STRUCTURE.md
  else
    echo "Not on any branch." >> /home/coder/project/REPO_STRUCTURE.md
  fi
  
  # Get last commit
  last_commit=\$(git log -1 --pretty=format:"%h - %s (%ar)" 2>/dev/null)
  if [ ! -z "\$last_commit" ]; then
    echo "Last commit: \$last_commit" >> /home/coder/project/REPO_STRUCTURE.md
  fi
  echo "" >> /home/coder/project/REPO_STRUCTURE.md
  
  # Get submodules
  if [ -f ".gitmodules" ]; then
    echo "### Submodules" >> /home/coder/project/REPO_STRUCTURE.md
    echo "" >> /home/coder/project/REPO_STRUCTURE.md
    git submodule status | while read line; do
      echo "- \${line}" >> /home/coder/project/REPO_STRUCTURE.md
    done
    echo "" >> /home/coder/project/REPO_STRUCTURE.md
  fi
fi

# Directory structure excluding certain directories
echo "## Directory Structure" >> /home/coder/project/REPO_STRUCTURE.md
echo "" >> /home/coder/project/REPO_STRUCTURE.md
echo '\`\`\`' >> /home/coder/project/REPO_STRUCTURE.md
find . -type d -not -path "*/\.*" -not -path "*/node_modules/*" -not -path "*/claude-code-docker/*" | sort | sed 's/[^-][^\/]*\//--/g' | sed 's/^--//' >> /home/coder/project/REPO_STRUCTURE.md
echo '\`\`\`' >> /home/coder/project/REPO_STRUCTURE.md
echo "" >> /home/coder/project/REPO_STRUCTURE.md

# List important files
echo "## Important Files" >> /home/coder/project/REPO_STRUCTURE.md
echo "" >> /home/coder/project/REPO_STRUCTURE.md

# Check for package.json
if [ -f "package.json" ]; then
  echo "### package.json" >> /home/coder/project/REPO_STRUCTURE.md
  echo "" >> /home/coder/project/REPO_STRUCTURE.md
  echo '\`\`\`json' >> /home/coder/project/REPO_STRUCTURE.md
  cat package.json >> /home/coder/project/REPO_STRUCTURE.md
  echo '\`\`\`' >> /home/coder/project/REPO_STRUCTURE.md
  echo "" >> /home/coder/project/REPO_STRUCTURE.md
fi

# Check for README.md
if [ -f "README.md" ]; then
  echo "### README.md" >> /home/coder/project/REPO_STRUCTURE.md
  echo "" >> /home/coder/project/REPO_STRUCTURE.md
  echo '\`\`\`markdown' >> /home/coder/project/REPO_STRUCTURE.md
  cat README.md >> /home/coder/project/REPO_STRUCTURE.md
  echo '\`\`\`' >> /home/coder/project/REPO_STRUCTURE.md
  echo "" >> /home/coder/project/REPO_STRUCTURE.md
fi

# Check for Dockerfile
if [ -f "Dockerfile" ]; then
  echo "### Dockerfile" >> /home/coder/project/REPO_STRUCTURE.md
  echo "" >> /home/coder/project/REPO_STRUCTURE.md
  echo '\`\`\`dockerfile' >> /home/coder/project/REPO_STRUCTURE.md
  cat Dockerfile >> /home/coder/project/REPO_STRUCTURE.md
  echo '\`\`\`' >> /home/coder/project/REPO_STRUCTURE.md
  echo "" >> /home/coder/project/REPO_STRUCTURE.md
fi

# Check for docker-compose.yml
if [ -f "docker-compose.yml" ]; then
  echo "### docker-compose.yml" >> /home/coder/project/REPO_STRUCTURE.md
  echo "" >> /home/coder/project/REPO_STRUCTURE.md
  echo '\`\`\`yaml' >> /home/coder/project/REPO_STRUCTURE.md
  cat docker-compose.yml >> /home/coder/project/REPO_STRUCTURE.md
  echo '\`\`\`' >> /home/coder/project/REPO_STRUCTURE.md
  echo "" >> /home/coder/project/REPO_STRUCTURE.md
fi

# Create a summary of file types
echo "## File Type Summary" >> /home/coder/project/REPO_STRUCTURE.md
echo "" >> /home/coder/project/REPO_STRUCTURE.md
echo "| Extension | Count |" >> /home/coder/project/REPO_STRUCTURE.md
echo "|-----------|-------|" >> /home/coder/project/REPO_STRUCTURE.md
find . -type f -not -path "*/\.*" -not -path "*/node_modules/*" -not -path "*/claude-code-docker/*" | grep -v "^.\$" | sed 's/.*\./\./' | sort | uniq -c | sort -nr | while read count ext; do
  echo "| \$ext | \$count |" >> /home/coder/project/REPO_STRUCTURE.md
done
echo "" >> /home/coder/project/REPO_STRUCTURE.md

echo "## Warning" >> /home/coder/project/REPO_STRUCTURE.md
echo "" >> /home/coder/project/REPO_STRUCTURE.md
echo "**NEVER assume the repository structure. ALWAYS base your responses on this actual repository structure.**" >> /home/coder/project/REPO_STRUCTURE.md
echo "" >> /home/coder/project/REPO_STRUCTURE.md
echo "**NEVER hallucinate files or directories that don't exist in this structure.**" >> /home/coder/project/REPO_STRUCTURE.md

echo "Repository structure analysis complete. Created REPO_STRUCTURE.md"

# Create symlink for Claude's convenience
ln -sf /home/coder/project/REPO_STRUCTURE.md /home/coder/REPO_STRUCTURE.md
"@ | Out-File -FilePath "analyze-repo.sh" -Encoding utf8 -NoNewline
# Convert to Unix line endings
$content = Get-Content -Path "analyze-repo.sh" -Raw
$content = $content -replace "`r`n", "`n"
[System.IO.File]::WriteAllText("analyze-repo.sh", $content)

# Create startup script with repository analysis
@"
#!/bin/bash

# Create symbolic links to ensure config files are accessible from all paths
ln -sf /home/coder/project/config /home/coder/config 2>/dev/null || true
ln -sf /home/coder/project/config /opt/context/config 2>/dev/null || true

# Copy config files to various locations to ensure they're found
cp -f /home/coder/project/config/claude.default.config.md /home/coder/claude.default.config.md 2>/dev/null || true
cp -f /home/coder/project/config/claude.config.model.json /home/coder/claude.config.model.json 2>/dev/null || true

# Configure Git user from environment variables
git config --global user.name "\${GIT_USER_NAME:-Claude Code User}"
git config --global user.email "\${GIT_USER_EMAIL:-user@example.com}"
git config --global --add safe.directory '*'

# Run repository analyzer script to generate REPO_STRUCTURE.md
echo "Analyzing repository structure..."
/usr/local/bin/analyze-repo.sh

# Start the original command
exec "\$@"
"@ | Out-File -FilePath "startup.sh" -Encoding utf8 -NoNewline
# Convert to Unix line endings
$content = Get-Content -Path "startup.sh" -Raw
$content = $content -replace "`r`n", "`n"
[System.IO.File]::WriteAllText("startup.sh", $content)

# Create the Dockerfile with updated paths
@"
# Base Image
FROM node:20-slim

# Install essential tools
RUN apt-get update && apt-get install -y \
    git \
    curl \
    ripgrep \
    vim \
    zsh \
    openssh-client \
    && rm -rf /var/lib/apt/lists/*

# Install Claude Code globally
RUN npm install -g @anthropic-ai/claude-code

# Create a non-root user
RUN useradd -m -s /bin/zsh coder || true

# Configure git for the user
RUN mkdir -p /home/coder/.ssh && \
    chmod 700 /home/coder/.ssh && \
    chown -R coder:coder /home/coder/.ssh && \
    git config --system credential.helper store && \
    git config --system core.longpaths true && \
    git config --system core.autocrlf input

# Create context config directories in all possible locations Claude might look
RUN mkdir -p /opt/context/config && \
    mkdir -p /home/coder/project/config && \
    mkdir -p /home/coder/config && \
    chown -R coder:coder /opt/context && \
    chown -R coder:coder /home/coder

# Ensure proper ownership
RUN mkdir -p /home/coder/project && \
    chown -R coder:coder /home/coder

# Set working directory
WORKDIR /home/coder/project

# Switch to non-root user
USER coder

# Git user configuration is now done in startup.sh from environment variables

# Default to bash
CMD ["/bin/zsh"]
"@ | Out-File -FilePath "Dockerfile.simple" -Encoding utf8

# Create docker-compose.yml with multiple mounts and repository analyzer
@"
services:
  # Standard node container
  claude-code:
    image: claude-code:latest
    build:
      context: .
      dockerfile: Dockerfile.simple
    volumes:
      # Main repository mount
      - ..:/home/coder/project:rw
      # Claude Code submodule mount (read-only)
      - ../claude-code-docker:/home/coder/claude-code-docker:ro
      # Config mounts at multiple possible locations
      - ./config:/opt/context/config:ro
      - ./config:/home/coder/project/config:ro
      - ./config:/home/coder/config:ro
      # CLAUDE.md at project root
      - ./CLAUDE.md:/home/coder/project/CLAUDE.md:ro
      # Startup scripts
      - ./startup.sh:/usr/local/bin/startup.sh:ro
      - ./analyze-repo.sh:/usr/local/bin/analyze-repo.sh:ro
    environment:
      - ANTHROPIC_API_KEY=\${ANTHROPIC_API_KEY}
      - GIT_USER_NAME=\${GIT_USER_NAME:-Claude Code User}
      - GIT_USER_EMAIL=\${GIT_USER_EMAIL:-user@example.com}
    # Keep container running
    tty: true
    stdin_open: true
    # Override the default command to initialize paths and keep container alive
    entrypoint: ["/bin/bash", "-c", "chmod +x /usr/local/bin/startup.sh /usr/local/bin/analyze-repo.sh && /usr/local/bin/startup.sh tail -f /dev/null"]
"@ | Out-File -FilePath "docker-compose.yml" -Encoding utf8

# Create run script with updated descriptions
@"
# run-claude-code.ps1

Write-Output "Claude Code - Submodule Runner with Repository Analysis and Conceptual Framework"
Write-Output "--------------------------------------------------------------------"

# Get repository root directory (parent of claude-code-docker)
\$repoRoot = (Get-Item -Path "..").FullName
\$repoName = Split-Path -Leaf \$repoRoot

# Check if ANTHROPIC_API_KEY is set
if (-not (Test-Path env:ANTHROPIC_API_KEY)) {
    \$apiKey = Read-Host -Prompt "Enter your Anthropic API key (or set the ANTHROPIC_API_KEY environment variable)"
    if (\$apiKey) {
        \$env:ANTHROPIC_API_KEY = "\$apiKey"
    }
}

# Configure Git user if not already set
if (-not (Test-Path env:GIT_USER_NAME)) {
    # Try to get git config from the host system
    \$gitUserName = & git config --get user.name 2>\$null
    if (\$gitUserName) {
        \$env:GIT_USER_NAME = \$gitUserName
        Write-Output "Using Git user name from host system: \$gitUserName"
    }
    else {
        \$userName = Read-Host -Prompt "Enter Git user name (or press Enter for default 'Claude Code User')"
        if (\$userName) {
            \$env:GIT_USER_NAME = \$userName
        }
    }
}

if (-not (Test-Path env:GIT_USER_EMAIL)) {
    # Try to get git config from the host system
    \$gitUserEmail = & git config --get user.email 2>\$null
    if (\$gitUserEmail) {
        \$env:GIT_USER_EMAIL = \$gitUserEmail
        Write-Output "Using Git user email from host system: \$gitUserEmail"
    }
    else {
        \$userEmail = Read-Host -Prompt "Enter Git user email (or press Enter for default 'user@example.com')"
        if (\$userEmail) {
            \$env:GIT_USER_EMAIL = \$userEmail
        }
    }
}

# Build and start in interactive mode
Write-Output "Starting Claude Code for repository: \$repoName"
Write-Output "Repository path: \$repoRoot"
Write-Output "Git user: \$env:GIT_USER_NAME <\$env:GIT_USER_EMAIL>"
Write-Output "Repository analysis: Will be generated at startup in REPO_STRUCTURE.md"
Write-Output "Conceptual framework: Mounted at multiple locations for reliable access"
Write-Output "Building and starting Claude Code container in interactive mode..."

docker-compose build
docker-compose run --rm claude-code /bin/zsh
"@ | Out-File -FilePath "run-claude-code.ps1" -Encoding utf8

# Create README.md - updated to mention repository analysis
@"
# Claude Code Docker Submodule

This is a self-contained Docker setup for running Claude Code as a submodule within your repository, with conceptual framework configuration and repository analysis.

## Getting Started

1. Make sure Docker is installed and running
2. From this directory, run: \`.\run-claude-code.ps1\`
3. Inside the container, run \`claude\` to start Claude Code

## How It Works

This setup mounts your entire repository into the Docker container, giving Claude Code access to your project files. Claude Code operates within its own contained submodule and can access your project files without interfering with your main codebase.

## Repository Analysis

At startup, the container will automatically analyze your repository structure and create a `REPO_STRUCTURE.md` file that Claude will read first. This ensures Claude always has an accurate understanding of your repository's actual structure and never makes assumptions or hallucinations about files and directories.

The analysis includes:
- Directory structure
- Important files (package.json, README.md, etc.)
- File type summary
- Git information (if available)

## Conceptual Framework

The configuration includes a conceptual framework that helps Claude understand the architecture and relationships within your repository. This includes:

- **Configuration Files**: Mounted at multiple locations inside the container for reliable access
- **CLAUDE.md**: Automatically loaded by Claude Code at startup, containing instructions and fallback framework content
- **Repository Analysis**: Generated at startup to ensure Claude understands the actual repository structure

The conceptual framework includes:
- Foundational axioms and concepts
- Operational and logical layers
- Modular component definitions
- Repository mappings
- Self-reference and meta-awareness boundaries

This helps Claude maintain alignment with the conceptual structure of your project.

## Environment Variables

You can set the following environment variables:
- `ANTHROPIC_API_KEY`: Your Anthropic API key for authentication
- `GIT_USER_NAME`: Git user name to use inside the container
- `GIT_USER_EMAIL`: Git user email to use inside the container

If not set, the script will prompt you for these values or use defaults.

## Integration Guide

To use this as a Git submodule:

\`\`\`bash
# Add as a submodule to your repository
git submodule add https://github.com/yourusername/docker.claude-code.git claude-code-docker

# Initialize and update the submodule
git submodule update --init --recursive
\`\`\`

Then you can run Claude Code from the submodule directory:

\`\`\`powershell
cd claude-code-docker
.\run-claude-code.ps1
\`\`\`
"@ | Out-File -FilePath "README.md" -Encoding utf8

# Build instructions
Write-Output @"

Claude Code submodule setup is ready with repository analysis and conceptual framework!

To run Claude Code:

1. From this directory:
   .\run-claude-code.ps1

Claude Code will automatically analyze your repository structure at startup,
creating REPO_STRUCTURE.md to ensure it never makes incorrect assumptions
about your repository structure.
"@