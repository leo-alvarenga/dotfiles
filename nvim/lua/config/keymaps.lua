local utils = require("config.utils")
local map = utils.map
local keymaps = {}
-------------------------------------------------

-------------------------------------------------
-- Basics and Helix related keymappings
function keymaps.setup_basics()
	---------------------
	--  Undo/Redo
	map("", "u", ":undo<CR>", "Undo")
	map("", "U", ":redo<CR>", "Redo")
	---------------------

	---------------------
	--  Buffer management
	map("", "<leader>h", ":bprevious<cr>", "Go to previous Buffer")
	map("", "<leader>l", ":bnext<cr>", "Go to next Buffer")

	-- Open new buffer
	map("", "<leader>n", ":enew<CR>", "Open new empty Buffer")

	-- Close current buffer
	map("", "<leader>x", utils.close_current_buffer, "Close current Buffer (go to Dashboard if it's the last one)")
	---------------------

	---------------------
	-- Motions inspired by Helix :D
	-- Ensuring selection is kept after indentation
	map("x", "<", "<gv")
	map("x", ">", ">gv")

	-- Going to start of the line with 'gh'
	map("", "gh", "0")

	-- Going to end of the line with 'gl'
	map("", "gl", "$")

	-- Going to end of the file with 'ge'
	map("", "ge", "G")
	---------------------

	---------------------
	-- Helix-like selection
	-- Whole line selection (downwards) with 'x'
	map("n", "x", "0v$j")
	map("x", "x", "0$j")

	-- Whole line selection (upwards) with 'x'
	map("n", "X", "0v$k")
	map("x", "X", "0$k")
	---------------------
end
-------------------------------------------------

-------------------------------------------------
-- Formatting and Diagnostics
function keymaps.setup_fmt()
	map({ "", "i" }, "<C-s>", utils.format_file, "Format file (if possible)")
end
-------------------------------------------------

-------------------------------------------------
-- Oil keymaps
function keymaps.setup_oil()
	map("", "<leader>e", ":Oil<CR>", "Explore current directory using Oil")
end
-------------------------------------------------

-------------------------------------------------
-- Twilight keymaps
function keymaps.setup_twilight()
	map("", "<C-e>", ":Twilight<CR>", "Toggle Twilight dim")
end
-------------------------------------------------

-------------------------------------------------
-- Twilight keymaps
function keymaps.setup_workspaces()
	map("", "", "", "")
end
-------------------------------------------------

-----------------
-- Telescope
-----------------
function keymaps.setup_telescope()
	local telescope = require("telescope")
	local workspaces = require("config.workspaces")

	local telescope_theme = "dropdown"

	telescope.setup({
		fd = {
			theme = telescope_theme,
		},
		live_grep = {
			theme = telescope_theme,
		},
		buffers = {
			theme = telescope_theme,
		},
		workspaces = {
			theme = telescope_theme,
		},
		help_tags = {
			theme = telescope_theme,
		},
	})

	local builtin = require("telescope.builtin")

	map("n", "<leader>f", function()
		builtin.fd({ hidden = true })
	end, "Telescope - Find files")

	map("", "<leader>g", builtin.git_files, "Telescope - Git files")

	map("", "<leader>F", function()
		builtin.live_grep({ hidden = true })
	end, "Telescope - Live grep")

	map("", "<leader>c", builtin.buffers, "Telescope - Buffers")

	map("", "<leader>C", builtin.help_tags, "Telescope - help tags")
	map("", "<leader>w", ":" .. utils.constants.telescope.workspaces .. "<CR>", "Telescope - Workspaces")

	map("", "<leader>W", workspaces.manage_workspaces, "Telescope - Manage workspaces")

	telescope.load_extension("workspaces")
end
-------------------------------------------------

-------------------------------------------------
-- Main setup
function keymaps.setup_keymaps()
	keymaps.setup_basics()
	keymaps.setup_fmt()
	keymaps.setup_oil()
	keymaps.setup_twilight()
end
-------------------------------------------------

return keymaps
