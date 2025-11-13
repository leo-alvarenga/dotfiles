local _shared = require("config.utils.constants.shared")

local M = {}

function M.close_current()
	local buf_count = #vim.fn.getbufinfo({ buflisted = 1 })

	if buf_count > 1 then
		vim.cmd("bnext | bd #")

		return
	end

	vim.cmd("bd | " .. _shared.dashboard.cmd)
end

return M
