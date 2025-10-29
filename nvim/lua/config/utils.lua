-- Utils

local utils = {}

utils.constants = {
	dashboard_cmd = "Dashboard",
	oil_cmd = "Oil",
	telescope = {
		find_files_cmd = "Telescope find_files",
		live_grep_cmd = "Telescope live_grep",
	},
}

function utils.table_join(tables)
	local result = {}

	for _, t in ipairs(tables) do
		for i = 1, #t do
			result[#result + 1] = t[i]
		end
	end

	return result
end

--- From a nil or string value, get a valid options object to use when mapping
function utils.to_options(desc)
	local options = { noremap = true, silent = true }

	if desc then
		options.desc = desc
	end

	return options
end

--- Wrapper for setting keymaps via the vim.keymap api
function utils.map(mode, key, command, desc)
	vim.keymap.set(mode, key, command, utils.to_options(desc))
end

function utils.set_theme(theme)
	vim.cmd("colorscheme " .. theme)
end

function utils.get_pkg_count()
	return #require("lazy").plugins() or 0
end

function utils.format_file()
	require("conform").format()
end

function utils.get_random_quote()
	local quotes = require("config.quotes")

	return quotes.get_random()
end

function utils.close_current_buffer()
	local buf_count = #vim.fn.getbufinfo({ buflisted = 1 })

	if buf_count > 1 then
		vim.cmd("bnext | bd #")

		return
	end

	vim.cmd("bd | " .. utils.constants.dashboard_cmd)
end

return utils
