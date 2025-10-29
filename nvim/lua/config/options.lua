-- Leader options

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"


-- Control variables

local tabwidth = 4

local tabchar = "» "
local trailingspacechar = "·"
local nbspchar = "␣"

-- Options

vim.opt.termguicolors = true

vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.shiftwidth = tabwidth -- Amount to indent with << and >>
vim.opt.tabstop = tabwidth -- How many spaces are shown per Tab
vim.opt.softtabstop = tabwidth -- How many spaces are applied when pressing Tab

vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.autoindent = true -- Keep identation from previous line

-- Enable break indent
vim.opt.breakindent = true

-- Always show relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Show line under cursor
vim.opt.cursorline = true

-- Store undos between sessions
vim.opt.undofile = true

-- Enable mouse mode; useful for resizing splits
vim.opt.mouse = "a"

-- Don't show the mode
vim.opt.showmode = false

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = tabchar, trail = trailingspacechar, nbsp = nbspchar }

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 5
