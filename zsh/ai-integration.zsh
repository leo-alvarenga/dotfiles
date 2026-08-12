#!/usr/bin/env zsh
# AI Integration Functions for Terminal Workflow
# Sourced by ~/.zshrc
#
# Uses 'pi' (coding agent harness) with the opencode provider for free models.

# ---------------------------------------------------------------------------
# Configuration
# ---------------------------------------------------------------------------

# Default AI model (provider/model format)
AI_DEFAULT_MODEL="opencode/deepseek-v4-flash-free"

# Default thinking level (pi: off, minimal, low, medium, high, xhigh, max)
AI_DEFAULT_THINKING="off"

# Timeout for AI calls in seconds (0 = no timeout)
AI_TIMEOUT=30

# Recognised thinking levels
AI_THINKING_LEVELS=(off minimal low medium high xhigh max)

# Model list cache (refreshed daily)
AI_MODEL_CACHE="$HOME/.cache/ai-models.list"

# ---------------------------------------------------------------------------
# Internal helpers
# ---------------------------------------------------------------------------

# Check that pi is available
_ai_check_deps() {
  if ! command -v pi &>/dev/null; then
    echo "Error: 'pi' is not installed or not in PATH" >&2
    return 1
  fi
}

# Shared wrapper to call pi in print mode.
# $1 = model, $2 = thinking level, $3 = prompt
_ai_pi_call() {
  local model="${1:-$AI_DEFAULT_MODEL}"
  local thinking="${2:-$AI_DEFAULT_THINKING}"
  local prompt="$3"

  _ai_check_deps || return 1

  local cmd=(
    pi -p --no-session
    --model "$model"
  )

  [[ "$thinking" != "off" ]] && cmd+=(--thinking "$thinking")

  if (( AI_TIMEOUT > 0 )) && command -v timeout &>/dev/null; then
    cmd=(timeout "$AI_TIMEOUT" "${cmd[@]}")
  fi

  # Run pi; stderr goes to terminal (first few lines only to avoid noise),
  # stdout is cleaned of trailing whitespace and blank lines.
  "${cmd[@]}" "$prompt" 2> >(grep -v '^$' | tail -5 >&2) \
    | sed -e 's/[[:space:]]*$//' -e '/^$/d'
}

# Refresh the cached model list once per day
_ai_refresh_model_cache() {
  _ai_check_deps || return 1

  local cache_dir="${AI_MODEL_CACHE:h}"
  [[ -d "$cache_dir" ]] || mkdir -p "$cache_dir"

  if [[ ! -f "$AI_MODEL_CACHE" ]] || (( $(date +%s) - $(stat -c %Y "$AI_MODEL_CACHE" 2>/dev/null || echo 0) > 86400 )); then
    pi --list-models 2>/dev/null | grep -E '^[a-z]' | awk '{print $2}' > "$AI_MODEL_CACHE" 2>/dev/null
  fi
}

# ---------------------------------------------------------------------------
# ai-models: List available AI models (cached daily)
# Usage: ai-models [filter]
# ---------------------------------------------------------------------------
ai-models() {
  _ai_refresh_model_cache

  if [[ -n "$1" ]]; then
    grep -i "$1" "$AI_MODEL_CACHE" 2>/dev/null || echo "(no matches for '$1')"
  else
    cat "$AI_MODEL_CACHE" 2>/dev/null || echo "(no models cached — run 'pi --list-models' manually)"
  fi
}

