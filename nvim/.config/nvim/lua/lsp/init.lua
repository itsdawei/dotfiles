local M = {}

local servers = {
	clangd = {
		cmd = {
			"clangd",
			"--offset-encoding=utf-16", -- https://github.com/jose-elias-alvarez/null-ls.nvim/issues/428
			"--background-index",
			"--clang-tidy",
			"--header-insertion=iwyu",
		},
	},
}

local diagnostics = {
	signs = {
		active = true,
		values = {
			{ name = "DiagnosticSignError", text = "" },
			{ name = "DiagnosticSignWarn", text = "" },
			{ name = "DiagnosticSignHint", text = "" },
			{ name = "DiagnosticSignInfo", text = "" },
		},
	},
	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
		format = function(d)
			local t = vim.deepcopy(d)
			local code = d.code or (d.user_data and d.user_data.lsp.code)
			if code then
				t.message = string.format("%s [%s]", t.message, code):gsub("1. ", "")
			end
			return t.message
		end,
	},
}

M.setup = function()
	local common = require("lsp.common")
	local lsp_status_ok, _ = pcall(require, "lspconfig")
	if not lsp_status_ok then
		return
	end

	for _, sign in ipairs(diagnostics.signs.values) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
	end

	vim.diagnostic.config({
		virtual_text = true,
		signs = diagnostics.signs,
		underline = true,
		update_in_insert = false,
		severity_sort = true,
		float = diagnostics.float,
	})
	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, common.config.float)
	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, common.config.float)

	require("mason").setup({
		ui = {
			icons = {
				package_installed = "✓",
				package_pending = "➜",
				package_uninstalled = "✗",
			},
		},
	})
	require("mason-lspconfig").setup({
		ensure_installed = { "lua_ls", "pylsp" },
		automatic_installation = true,
	})

	require("lsp.lua_ls").setup()
	require("lsp.pylsp").setup()
	require("lsp.texlab").setup()
	-- require("lspconfig")["jsonls"].setup()

	-- require("lsp.hydra_lsp").setup()

	-- Check if there exists a provider for it
	for server, config in pairs(servers) do
		common.server_setup(server, config)
	end
	require("lspconfig")["clangd"].setup({
		capabilities = require("cmp_nvim_lsp").default_capabilities(),
	})

	require("lsp.null-ls").setup()
end

return M
