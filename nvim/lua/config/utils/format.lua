local M = {}

function M.format_current()
	require("conform").format()
end

return M
