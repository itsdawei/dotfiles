M = {}

function M.setup()
	local status_ok, null_ls = pcall(require, "null-ls")
	if not status_ok then
		return
	end

	local sources = {
    -- CMake
		-- null_ls.builtins.formatting.cmake_format,

    -- SQL
		-- null_ls.builtins.formatting.sqlformat,

    -- Lua
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.diagnostics.luacheck,

    -- Latex
		null_ls.builtins.diagnostics.chktex,

    -- Markdown
		-- null_ls.builtins.diagnostics.markdownlint.with({
		-- 	filetypes = { "markdown" },
		-- }),
		-- null_ls.builtins.diagnostics.vale.with({
		-- 	filetypes = { "markdown" },
		-- }),

		-- Python
    null_ls.builtins.diagnostics.pylint,
		null_ls.builtins.formatting.yapf,
		null_ls.builtins.formatting.isort,

		-- Shell
		null_ls.builtins.formatting.shfmt.with({ extra_args = { "-i", "2", "-ci" } }),
		null_ls.builtins.diagnostics.shellcheck,
		null_ls.builtins.code_actions.shellcheck,

    -- Eslint_d
		null_ls.builtins.formatting.eslint_d.with({
			prefer_local = "node_modules/.bin",
		}),
		null_ls.builtins.diagnostics.eslint_d.with({
			prefer_local = "node_modules/.bin",
		}),
		null_ls.builtins.code_actions.eslint_d.with({
			prefer_local = "node_modules/.bin",
		}),
		-- TODO: try these later on
		-- null_ls.builtins.formatting.google_java_format,
		-- null_ls.builtins.code_actions.proselint,
		-- null_ls.builtins.diagnostics.proselint,
	}
	table.insert(
		sources,
		null_ls.builtins.code_actions.refactoring.with({
			filetypes = { "typescript", "javascript", "lua", "c", "cpp", "go", "python", "java", "php" },
		})
	)

	null_ls.setup({
		on_attach = require("lsp").on_attach,
		debounce = 200,
		save_after_format = false,
		sources = sources,
	})
end

return M
