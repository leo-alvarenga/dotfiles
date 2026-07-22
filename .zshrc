# Root user cache location
CACHE_HOME="$XDG_CACHE_HOME:-$HOME/.cache}"


# Where zinit and its plugins will be store
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"
ZINIT_REPO_URL="https://github.com/zdharma-continuum/zinit.git"

# If the zinit dir does not exist, clone its repo
if [[ ! -d "$ZINIT_HOME" ]]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone "$ZINIT_REPO_URL" "$ZINIT_HOME"
fi

source "$ZINIT_HOME/zinit.zsh"

# QoL plugins
zinit light zsh-users/zsh-syntax-highlighting # Sets up syntax hightlighting
zinit light zsh-users/zsh-completions # Extend completions
zinit light zsh-users/zsh-autosuggestions # Enable smart auto-suggestions
zinit light Aloxaf/fzf-tab # Enable fuzzy finding when completing wit Tab


# Snippet -> Source from [remote or local] file
# OMZ -> Oh My Zsh -> Shorthand for https://github.com/ohmyzsh/ohmyzsh/raw/master/
#  " L -> " /lib/ 
#  "  P -> " /plugins/ 
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::aws
zinit snippet OMZP::command-not-found


# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

bindkey -v
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region


# History
HISTSIZE=5000
HISTFILE=$HOME/.zsh-history
SAVEHIST=$HISTSIZE
HISTDUP=erase

# History related options
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space # Commans prefixed with ' ' will not be saved in history
# ensuring sequentialy duplicate commands in wont be saved
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups


# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # Ensure its case insensitive
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:completion:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:completion:__zoxide_z"*' fzf-preview 'ls --color $realpath'


# Aliases and important vars
EDITOR=nvim

# If lsd is available, use it as the default ls command
if command -v lsd &> /dev/null; then
    alias ls='lsd'
fi


if command -v batcat &> /dev/null; then
    alias bat='batcat'
fi

alias ccat='env cat' # Saving the original cat command for when we need it
alias cat='bat --paging=never --style=plain' # Use bat for cat with no paging and plain style
alias ll='ls --blocks "name,date"'


alias z='zoxide'
alias c='clear'
alias ed='$EDITOR'
alias cfg='cd $HOME/.config && $EDITOR .'
alias ":q"='exit'

######################################################
# Git aliases
alias gbranch='git branch | grep "*" | cut -d " " -f2'
alias gs='git status'

alias gaa='git add .' # Add all
alias gcb-ai='git checkout -b "$(ai-branch)"'
alias ga='git add' # Add specific file
alias gcm='git commit -m'
alias gcm-ai='git commit -m "$(ai-commit)"'
alias gcm-ai-long='git commit -m "$(ai-commit -l)" --no-verify'
alias gc='git commit'

alias gpush='git push'
alias gpushnew='gpush -u origin $(gbranch)'
alias gpull='git pull'
alias gfetch='git fetch'
######################################################

######################################################
# AI Integration
if [[ -f "$HOME/.config/zsh/ai-integration.zsh" ]]; then
  source "$HOME/.config/zsh/ai-integration.zsh"
fi
######################################################

export PATH="$PATH:/opt/nvim-linux-x86_64/bin"

bindkey -v

# Other shell integrations
eval "$(zoxide init zsh --cmd cd)"

# Auto generated stuff starts here

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# opencode
export PATH=/home/lasilva/.opencode/bin:$PATH

eval "$(starship init zsh)"

# pnpm
export PNPM_HOME="/home/lasilva/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac
# pnpm end

######################################################
# Greeter
if [[ -f "$HOME/.config/zsh/greeter/greeter.zsh" ]]; then
  source "$HOME/.config/zsh/greeter/greeter.zsh"
fi
######################################################

######################################################
# Personal helpers
if [[ -d "$HOME/.config/personal_helpers" ]]; then
  source "$HOME/.config/personal_helpers/index"
fi
######################################################


