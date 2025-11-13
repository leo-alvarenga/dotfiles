local M = {}

---Given an array of array-like tables, concat them into a single array-like table
---@param tables table
---@return table
function M.merge_arrays(tables)
	local result = {}

	for _, t in ipairs(tables) do
		for i = 1, #t do
			result[#result + 1] = t[i]
		end
	end

	return result
end

---Given an array of object-like (aka dictionaries) tables, merge them all, overwritting duplicates keys with its last occurrence's value
---@param tables table
---@return table
function M.merge(tables)
	local result = {}

	for _, t in ipairs(tables) do
		for k, v in pairs(t) do
			result[k] = v
		end
	end

	return result
end

return M
