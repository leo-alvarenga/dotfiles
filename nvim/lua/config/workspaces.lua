local utils = require("config.utils")

local workspaces = {}

function workspaces.manage_workspaces()
	local mini_pick = require("mini.pick")

	local opts = {
		"Add to workspaces",
		"Remove from workspaces",
		"Add all sub-directories to workspaces",
		"Remove all sub-directories from workspaces",
		"Sync",
	}

	local actions = {
		[opts[1]] = "WorkspacesAdd",
		[opts[2]] = "WorkspacesRemove",
		[opts[3]] = "WorkspacesAddDir",
		[opts[4]] = "WorkspacesRemoveDir",
		[opts[5]] = "WorkspacesSync",
	}

	mini_pick.ui_select(opts, { prompt = "Manage Workspaces" }, function(choice)
		if actions[choice] ~= nil then
			vim.cmd(actions[choice])
		end
	end)
end

function workspaces.on_open(_, path)
	vim.cmd("cd " .. path .. " | " .. utils.constants.telescope.find_files_cmd)
end

return workspaces
