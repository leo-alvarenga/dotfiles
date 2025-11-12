return {
	-- Custom Dashboard (aka Start page or Greeter)
	"nvimdev/dashboard-nvim",
	config = require("config.dashboard").config,
	dependencies = { { "nvim-tree/nvim-web-devicons" } },
	event = "VimEnter",
	version = false,
}
