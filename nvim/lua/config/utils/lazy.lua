local M = {}

function M.get_pkg_count()
	return #require("lazy").plugins() or 0
end

return M
