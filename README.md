# dotfiles

My config files for a keyboard-focused, terminal-based dev workflow

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

Then, install the dependencies for each submodule (nvim, tmux, opencode) and set up your shell environment as needed. Some of the depencies are listed below, but check each submodule's README for more details.

- `bat`
- `fzf`
- `zsh`
- `starship`
- OpenCode 1.15 or higher
- Tmux 3.2 or higher
- Neovim 0.12 or higher
- `tree-sitter` CLI tool for syntax highlighting and code parsing
- `ripgrep` for file searching and live grep functionality
- `fd` for fast file searching in the file explorer
- `node` and `npm` for managing plugins that require Node.js
- `python3` and `pip` for Python-based plugins and language servers
- `lua` and `lua-rocks` for Lua-based plugins and configurations
- `cargo` for Rust-based plugins and language servers
- `yazi` for file exploration and management (required for the `yazi.nvim` plugin)

## notes

Each submodule (nvim, tmux, opencode) is its own repo and can be worked on independently. changes to submodules need to be committed in both the submodule and this parent repo.

## license

MIT - use however you want
