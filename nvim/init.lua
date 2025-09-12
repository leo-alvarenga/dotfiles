local current_theme = "tokyodark"

require("options")

require("paq") ({
    "savq/paq-nvim", -- Let Paq manage itself

    "neovim/nvim-lspconfig", -- Basic LSP
    "nvim-lua/plenary.nvim", -- Basic Lua Function lib

    -- LSP
    "neovim/nvim-lspconfig",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    --

    -- QoL
    "numToStr/Comment.nvim",
    "windwp/nvim-autopairs",
    "kylechui/nvim-surround",
    "folke/which-key.nvim",
    --
    
    { "lervag/vimtex", opt = true }, -- Use braces when passing options
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' }, -- TreeSitter for syntax highlighting

    -- File tree:
    "nvim-tree/nvim-tree.lua", 
    "nvim-tree/nvim-web-devicons",
    --

    -- Telescope
    { 
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release"
    }, -- Fuzzy-finder

    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x"
    }, -- Telescope itself
    --

    -- Status line
    "nvim-lualine/lualine.nvim",
    --

    -- Theme
    "tiagovla/tokyodark.nvim"
    --
})

require("plugins.nvim-tree")

require("plugins.lualine")
require("plugins.which-key")

require("options.keymap")

vim.cmd("colorscheme " .. current_theme)

