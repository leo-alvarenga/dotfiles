local utils = require("config.utils")

local function config()
	local icon = {
		" ",
		"⣴⣾⣿⣿⣿⣿⣷⣦",
		"⣿⣿⣿⣿⣿⣿⣿⣿",
		"⡟⠛⠽⣿⣿⠯⠛⢻",
		"⣧⣀⣀⡾⢷⣀⣀⣼",
		" ⡏⢽⢴⡦⡯⢹",
		" ⠙⢮⣙⣋⡵⠋",
		"⠉⠉", -- Yes, this line has to stay crooked
	}

	local banner = {
		" ",
		"███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
		"████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
		"██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
		"██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
		"██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
		"╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
		" ",
	}

	local quote = utils.get_random_quote()

	local header = utils.table_join({
		icon,
		banner,
		quote,
		{
			" ",
			" ",
			" ",
		},
	})

	require("dashboard").setup({
		theme = "doom",
		disable_move = true,

		config = {
			header = header,
			center = {
				{
					icon = " ",
					icon_hl = "group",
					desc = "Open a previously open workspace",
					key = "w",
					key_hl = "group",
					key_format = "SPC %s",
					action = ":" .. utils.constants.telescope.workspaces,
				},
				{
					icon = " ",
					icon_hl = "group",
					desc = "Explore current directory",
					key = "e",
					key_hl = "group",
					key_format = "SPC %s",
					action = ":" .. utils.constants.oil_cmd,
				},
				{
					icon = " ",
					icon_hl = "group",
					desc = "Open file from current directory",
					key = "f",
					key_hl = "group",
					key_format = "SPC %s",
					action = ":" .. utils.constants.telescope.find_files_cmd,
				},
			},

			footer = {
				utils.get_pkg_count() .. " packages installer with Lazy.nvim",
			},

			vertical_center = true,
		},

		hide = {
			statusline = true,
			tabline = true,
			winbar = true,
		},
	})
end

return {
	config = config,
}
