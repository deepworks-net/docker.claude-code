#!/bin/bash

# analyze-repo.sh
# Generates a repository structure analysis file for Claude to read first

# Ensure we're in the project directory
cd /home/coder/project || exit 1

echo "# Repository Structure Analysis" > /home/coder/project/REPO_STRUCTURE.md
echo "## Generated on: $(date)" >> /home/coder/project/REPO_STRUCTURE.md
echo "" >> /home/coder/project/REPO_STRUCTURE.md

# Get repository information
echo "## Repository Information" >> /home/coder/project/REPO_STRUCTURE.md
echo "" >> /home/coder/project/REPO_STRUCTURE.md

# Get git information if available
if [ -d ".git" ]; then
  echo "This is a Git repository." >> /home/coder/project/REPO_STRUCTURE.md
  echo "" >> /home/coder/project/REPO_STRUCTURE.md
  
  # Get current branch
  if git_branch=$(git symbolic-ref --short HEAD 2>/dev/null); then
    echo "Current branch: **$git_branch**" >> /home/coder/project/REPO_STRUCTURE.md
  else
    echo "Not on any branch." >> /home/coder/project/REPO_STRUCTURE.md
  fi
  
  # Get last commit
  last_commit=$(git log -1 --pretty=format:"%h - %s (%ar)" 2>/dev/null)
  if [ ! -z "$last_commit" ]; then
    echo "Last commit: $last_commit" >> /home/coder/project/REPO_STRUCTURE.md
  fi
  echo "" >> /home/coder/project/REPO_STRUCTURE.md
  
  # Get submodules
  if [ -f ".gitmodules" ]; then
    echo "### Submodules" >> /home/coder/project/REPO_STRUCTURE.md
    echo "" >> /home/coder/project/REPO_STRUCTURE.md
    git submodule status | while read line; do
      echo "- ${line}" >> /home/coder/project/REPO_STRUCTURE.md
    done
    echo "" >> /home/coder/project/REPO_STRUCTURE.md
  fi
fi

# Directory structure excluding certain directories
echo "## Directory Structure" >> /home/coder/project/REPO_STRUCTURE.md
echo "" >> /home/coder/project/REPO_STRUCTURE.md
echo '```' >> /home/coder/project/REPO_STRUCTURE.md
find . -type d -not -path "*/\.*" -not -path "*/node_modules/*" -not -path "*/claude-code-docker/*" | sort | sed 's/[^-][^\/]*\//--/g' | sed 's/^--//' >> /home/coder/project/REPO_STRUCTURE.md
echo '```' >> /home/coder/project/REPO_STRUCTURE.md
echo "" >> /home/coder/project/REPO_STRUCTURE.md

# List important files
echo "## Important Files" >> /home/coder/project/REPO_STRUCTURE.md
echo "" >> /home/coder/project/REPO_STRUCTURE.md

# Check for package.json
if [ -f "package.json" ]; then
  echo "### package.json" >> /home/coder/project/REPO_STRUCTURE.md
  echo "" >> /home/coder/project/REPO_STRUCTURE.md
  echo '```json' >> /home/coder/project/REPO_STRUCTURE.md
  cat package.json >> /home/coder/project/REPO_STRUCTURE.md
  echo '```' >> /home/coder/project/REPO_STRUCTURE.md
  echo "" >> /home/coder/project/REPO_STRUCTURE.md
fi

# Check for README.md
if [ -f "README.md" ]; then
  echo "### README.md" >> /home/coder/project/REPO_STRUCTURE.md
  echo "" >> /home/coder/project/REPO_STRUCTURE.md
  echo '```markdown' >> /home/coder/project/REPO_STRUCTURE.md
  cat README.md >> /home/coder/project/REPO_STRUCTURE.md
  echo '```' >> /home/coder/project/REPO_STRUCTURE.md
  echo "" >> /home/coder/project/REPO_STRUCTURE.md
fi

# Check for Dockerfile
if [ -f "Dockerfile" ]; then
  echo "### Dockerfile" >> /home/coder/project/REPO_STRUCTURE.md
  echo "" >> /home/coder/project/REPO_STRUCTURE.md
  echo '```dockerfile' >> /home/coder/project/REPO_STRUCTURE.md
  cat Dockerfile >> /home/coder/project/REPO_STRUCTURE.md
  echo '```' >> /home/coder/project/REPO_STRUCTURE.md
  echo "" >> /home/coder/project/REPO_STRUCTURE.md
fi

# Check for docker-compose.yml
if [ -f "docker-compose.yml" ]; then
  echo "### docker-compose.yml" >> /home/coder/project/REPO_STRUCTURE.md
  echo "" >> /home/coder/project/REPO_STRUCTURE.md
  echo '```yaml' >> /home/coder/project/REPO_STRUCTURE.md
  cat docker-compose.yml >> /home/coder/project/REPO_STRUCTURE.md
  echo '```' >> /home/coder/project/REPO_STRUCTURE.md
  echo "" >> /home/coder/project/REPO_STRUCTURE.md
fi

# Create a summary of file types
echo "## File Type Summary" >> /home/coder/project/REPO_STRUCTURE.md
echo "" >> /home/coder/project/REPO_STRUCTURE.md
echo "| Extension | Count |" >> /home/coder/project/REPO_STRUCTURE.md
echo "|-----------|-------|" >> /home/coder/project/REPO_STRUCTURE.md
find . -type f -not -path "*/\.*" -not -path "*/node_modules/*" -not -path "*/claude-code-docker/*" | grep -v "^.$" | sed 's/.*\./\./' | sort | uniq -c | sort -nr | while read count ext; do
  echo "| $ext | $count |" >> /home/coder/project/REPO_STRUCTURE.md
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