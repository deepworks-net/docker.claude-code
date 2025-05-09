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
    less \
    jq \
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

# Copy Max Plan documentation (will be added by docker-compose volume mounts)
RUN mkdir -p /home/coder/docs && \
    chown -R coder:coder /home/coder/docs

# Set working directory
WORKDIR /home/coder/project

# Switch to non-root user
USER coder

# Configure git for the user
RUN git config --global user.name "Claude Code User" && \
    git config --global user.email "user@example.com" && \
    git config --global --add safe.directory '*'

# Add Claude Code with Max plan support documentation to zsh welcome
RUN echo 'if [ -f /home/coder/claude-welcome.txt ]; then cat /home/coder/claude-welcome.txt; fi' >> ~/.zshrc

# Default to zsh
CMD ["/bin/zsh"]