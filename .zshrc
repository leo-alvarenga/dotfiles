# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.

SHOULD_SETUP_P10K="${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"

if [[ -r $SHOULD_SETUP_P10K  ]]; then
  source "$SHOULD_SETUP_P10K"
fi

# Root user cache location
CACHE_HOME="$XDG_CACHE_HOME:-$HOME/.cache}"

# Wherel p10k prompt config cache will be placed
PTENK_CACHE="$CACHE_HOME/p10k-instant-prompt-${(%):-%n}.zsh"

if [[ -r "$PTENK_CACHE" ]]; then
  source "$PTENK_CACHE"
fi

# Where zinit and its plugins will be store
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"
ZINIT_REPO_URL="https://github.com/zdharma-continuum/zinit.git"

# If the zinit dir does not exist, clone its repo
if [[ ! -d "$ZINIT_HOME" ]]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone "$ZINIT_REPO_URL" "$ZINIT_HOME"
fi

source "$ZINIT_HOME/zinit.zsh"

# Install p10k -> Prompt script
zinit ice depth=1; zinit light romkatv/powerlevel10k

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
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
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

alias ls='ls --color'
alias z='zoxide'
alias c='clear'
alias ed='$EDITOR'
alias cfg='cd $HOME/.config && $EDITOR .'
alias ":q"='exit'

# Git aliases
alias gbranch='git branch | grep "*" | cut -d " " -f2'
alias gs='git status'
alias ga='git add .'
alias gc='git commit -m'
alias gpush='git push'
alias gpushnew='gpush -u origin $(gbranch)'
alias gpull='git pull'


bindkey -v

# Other shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"

# Auto generated stuff starts here

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
