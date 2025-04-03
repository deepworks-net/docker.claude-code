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