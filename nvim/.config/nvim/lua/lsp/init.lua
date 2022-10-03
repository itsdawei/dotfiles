local M = {}

local servers = {
  tsserver = true,
  html = true,
  cssls = true,
  yamlls = true,

  clangd = {
    cmd = {
      "clangd",
      "--background-index",
      "--suggest-missing-includes",
      "--clang-tidy",
      "--header-insertion=iwyu",
    },
  },
}


M.setup = function()
  local common = require("lsp.common")
  local lsp_status_ok, _ = pcall(require, "lspconfig")
  if not lsp_status_ok then
    return
  end

  for _, sign in ipairs(common.config.diagnostics.signs.values) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
  end

  vim.diagnostic.config({
    virtual_text = true,
    signs = common.config.diagnostics.signs,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = common.config.diagnostics.float,
  })
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, common.config.float)
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, common.config.float)

  require("nvim-lsp-installer").setup({
    ensure_installed = {},
    ui = {
      icons = {
        server_installed = "✓",
        server_pending = "",
        server_uninstalled = "✗",
      },
    }
  })

  require("lsp.sumneko_lua").setup()
  require("lsp.pylsp").setup()
  require("lsp.texlab").setup()

  -- Check if there exists a provider for it
  for server, config in pairs(servers) do
    common.server_setup(server, config)
  end

  require("lsp.null-ls").setup()
end

return M
