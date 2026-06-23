# dotfiles

my config files for a keyboard-focused, terminal-based dev workflow

## what's here

- **nvim/** - neovim config (submodule)
- **tmux/** - tmux config (submodule)
- **opencode/** - opencode config (submodule)
- **ghostty/** - ghostty terminal config
- **foot/** - foot terminal config (Currently stydying foot as a replacement)
- shell stuff (.zshrc, .profile, etc.)

the goal is minimal mouse usage, maximum productivity

## setup

```bash
git clone --recurse-submodules https://github.com/leo-alvarenga/dotfiles.git ~/.config
```

or if you already cloned without submodules:

```bash
git submodule update --init --recursive
```

## notes

each submodule (nvim, tmux, opencode) is its own repo and can be worked on independently. changes to submodules need to be committed in both the submodule and this parent repo.

## license

MIT - use however you want
