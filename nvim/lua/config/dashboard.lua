local utils = require("config.utils")

local function config()
	require("dashboard").setup({
		theme = "doom",
		disable_move = true,

		config = {
			header = {
				" ",
				"⣴⣾⣿⣿⣿⣿⣷⣦",
				"⣿⣿⣿⣿⣿⣿⣿⣿",
				"⡟⠛⠽⣿⣿⠯⠛⢻",
				"⣧⣀⣀⡾⢷⣀⣀⣼",
				" ⡏⢽⢴⡦⡯⢹",
				" ⠙⢮⣙⣋⡵⠋",
				"⠉⠉", -- Yes, this line has to stay crooked
				" ",
				"  ███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓ ",
				"  ██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒ ",
				" ▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░ ",
				" ▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██  ",
				" ▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒ ",
				" ░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░ ",
				" ░ ░░   ░ ▒░ ░ ░  ░  ░ ▒ ▒░    ░ ░░   ▒ ░░  ░      ░ ",
				"    ░   ░ ░    ░   ░ ░ ░ ▒       ░░   ▒ ░░      ░    ",
				"          ░    ░  ░    ░ ░        ░   ░         ░    ",
				"                                 ░                   ",
				" ",
				utils.get_random_quote(),
				" ",
			},

			center = {
				{
					icon = " ",
					icon_hl = "group",
					desc = "Explore current directory",
					key = "e",
					key_hl = "group",
					key_format = "SPC %s",
					action = ":Oil",
				},
				{
					icon = " ",
					icon_hl = "group",
					desc = "Open file from current directory",
					key = "f",
					key_hl = "group",
					key_format = "SPC %s",
					action = ":Oil",
				},
				{
					icon = " ",
					icon_hl = "group",
					desc = "Search in the current directory",
					key = "F",
					key_hl = "group",
					key_format = "SPC %s",
					action = ":Oil",
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
