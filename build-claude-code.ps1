# claude.ps1 - Sets up Claude Code as a contained submodule with conceptual configuration

Write-Output "Setting up Claude Code as a contained submodule with conceptual configuration..."

# Create config directory
New-Item -ItemType Directory -Path "config" -Force

# Create the Conceptual Config files
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

# Create the Dockerfile
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

# Create context config directory
RUN mkdir -p /opt/context/config && \
    chown -R coder:coder /opt/context

# Ensure proper ownership
RUN mkdir -p /home/coder/project && \
    chown -R coder:coder /home/coder

# Set working directory
WORKDIR /home/coder/project

# Switch to non-root user
USER coder

# Configure git for the user
RUN git config --global user.name "Claude Code User" && \
    git config --global user.email "user@example.com" && \
    git config --global --add safe.directory '*'

# Default to bash
CMD ["/bin/zsh"]
"@ | Out-File -FilePath "Dockerfile.simple" -Encoding utf8

# Create docker-compose.yml
@"
services:
  # Standard node container
  claude-code:
    image: claude-code:latest
    build:
      context: .
      dockerfile: Dockerfile.simple
    volumes:
      - ..:/home/coder/project:rw
      - ../claude-code-docker:/home/coder/claude-code-docker:ro
      - ./config:/opt/context/config:ro
    environment:
      - ANTHROPIC_API_KEY=\${ANTHROPIC_API_KEY}
    # Keep container running
    tty: true
    stdin_open: true
    # Override the default command to keep container alive
    command: tail -f /dev/null
"@ | Out-File -FilePath "docker-compose.yml" -Encoding utf8

# Create run script
@"
# run-claude-code.ps1

Write-Output "Claude Code - Submodule Runner with Conceptual Framework"
Write-Output "-----------------------------------------------------"

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

# Build and start in interactive mode
Write-Output "Starting Claude Code for repository: \$repoName"
Write-Output "Repository path: \$repoRoot"
Write-Output "Conceptual framework: mounted at /opt/context/config/"
Write-Output "Building and starting Claude Code container in interactive mode..."

docker-compose build
docker-compose run --rm claude-code /bin/zsh
"@ | Out-File -FilePath "run-claude-code.ps1" -Encoding utf8

# Create README.md
@"
# Claude Code Docker Submodule

This is a self-contained Docker setup for running Claude Code as a submodule within your repository, with conceptual framework configuration.

## Getting Started

1. Make sure Docker is installed and running
2. From this directory, run: \`.\run-claude-code.ps1\`
3. Inside the container, run \`claude\` to start Claude Code

## How It Works

This setup mounts your entire repository into the Docker container, giving Claude Code access to your project files. Claude Code operates within its own contained submodule and can access your project files without interfering with your main codebase.

## Conceptual Framework

The configuration includes a conceptual framework that helps Claude understand the architecture and relationships within your repository. This framework is mounted at \`/opt/context/config/\` inside the container and includes:

- Foundational axioms and concepts
- Operational and logical layers
- Modular component definitions
- Repository mappings
- Self-reference and meta-awareness boundaries

This helps Claude maintain alignment with the conceptual structure of your project.

## Environment Variables

You can set the ANTHROPIC_API_KEY environment variable before running the script, or the script will prompt you for it.

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

Claude Code submodule setup is ready with conceptual framework configuration!

To run Claude Code:

1. From this directory:
   .\run-claude-code.ps1

Claude Code will have access to your entire repository as a contained submodule,
with the conceptual framework mounted at /opt/context/config/ inside the container.
"@