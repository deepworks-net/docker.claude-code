# Base Image
FROM node:20-slim

# Install essential tools and setup in a single layer
RUN apt-get update && apt-get install -y \
    git \
    curl \
    ripgrep \
    openssh-client \
    less \
    jq \
    python3 \
    python3-pip \
    python3-venv \
    && rm -rf /var/lib/apt/lists/* \
    && npm install -g @anthropic-ai/claude-code \
    && useradd -m -s /bin/bash coder || true \
    && git config --system credential.helper store \
    && git config --system core.longpaths true \
    && git config --system core.autocrlf input

# Create directory structure and set permissions in one layer
RUN mkdir -p /home/coder/.ssh \
    /opt/context/config \
    /home/coder/project/config \
    /home/coder/config \
    /home/coder/docs \
    /home/coder/project \
    && chmod 700 /home/coder/.ssh \
    && chown -R coder:coder /home/coder /opt/context

# Set working directory
WORKDIR /home/coder/project

# Switch to non-root user
USER coder

# Configure git for the user
RUN git config --global user.name "Claude Code User" && \
    git config --global user.email "user@example.com" && \
    git config --global --add safe.directory '*'

# Add Claude Code with Max plan support documentation to bash welcome
RUN echo 'if [ -f /home/coder/claude-welcome.txt ]; then cat /home/coder/claude-welcome.txt; fi' >> ~/.bashrc

# Default to bash
CMD ["/bin/bash"]