return {
	--------------------------------------------------------------
	-- Basic UI elements

	-- Bufferline - Currently open/pending buffers
	{
		"romgrk/barbar.nvim",
		opts = {},
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
	},

	-- Custom Dashboard (aka Start page or Greeter)
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		config = require("config.dashboard").config,
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
	},

	-- Simple status line
	{
		"nvim-mini/mini.statusline",
		version = "*",
		opts = {},
	},

	-- Icons
	{
		"nvim-tree/nvim-web-devicons",
		opts = {},
	},

	-- Notifications and feedback
	{
		"nvim-mini/mini.notify",
		branch = false,
		opts = {},
	},

	--------------------------------------------------------------
	-- Pickers and overlays

	-- Better looking vim.ui_select replacement
	{
		"nvim-mini/mini.pick",
		lazy = true,
		opts = {},
		version = false,
	},

	{
		"stevearc/oil.nvim",
		opts = {},
		dependencies = {
			{
				"nvim-tree/nvim-web-devicons",
			},
		},
		lazy = false,
	},

	-- Display recently pressed keys
	{
		"nvzone/showkeys",
		cmd = "ShowkeysToggle",
		opts = {
			maxkeys = 5,
		},
	},

	-- A whole bunch of file pickers
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
	},

	-- Helper overlay with Keymap hints
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},

	-- Manage Dirs as workspaces
	{
		"natecraddock/workspaces.nvim",
		opts = {
			hooks = {
				open = { require("config.workspaces").on_open },
			},
		},
	},

	--------------------------------------------------------------
	-- Readability enhancements

	-- Highlight all occurrences of the word/symbol under the cursor
	{
		"nvim-mini/mini.cursorword",
		opts = {},
		version = false,
	},

	-- Highlight color values (e.g.: HEX, HSL, RGB) with the actual color value
	{
		"norcalli/nvim-colorizer.lua",
		opts = {},
		version = "main",
	},

	-- Highlight specific comments to callout for attention
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},

	-- Improve comment syntax rules
	{
		"folke/ts-comments.nvim",
		event = "VeryLazy",
		opts = {},
	},

	-- Toggleable block highlights for enhanced readability
	{
		"folke/twilight.nvim",
		opts = {},
	},

	--------------------------------------------------------------
	-- Movement improvements

	-- Comment whole blocks at once
	{
		"nvim-mini/mini.comment",
		opts = {},
		version = false,
	},

	-- Move whole blocks at once
	{
		"nvim-mini/mini.move",
		opts = {
			-- This one also has very sane default values
		},
		version = false,
	},

	-- Auto close pairs
	{
		"nvim-mini/mini.pairs",
		opts = {
			-- The default values are actually fine
		},
		version = false,
	},

	-- Wrap whole blocks with pairs
	{
		"nvim-mini/mini.surround",
		opts = {
			-- The default values are very sane on this one
		},
		version = false,
	},
}
