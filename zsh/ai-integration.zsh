#!/usr/bin/env zsh
# AI Integration Functions for Terminal Workflow
# Sourced by ~/.zshrc

# Default AI model configuration
AI_DEFAULT_MODEL="opencode/deepseek-v4-flash-free"
AI_DEFAULT_VARIANT=""  # Not needed for free OpenCode models

# ai-branch: Generate git branch name suggestion based on changes
# Usage: ai-branch [-m|--model MODEL] [-v|--variant VARIANT] [-h|--help]
ai-branch() {
  # Parse flags
  local -A opts
  zparseopts -D -E -A opts \
    m: -model: \
    v: -variant: \
    h -help
  
  # Handle help
  if (( ${+opts[-h]} )) || (( ${+opts[--help]} )); then
    cat << 'HELP'
Usage: ai-branch [-m|--model MODEL] [-v|--variant VARIANT] [-h|--help]

Generate git branch name suggestion based on changes.

Options:
  -m, --model MODEL      AI model to use (default: opencode/deepseek-v4-flash-free)
  -v, --variant VARIANT  Model variant/reasoning effort (default: none)
  -h, --help            Show this help message
HELP
    return 0
  fi
  
  # Extract flag values
  local model="${opts[-m]:-${opts[--model]:-$AI_DEFAULT_MODEL}}"
  local variant="${opts[-v]:-${opts[--variant]:-$AI_DEFAULT_VARIANT}}"
  
  # Gather git context
  local git_status=$(git status --short 2>/dev/null)
  local git_diff=$(git diff --stat 2>/dev/null)
  local current_branch=$(git branch --show-current 2>/dev/null)
  local recent_commits=$(git log --oneline -3 2>/dev/null)
  
  # Check if we're in a git repository
  if [[ -z "$current_branch" && -z "$git_status" ]]; then
    echo "Error: Not in a git repository" >&2
    return 1
  fi
  
  # Check for hotfix mentions in recent commits
  local hotfix_hint=""
  if echo "$recent_commits" | grep -iq "hotfix"; then
    hotfix_hint="Note: Recent commits mention 'hotfix' - prefer hotfix/ over bugfix/ if this is a production emergency fix."
  fi
  
  # Build the prompt
  local prompt="Output only a git branch name in the format: type/description

Context:
Current branch: ${current_branch:-none}
Modified files:
${git_status}

Changes summary:
${git_diff}

Recent commits:
${recent_commits}

Rules:
- Use feature/ not feat/
- Use bugfix/ not fix/ (unless this is a production emergency, then use hotfix/)
- Use kebab-case for description
- Other types: chore/, docs/, refactor/, test/, style/, perf/, ci/, build/
- Output ONLY the branch name, nothing else
${hotfix_hint}"

  # Call opencode and clean the output
  local result
  if [[ -n "$variant" ]]; then
    result=$(opencode run -m "$model" --variant "$variant" "$prompt" 2>&1 | \
      sed 's/\x1b\[[0-9;]*m//g' | \
      grep -v '^>' | \
      grep -v '·' | \
      grep -v '^[[:space:]]*$' | \
      tail -1 | \
      xargs)
  else
    result=$(opencode run -m "$model" "$prompt" 2>&1 | \
      sed 's/\x1b\[[0-9;]*m//g' | \
      grep -v '^>' | \
      grep -v '·' | \
      grep -v '^[[:space:]]*$' | \
      tail -1 | \
      xargs)
  fi
  
  echo "$result"
}

