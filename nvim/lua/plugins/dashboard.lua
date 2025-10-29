return {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	config = require("config.dashboard").config,
	dependencies = { { "nvim-tree/nvim-web-devicons" } },
}
