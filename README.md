# dotfiles

My config files for a keyboard-focused, terminal-based dev workflow

## what's here

- **foot/** - foot terminal config
- **tmux/** - tmux config (submodule)
- **nvim/** - neovim config (submodule)
- **opencode/** - opencode config (submodule)
- **nixos/** - NixOS config
- **home/** - Home-manager flake for non-NixOS systems
- **nix/** - nix config options for non-NixOS systems
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

> **Tip:** If you are using **NixOS**, you can use the `nixos/flake.nix` file to set up your system with all the required dependencies.
> And if you are using **Home Manager** on a **non-NixOS** system, you can use the `home/flake.nix` file to set up your user environment with _most_ of the required dependencies (check the `nixos/configuration.nix` file to see other requirements, such as fonts and other util).

- A nerd font installed (I use JetBrains Mono Nerd Font)
- `Recursive Mono Casual` or the font of your choice installed and set in your terminal emulator (remember to set the font in your terminal emulator settings)
- `bat`
- `fzf`
- `zsh`
- `lsd`
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
