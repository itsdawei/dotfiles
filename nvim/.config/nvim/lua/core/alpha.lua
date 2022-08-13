local M = {}

local function configure_additional_autocmds()
  local group = "_dashboard_settings"
  vim.api.nvim_create_augroup(group, {})
  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = "alpha",
    command = "set showtabline=0 | autocmd BufLeave <buffer> set showtabline=" .. vim.opt.showtabline._value,
  })
  -- https://github.com/goolord/alpha-nvim/issues/42
  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = "alpha",
    command = "set laststatus=0 | autocmd BufUnload <buffer> set laststatus=" .. vim.opt.laststatus._value,
  })
end

function M.setup()
  require("alpha").setup(require("alpha.themes.dashboard").config)
  configure_additional_autocmds()
end

return M