# ai-commit: Generate commit message from staged changes
# Usage: ai-commit [-m|--model MODEL] [-v|--variant VARIANT] [-l|--long] [-h|--help]
ai-commit() {
  # Parse flags
  local -A opts
  zparseopts -D -E -A opts \
    m: -model: \
    v: -variant: \
    l -long \
    h -help
  
  # Handle help
  if (( ${+opts[-h]} )) || (( ${+opts[--help]} )); then
    cat << 'HELP'
Usage: ai-commit [-m|--model MODEL] [-v|--variant VARIANT] [-l|--long] [-h|--help]

Generate commit message from staged changes.

Options:
  -m, --model MODEL      AI model to use (default: opencode/deepseek-v4-flash-free)
  -v, --variant VARIANT  Model variant/reasoning effort (default: none)
  -l, --long            Generate detailed commit with body and footer
  -h, --help            Show this help message
HELP
    return 0
  fi
  
  # Extract flag values
  local model="${opts[-m]:-${opts[--model]:-$AI_DEFAULT_MODEL}}"
  local variant="${opts[-v]:-${opts[--variant]:-$AI_DEFAULT_VARIANT}}"
  local long_format=$(( ${+opts[-l]} || ${+opts[--long]} ))
  
  # Check if we're in a git repository
  if ! git rev-parse --is-inside-work-tree &>/dev/null; then
    echo "Error: Not in a git repository" >&2
    return 1
  fi
  
  # Gather git context - staged changes only
  local staged_files=$(git status --short | grep '^[MARC]' 2>/dev/null)
  local cached_stat=$(git diff --cached --stat 2>/dev/null)
  local current_branch=$(git branch --show-current 2>/dev/null)
  local recent_commits=$(git log --pretty=format:"%s" -5 2>/dev/null || echo "No previous commits")
  
  # Check if there are staged changes
  if [[ -z "$cached_stat" ]]; then
    echo "Error: No staged changes to commit" >&2
    return 1
  fi
  
  # Conditional context gathering based on format
  local cached_diff
  if (( long_format )); then
    cached_diff=$(git diff --cached 2>/dev/null | head -50)
  else
    cached_diff=$(git diff --cached 2>/dev/null | head -20)
  fi
  
  # Build the prompt based on format
  local prompt
  if (( long_format )); then
    # Long format: with body and footer
    prompt="Output only a git commit message in Conventional Commits format with body and optional footer.

Context:
Current branch: ${current_branch:-main}

Staged files:
${staged_files}

Changes summary:
${cached_stat}

Diff content:
${cached_diff}

Recent commits (for style reference):
${recent_commits}

Rules:
- Format:
  type(scope): subject line (under 72 chars)
  
  Body explaining what changed and why (wrap at 72 chars)
  
  Footer (optional): BREAKING CHANGE:, Refs:, etc.

- Subject: lowercase, imperative mood, no period
- Body: Explain what and why (not how), wrap lines at 72 chars
- Footer: Only if there are breaking changes or references
- Types: feat, fix, chore, docs, refactor, test, style, perf, ci, build
- Blank line between subject/body and body/footer
- Output ONLY the commit message, nothing else"
  else
    # Short format: single line only
    prompt="Output only a git commit message in Conventional Commits format.

Context:
Current branch: ${current_branch:-main}

Staged files:
${staged_files}

Changes summary:
${cached_stat}

First lines of diff:
${cached_diff}

Recent commits (for style reference):
${recent_commits}

Rules:
- Format: type(scope): description
- Types: feat, fix, chore, docs, refactor, test, style, perf, ci, build
- Scope is optional (e.g., nvim, zsh, tmux)
- Description: lowercase, imperative mood, no period
- Keep under 72 characters
- Single line only, no body or footer
- Output ONLY the commit message, nothing else"
  fi
  
  # Call opencode and clean the output
  local result
  if [[ -n "$variant" ]]; then
    if (( long_format )); then
      # Long format: preserve newlines, filter markdown
      result=$(opencode run -m "$model" --variant "$variant" "$prompt" 2>&1 | \
        sed 's/\x1b\[[0-9;]*m//g' | \
        grep -v '^>' | \
        grep -v '·' | \
        sed '/^```/d' | \
        awk 'NF')
    else
      # Short format: single line
      result=$(opencode run -m "$model" --variant "$variant" "$prompt" 2>&1 | \
        sed 's/\x1b\[[0-9;]*m//g' | \
        grep -v '^>' | \
        grep -v '·' | \
        grep -v '^[[:space:]]*$' | \
        tail -1 | \
        xargs)
    fi
  else
    if (( long_format )); then
      # Long format: preserve newlines, filter markdown
      result=$(opencode run -m "$model" "$prompt" 2>&1 | \
        sed 's/\x1b\[[0-9;]*m//g' | \
        grep -v '^>' | \
        grep -v '·' | \
        sed '/^```/d' | \
        awk 'NF')
    else
      # Short format: single line
      result=$(opencode run -m "$model" "$prompt" 2>&1 | \
        sed 's/\x1b\[[0-9;]*m//g' | \
        grep -v '^>' | \
        grep -v '·' | \
        grep -v '^[[:space:]]*$' | \
        tail -1 | \
        xargs)
    fi
  fi
  
  echo "$result"
}
