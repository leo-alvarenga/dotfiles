-----------------
-- Telescope
-----------------

local telescope = require('telescope')

local telescope_theme = 'dropdown'

telescope.setup({
	fd = {
		theme = telescope_theme
	},
	live_grep = {
		theme = telescope_theme
	},
	buffers = {
		theme = telescope_theme
	},
	help_tags = {
		theme = telescope_theme
	}
})

local function set_telescope_mappings()
	local builtin = require('telescope.builtin')

	vim.keymap.set(
		'n',
		'<leader>f',
		builtin.fd,
		{
			desc = 'Telescope - Find files'
		}
	)

	vim.keymap.set(
		'n',
		'<leader>g',
		builtin.git_files,
		{
			desc = 'Telescope - Git files'
		}
	)

	vim.keymap.set(
		'n',
		'<leader>F',
		builtin.live_grep,
		{
			desc = 'Telescope - Live grep'
		}
	)

	vim.keymap.set(
		'n',
		'<leader>c',
		builtin.buffers,
		{
			desc = 'Telescope - Buffers'
		}
	)

	vim.keymap.set(
		'n',
		'<leader>C',
		builtin.help_tags,
		{
			desc = 'Telescope - help tags'
		}
	)
end

set_telescope_mappings()

