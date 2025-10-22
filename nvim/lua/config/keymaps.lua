--- From a nil or string value, get a valid options object to use when mapping
local function to_options(desc)
	local options = { noremap = true, silent = true }

	if desc then
		options.desc = desc
	end

	return options
end

--- Wrapper for setting keymaps via the vim.keymap api
local function map(mode, key, command, desc)
	vim.keymap.set(mode, key, command, to_options(desc))
end

-- Remappings

-- Open new buffer
map("n", "<C-n>", ":enew<CR>", "Open new empty Buffer")

-- Ensuring selection is kept after indentation

map("x", "<", "<gv")
map("x", ">", ">gv")

-------------------------------------------------
-- Twilight keymaps
-------------------------------------------------

map("n", "<leader>l", ":Twilight<CR>", "Toggle Twilight dim")

-------------------------------------------------
-- Formatting and Diagnostics
-------------------------------------------------

map("n", "<C-s>", function()
	require("conform").format()
end, "Format file (if possible)")

-------------------------------------------------
-- Helix related keymappings
-------------------------------------------------

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
