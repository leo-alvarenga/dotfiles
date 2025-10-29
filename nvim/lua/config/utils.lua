-- Utils

local function table_join(tables)
	local result = {}

	for _, t in ipairs(tables) do
		for i = 1, #t do
			result[#result + 1] = t[i]
		end
	end

	return result
end

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

local function set_theme(theme)
	vim.cmd("colorscheme " .. theme)
end

local function get_pkg_count()
	return #require("lazy").plugins() or 0
end

local function get_random_quote()
	local inspire = require("inspire")
	local quote = inspire.get_quote()

	return quote.text
end

return {
	get_pkg_count = get_pkg_count,
	get_random_quote = get_random_quote,
	map = map,
	set_theme = set_theme,
	table_join = table_join,
	to_options = to_options,
}
