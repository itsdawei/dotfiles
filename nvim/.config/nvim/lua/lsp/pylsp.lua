local M = {}

function M.setup()
	local opts = {
		on_attach = require("lsp.common").on_attach,
		capabilities = require("lsp.common").capabilities(),
		root_dir = function(fname)
			local util = require("lspconfig.util")
			local root_files = {
				"pyproject.toml",
				"setup.py",
				"setup.cfg",
				"requirements.txt",
			}
			return util.root_pattern(unpack(root_files))(fname)
				or util.root_pattern(".git")(fname)
				or util.path.dirname(fname)
		end,
		settings = {
			pylsp = {
				-- https://github.com/python-lsp/python-lsp-server/blob/develop/CONFIGURATION.md
				-- configurationSources = {},
				plugins = {
					-- formatter options
					-- black = { enable = true },
					yapf = { enabled = true },
					autopep8 = { enabled = false },
					-- linter options
					pylint = { enabled = true, executable = "pylint" },
					pyflakes = { enabled = false },
					pycodestyle = { enabled = false },
					mccabe = { enabled = false },
					-- auto-completion options
					jedi_completion = { fuzzy = true },
					-- import sorting
					pyls_isort = { enabled = true },
				},
			},
		},
		single_file_support = true,
	}

	require("lspconfig")["pylsp"].setup(opts)
end

return M
