local M = {
	-- Custom Dashboard (aka Start page or Greeter)
	"nvimdev/dashboard-nvim",
	dependencies = { { "nvim-tree/nvim-web-devicons" } },
	event = "VimEnter",
	version = false,
}

function M.config()
	local values = require("config.utils.constants.dashboard")

	require("dashboard").setup({

		theme = values.theme,
		disable_move = true,

		config = {
			header = values.header,
			center = values.actions.option_list,

			footer = values.footer,

			vertical_center = true,
		},

		hide = {
			statusline = true,
			tabline = true,
			winbar = true,
		},
	})
end

return M
