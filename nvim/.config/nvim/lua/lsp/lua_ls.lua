local M = {}

function M.setup()
	local opts = {
		on_attach = require("lsp.common").on_attach,
		capabilities = require("lsp.common").capabilities(),
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim"},
				},
				workspace = {
					library = vim.api.nvim_get_runtime_file("", true),
					maxPreload = 100000,
					preloadFileSize = 10000,
          checkThirdParty = false,
				},
			},
		},
	}

	require("lspconfig")["lua_ls"].setup(opts)
end

return M
