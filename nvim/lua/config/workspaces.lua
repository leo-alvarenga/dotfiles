local utils = require("config.utils")

local workspaces = {}

function workspaces.manage_workspaces()
	local opts = {
		"Add current directory as workspace",
		"Remove current directory from workspaces",
	}

	vim.ui.select(opts, { prompt = "Manage Workspaces" }, function(choice)
		if choice == opts[1] then
			vim.cmd("WorkspacesAdd")

			return
		end

		vim.cmd("WorkspacesRemove")
	end)
end

function workspaces.on_open(_, path)
	vim.cmd("cd " .. path .. ' | ' .. utils.constants.telescope.find_files_cmd)
end

return workspaces
