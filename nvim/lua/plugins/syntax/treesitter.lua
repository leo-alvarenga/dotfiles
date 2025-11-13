local _langs = require("config.utils.constants.languages")

local M = {
	"nvim-treesitter/nvim-treesitter",
	branch = "master",
	lazy = false,
	build = ":TSUpdate",
}

function M.config()
	local configs = require("nvim-treesitter.configs")

	configs.setup({
		ensure_installed = _langs.languages,
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

return M
