local _lazy = require("config.utils.lazy")
local _quote = require("config.utils.quote")
local _table = require("config.utils.table")

local M = {}

M.theme = "doom"

M.icon = {
	" ",
	"⣴⣾⣿⣿⣿⣿⣷⣦",
	"⣿⣿⣿⣿⣿⣿⣿⣿",
	"⡟⠛⠽⣿⣿⠯⠛⢻",
	"⣧⣀⣀⡾⢷⣀⣀⣼",
	" ⡏⢽⢴⡦⡯⢹",
	" ⠙⢮⣙⣋⡵⠋",
	"⠉⠉", -- Yes, this line has to stay crooked
}

M.banner = {
	" ",
	"███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
	"████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
	"██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
	"██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
	"██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
	"╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
	" ",
}

M.quote = _quote.get_random()

M.header = _table.table_join({
	M.icon,
	M.banner,
	M.quote,
	{
		" ",
		" ",
		" ",
	},
})

M.footer = {
	_lazy.get_pkg_count() .. " packages installer with Lazy.nvim",
}

return M
