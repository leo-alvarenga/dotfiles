return {
	"natecraddock/workspaces.nvim",
	opts = {
		hooks = {
			open = { require("config.workspaces").on_open },
		},
	},
}