# ---------------------------------------------------------------------------
# ai-branch: Generate git branch name suggestion based on changes
# Usage: ai-branch [-m|--model MODEL] [-t|--thinking LEVEL] [-h|--help]
# ---------------------------------------------------------------------------
ai-branch() {
  local -A opts
  zparseopts -D -E -A opts \
    m: -model: \
    t: -thinking: \
    h -help

  if (( ${+opts[-h]} )) || (( ${+opts[--help]} )); then
    cat << 'HELP'
Usage: ai-branch [-m|--model MODEL] [-t|--thinking LEVEL] [-h|--help]

Generate git branch name suggestion based on changes.

Options:
  -m, --model MODEL        AI model (default: opencode/deepseek-v4-flash-free)
  -t, --thinking LEVEL     Thinking level: off, minimal, low, medium, high,
                           xhigh, max (default: off)
  -h, --help               Show this help message
HELP
    return 0
  fi

  local model="${opts[-m]:-${opts[--model]:-$AI_DEFAULT_MODEL}}"
  local thinking="${opts[-t]:-${opts[--thinking]:-$AI_DEFAULT_THINKING}}"

  local git_status=$(git status --short 2>/dev/null)
  local git_diff=$(git diff --stat 2>/dev/null)
  local current_branch=$(git branch --show-current 2>/dev/null)
  local recent_commits=$(git log --oneline -3 2>/dev/null)

  if [[ -z "$current_branch" && -z "$git_status" ]]; then
    echo "Error: Not in a git repository" >&2
    return 1
  fi

  local hotfix_hint=""
  if echo "$recent_commits" | grep -iq "hotfix"; then
    hotfix_hint="Note: Recent commits mention 'hotfix' — prefer hotfix/ over bugfix/ for production emergencies."
  fi

  local prompt="Output ONLY a git branch name in the format: type/description

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
- Use bugfix/ not fix/ (unless production emergency → hotfix/)
- Use kebab-case for description
- Other types: chore/, docs/, refactor/, test/, style/, perf/, ci/, build/
- Output ONLY the branch name, nothing else
${hotfix_hint}"

  local result
  result=$(_ai_pi_call "$model" "$thinking" "$prompt")
  [[ -n "$result" ]] && echo "$result" || echo "Error: empty response from AI" >&2
}

# ---------------------------------------------------------------------------
# ai-commit: Generate commit message from staged changes
# Usage: ai-commit [-m|--model MODEL] [-t|--thinking LEVEL] [-l|--long] [-h|--help]
# ---------------------------------------------------------------------------
ai-commit() {
  local -A opts
  zparseopts -D -E -A opts \
    m: -model: \
    t: -thinking: \
    l -long \
    h -help

  if (( ${+opts[-h]} )) || (( ${+opts[--help]} )); then
    cat << 'HELP'
Usage: ai-commit [-m|--model MODEL] [-t|--thinking LEVEL] [-l|--long] [-h|--help]

Generate commit message from staged changes.

Options:
  -m, --model MODEL        AI model (default: opencode/deepseek-v4-flash-free)
  -t, --thinking LEVEL     Thinking level: off, minimal, low, medium, high,
                           xhigh, max (default: off)
  -l, --long               Generate detailed commit with body and footer
  -h, --help               Show this help message
HELP
    return 0
  fi

  local model="${opts[-m]:-${opts[--model]:-$AI_DEFAULT_MODEL}}"
  local thinking="${opts[-t]:-${opts[--thinking]:-$AI_DEFAULT_THINKING}}"
  local long_format=$(( ${+opts[-l]} || ${+opts[--long]} ))

  if ! git rev-parse --is-inside-work-tree &>/dev/null; then
    echo "Error: Not in a git repository" >&2
    return 1
  fi

  local staged_files=$(git status --short | grep '^[MARC]' 2>/dev/null)
  local cached_stat=$(git diff --cached --stat 2>/dev/null)
  local current_branch=$(git branch --show-current 2>/dev/null)
  local recent_commits=$(git log --pretty=format:"%s" -5 2>/dev/null || echo "No previous commits")

  if [[ -z "$cached_stat" ]]; then
    echo "Error: No staged changes to commit" >&2
    return 1
  fi

  local cached_diff
  if (( long_format )); then
    cached_diff=$(git diff --cached 2>/dev/null | head -50)
  else
    cached_diff=$(git diff --cached 2>/dev/null | head -20)
  fi

  local prompt
  if (( long_format )); then
    prompt="Output ONLY a git commit message in Conventional Commits format with body and optional footer.

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
- Body: explain what and why (not how), wrap at 72 chars
- Footer: only if there are breaking changes or references
- Types: feat, fix, chore, docs, refactor, test, style, perf, ci, build
- Blank line between subject/body and body/footer
- Output ONLY the commit message, nothing else"
  else
    prompt="Output ONLY a git commit message in Conventional Commits format.

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

  local result
  result=$(_ai_pi_call "$model" "$thinking" "$prompt")
  [[ -n "$result" ]] && echo "$result" || echo "Error: empty response from AI" >&2
}

