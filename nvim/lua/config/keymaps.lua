local utils = require("config.utils")
local map = utils.map
-------------------------------------------------

-------------------------------------------------
-- Basics and Helix related keymappings
local function setup_basics()
	-- Open new buffer
	map("n", "<C-n>", ":enew<CR>", "Open new empty Buffer")

	-- Ensuring selection is kept after indentation

	map("x", "<", "<gv")
	map("x", ">", ">gv")

	-- Helix does a lot right honestly...
	-- The keymaps bellow reflect that, as I feel they genuinely improve a lot my workflow

	---------------------
	--  Motions inspired by Helix :D

	-- Going to start of the line with 'gh'
	map("n", "gh", "0")
	map("x", "gh", "0")

	-- Going to end of the line with 'gl'
	map("n", "gl", "$")
	map("x", "gl", "$")

	-- Going to end of the file with 'ge'
	map("n", "ge", "G")
	map("x", "ge", "G")

	---------------------
	-- Selections

	-- Whole line selection (downwards) with 'x'
	map("n", "x", "0v$j")
	map("x", "x", "0$j")

	-- Whole line selection (upwards) with 'x'
	map("n", "X", "0v$k")
	map("x", "X", "0$k")
end
-------------------------------------------------

-------------------------------------------------
-- Formatting and Diagnostics
local function setup_fmt()
	map("n", "<C-s>", function()
		require("conform").format()
	end, "Format file (if possible)")
end
-------------------------------------------------

-------------------------------------------------
-- Oil keymaps
local function setup_oil()
	map("n", "<leader>e", ":Oil<CR>", "Explore current directory using Oil")
end
-------------------------------------------------

-------------------------------------------------
-- Twilight keymaps
local function setup_twilight()
	map("n", "<C-e>", ":Twilight<CR>", "Toggle Twilight dim")
end
-------------------------------------------------

-----------------
-- Telescope
-----------------
local function setup_telescope()
	local telescope = require("telescope")

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
		help_tags = {
			theme = telescope_theme,
		},
	})

	local builtin = require("telescope.builtin")

	map("n", "<leader>f", function()
		builtin.fd({ hidden = true })
	end, "Telescope - Find files")

	map("n", "<leader>g", builtin.git_files, "Telescope - Git files")

	map("n", "<leader>F", function()
		builtin.live_grep({ hidden = true })
	end, "Telescope - Live grep")

	map("n", "<leader>c", builtin.buffers, "Telescope - Buffers")

	map("n", "<leader>C", builtin.help_tags, "Telescope - help tags")
end
-------------------------------------------------

-------------------------------------------------
-- Main setup 
local function setup_keymaps()
	setup_basics()
	setup_fmt()
	setup_oil()
	setup_twilight()
end
-------------------------------------------------

return {
	setup_keymaps = setup_keymaps,
	setup_telescope = setup_telescope,
}
