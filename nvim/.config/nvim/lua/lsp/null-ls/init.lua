local M = {}

function M.setup()
	local status_ok, null_ls = pcall(require, "null-ls")
	if not status_ok then
		return
	end

	local sources = {
    -- Prettier
    null_ls.builtins.formatting.prettier,

		-- CMake
		null_ls.builtins.formatting.cmake_format,

		-- SQL
		-- null_ls.builtins.formatting.sqlformat,

		-- Lua
		null_ls.builtins.formatting.stylua,

		-- Latex
    -- null_ls.builtins.diagnostics.chktex,
    -- null_ls.builtins.formatting.latexindent,

		-- Markdown
		null_ls.builtins.diagnostics.markdownlint.with({
			filetypes = { "markdown" },
			extra_args = { "-r", "~MD013" },
		}),
		-- null_ls.builtins.diagnostics.vale.with({
		-- 	filetypes = { "markdown" },
		-- }),

		-- Python
		-- null_ls.builtins.diagnostics.pylint,
		null_ls.builtins.formatting.yapf,
		null_ls.builtins.formatting.isort,

    -- Refactoring
		null_ls.builtins.code_actions.refactoring.with({
			filetypes = { "typescript", "javascript", "lua", "c", "cpp", "go", "python", "java", "php" },
		})
	}

	null_ls.setup({
		on_attach = require("lsp").on_attach,
		debounce = 150,
		save_after_format = false,
		sources = sources,
    debug=true,
	})
end

return M