# ---------------------------------------------------------------------------
# ai-shell: Generate a shell command from a natural-language description
# Usage: ai-shell [-m|--model MODEL] [-t|--thinking LEVEL] "description"
# ---------------------------------------------------------------------------
ai-shell() {
  local -A opts
  zparseopts -D -E -A opts \
    m: -model: \
    t: -thinking: \
    h -help

  if (( ${+opts[-h]} )) || (( ${+opts[--help]} )); then
    cat << 'HELP'
Usage: ai-shell [-m|--model MODEL] [-t|--thinking LEVEL] "description"

Generate a shell command from a natural-language description.

Options:
  -m, --model MODEL        AI model (default: opencode/deepseek-v4-flash-free)
  -t, --thinking LEVEL     Thinking level: off, minimal, low, medium, high,
                           xhigh, max (default: off)
  -h, --help               Show this help message

Examples:
  ai-shell "find all .ts files modified in the last week and count lines"
  ai-shell "recursively delete all node_modules directories"
  ai-shell "show disk usage for each directory in /var/log"
HELP
    return 0
  fi

  local model="${opts[-m]:-${opts[--model]:-$AI_DEFAULT_MODEL}}"
  local thinking="${opts[-t]:-${opts[--thinking]:-$AI_DEFAULT_THINKING}}"
  local query="$*"

  if [[ -z "$query" ]]; then
    echo "Error: Please provide a description of what you want to do" >&2
    return 1
  fi

  local os_info="OS: $(uname -s), Shell: ${SHELL##*/}"
  local prompt="Output ONLY a single safe, correct shell command that: ${query}

Context: ${os_info}, CWD: ${PWD}

Rules:
- Output ONLY the command, nothing else — no explanation, no markdown fences
- The command must work in ${SHELL##*/}
- Prefer portable POSIX constructs when possible
- Avoid destructive operations unless explicitly requested
- Use long options (--help) over short (-h) for readability"

  local result
  result=$(_ai_pi_call "$model" "$thinking" "$prompt")

  if [[ -z "$result" ]]; then
    echo "Error: empty response from AI" >&2
    return 1
  fi

  echo "$result"

  # If invoked as a zle widget, place command into the edit buffer
  if [[ -n "$BUFFER" ]]; then
    BUFFER="$result"
    zle end-of-line
  fi
}

# ai-shell as zle widget (bind to a key with: bindkey '^o' ai-shell)
zle -N ai-shell

# ---------------------------------------------------------------------------
# ai-explain: Explain code, a command, or piped input
# Usage: ai-explain [-m|--model MODEL] [-t|--thinking LEVEL] [file|command...]
#        echo "some code" | ai-explain [-m MODEL]
# ---------------------------------------------------------------------------
ai-explain() {
  local -A opts
  zparseopts -D -E -A opts \
    m: -model: \
    t: -thinking: \
    h -help

  if (( ${+opts[-h]} )) || (( ${+opts[--help]} )); then
    cat << 'HELP'
Usage: ai-explain [-m|--model MODEL] [-t|--thinking LEVEL] [file|command...]

Explain code, a shell command, or piped input.

Options:
  -m, --model MODEL        AI model (default: opencode/deepseek-v4-flash-free)
  -t, --thinking LEVEL     Thinking level: off, minimal, low, medium, high,
                           xhigh, max (default: off)
  -h, --help               Show this help message

Examples:
  ai-explain 'tar -xzvf archive.tar.gz'       # Explain a command
  ai-explain src/complicated.py                # Explain a file
  cat Makefile | ai-explain                    # Explain piped content
  git diff HEAD~1 | ai-explain                 # Explain a diff
HELP
    return 0
  fi

  local model="${opts[-m]:-${opts[--model]:-$AI_DEFAULT_MODEL}}"
  local thinking="${opts[-t]:-${opts[--thinking]:-$AI_DEFAULT_THINKING}}"

  local input

  # If there's piped stdin, read it
  if [[ ! -t 0 ]]; then
    input=$(cat)
  fi

  # If arguments were given, use them
  if [[ -n "$*" ]]; then
    # Check if it looks like a file path (exists and is readable)
    if [[ -f "$1" && -r "$1" ]]; then
      input=$(< "$1")
    else
      # Treat all arguments as a string to explain (e.g. a command)
      input="$*"
    fi
  fi

  if [[ -z "$input" ]]; then
    echo "Error: No input provided. Pipe something, pass a filename, or provide text." >&2
    return 1
  fi

  # Truncate very long input — keep costs predictable
  local max_input=8000
  if (( ${#input} > max_input )); then
    input="${input:0:$max_input}"
    input+=$'\n\n[...truncated — input too long]'
  fi

  local lang_hint=""
  # If it came from a file, add the extension as a hint
  if [[ -f "$1" ]]; then
    lang_hint="(file: ${1##*/}, extension: .${1:e})"
  # If it came from stdin and looks like a diff
  elif echo "$input" | head -1 | grep -qE '^(diff |--- |\+\+\+ |@@ )'; then
    lang_hint="(this is a unified diff)"
  fi

  local prompt="Explain the following clearly and concisely. ${lang_hint}

Rules:
- Start with a 1-2 line summary of what this does
- Then break down the key parts in bullet points
- Point out any notable patterns, tricks, or potential pitfalls
- Keep the explanation practical and actionable
- Do NOT just restate the code — explain the *why*

Input:
${input}"

  local result
  result=$(_ai_pi_call "$model" "$thinking" "$prompt")

  if [[ -z "$result" ]]; then
    echo "Error: empty response from AI" >&2
    return 1
  fi

  # Output — page through bat/less if it's long
  if (( ${#result} > 1000 )) && command -v bat &>/dev/null; then
    echo "$result" | bat --paging=always --style=plain --language=markdown
  elif (( ${#result} > 1000 )); then
    echo "$result" | less -R
  else
    echo "$result"
  fi
}

# ---------------------------------------------------------------------------
# Zsh completions
# ---------------------------------------------------------------------------

# Common model argument completion — uses cached model list
_ai_models() {
  _ai_refresh_model_cache
  local -a models
  if [[ -f "$AI_MODEL_CACHE" ]]; then
    models=(${(f)"$(< "$AI_MODEL_CACHE")"})
  fi
  _describe 'model' models
}

# Common thinking-level argument completion
_ai_thinking_levels() {
  _describe 'thinking level' AI_THINKING_LEVELS
}

# --- ai-branch completions ---
_ai_branch() {
  local context state state_descr line
  typeset -A opt_args

  _arguments \
    '(-m --model)'{-m,--model}'[AI model]:model:_ai_models' \
    '(-t --thinking)'{-t,--thinking}'[thinking level]:level:_ai_thinking_levels' \
    '(-h --help)'{-h,--help}'[show help]'
}

# --- ai-commit completions ---
_ai_commit() {
  local context state state_descr line
  typeset -A opt_args

  _arguments \
    '(-m --model)'{-m,--model}'[AI model]:model:_ai_models' \
    '(-t --thinking)'{-t,--thinking}'[thinking level]:level:_ai_thinking_levels' \
    '(-l --long)'{-l,--long}'[generate detailed commit with body and footer]' \
    '(-h --help)'{-h,--help}'[show help]'
}

# --- ai-shell completions ---
_ai_shell() {
  local context state state_descr line
  typeset -A opt_args

  _arguments \
    '(-m --model)'{-m,--model}'[AI model]:model:_ai_models' \
    '(-t --thinking)'{-t,--thinking}'[thinking level]:level:_ai_thinking_levels' \
    '(-h --help)'{-h,--help}'[show help]' \
    '*::description: '
}

# --- ai-explain completions ---
_ai_explain() {
  local context state state_descr line
  typeset -A opt_args

  _arguments \
    '(-m --model)'{-m,--model}'[AI model]:model:_ai_models' \
    '(-t --thinking)'{-t,--thinking}'[thinking level]:level:_ai_thinking_levels' \
    '(-h --help)'{-h,--help}'[show help]' \
    '*:file or text:_files'
}

# --- ai-models completions ---
_ai_models_cmd() {
  _arguments \
    '1:filter: '
}

# Register completions for all ai-* functions
compdef _ai_branch ai-branch
compdef _ai_commit ai-commit
compdef _ai_shell ai-shell
compdef _ai_explain ai-explain
compdef _ai_models_cmd ai-models
