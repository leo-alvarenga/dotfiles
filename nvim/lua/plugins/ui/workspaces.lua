return {
	-- Manage Dirs as workspaces
	"natecraddock/workspaces.nvim",
	opts = {
		hooks = {
			open = { require("config.utils.workspaces").on_open },
		},
	},
	version = false,
}
