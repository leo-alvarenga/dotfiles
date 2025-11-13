local _shared = require("config.utils.constants.shared")

local M = {
	-- Custom Dashboard (aka Start page or Greeter)
	"nvimdev/dashboard-nvim",
	dependencies = { { "nvim-tree/nvim-web-devicons" } },
	event = "VimEnter",
	version = false,
}

---Normalize as an actual prompt command
---@param cmd string
local function to_action(cmd)
	if not cmd or type(cmd) ~= "string" then
		return ""
	end

	return "<cmd>" .. cmd
end

function M.config()
	local values = require("config.utils.constants.dashboard")

	require("dashboard").setup({

		theme = values.theme,
		disable_move = true,

		config = {
			header = values.header,
			center = {
				{
					icon = " ",
					icon_hl = "group",
					desc = "Select a previously open session",
					key = "w",
					key_hl = "group",
					key_format = "SPC %s",
					action = to_action("cwd"),
				},
				{
					icon = " ",
					icon_hl = "group",
					desc = "Explore current directory",
					key = "e",
					key_hl = "group",
					key_format = "SPC %s",
					action = to_action(_shared.oil.cmd),
				},
				{
					icon = " ",
					icon_hl = "group",
					desc = "Open file from current directory",
					key = "f",
					key_hl = "group",
					key_format = "SPC %s",
					action = to_action(_shared.telescope.find_files.cmd),
				},
			},

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
