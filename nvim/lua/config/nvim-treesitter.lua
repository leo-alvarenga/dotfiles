local must_have_langs = {
	-- Basics
	"c",
	"lua",
	"vim",
	"vimdoc",
	"query",
	"csv",
	"json",
	"json5",

	-- Scripting
	"bash",

	-- Configs
	"hyprlang",
	"ini",
	"rasi",

	-- Git
	"git_config",
	"git_rebase",
	"gitattributes",
	"gitignore",

	-- Languages
	"go",
	"gomod",
	"gosum",

	-- Web
	"javascript",
	"jsdoc",
	"typescript",
	"typespec",
	"html",
	"css",
	"scss",
	"sql",
	"svelte",
	"tsx",

	-- Infra/DevOps
	"nginx",
	"terraform",
	"toml",
	"yaml",

	"markdown",
	"markdown_inline",
}

local function config()
	local configs = require("nvim-treesitter.configs")

	configs.setup({
		ensure_installed = must_have_langs,

		sync_install = false,

		auto_install = true,

		ignore_install = {},

		highlight = {
			enable = true,
		},

		indent = {
			enabled = true,
		},

		incremental_selection = {
			enable = true,

			keymaps = {
				-- To disable any of the following keymaps, use false; Otherwise, use a valid Key values
				init_selection = "<Enter>", -- In Visual mode, how to enter incremental selection
				node_incremental = "<Enter>",
				scope_incremental = false,
				node_decremental = "<Backspace>",
			},
		},
	})
end

return {
	config = config,
}
