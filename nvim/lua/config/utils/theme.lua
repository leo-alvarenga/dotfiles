local M = {}

---Set current colorscheme
---@param theme string
function M.set(theme)
	vim.cmd("colorscheme " .. theme)
end

return M
