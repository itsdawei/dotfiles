M = {}

function M.setup()
  local opts = {
    on_attach = require("lsp.common").on_attach,
    capabilities = require("lsp.common").capabilities(),
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim", "packer_plugins" },
        },
        workspace = { library = vim.api.nvim_get_runtime_file("", true),
          maxPreload = 100000,
          preloadFileSize = 10000,
        },
      },
    },
  }

  require("lspconfig")["sumneko_lua"].setup(opts)
end

return M

