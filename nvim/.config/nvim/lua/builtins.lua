local M = {}

local builtins = {
  "core.which-key",
}

function M.setup()
  for _, builtin_path in ipairs(builtins) do
    local builtin = require(builtin_path)
    builtin.config()
  end
end

return M
