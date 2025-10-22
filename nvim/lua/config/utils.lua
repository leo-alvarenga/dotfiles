-- Utils

function table_join(tables)
  local result = {}

  for _, t in ipairs(tables) do
    for i = 1, #t do
      result[#result + 1] = t[i]
    end
  end

  return result
end

return { table_join = table_join }

