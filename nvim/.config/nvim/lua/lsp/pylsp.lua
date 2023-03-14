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
				"Pipfile",
				"manage.py",
				"pyrightconfig.json",
			}
			return util.root_pattern(unpack(root_files))(fname)
				or util.root_pattern(".git")(fname)
				or util.path.dirname(fname)
		end,
		settings = {
			pylsp = {
				plugins = {
					jedi_completion = { enabled = true },
					jedi_hover = { enabled = true },
					jedi_references = { enabled = true },
					jedi_signature_help = { enabled = true },
					jedi_symbols = { enabled = true, all_scopes = true },
					pycodestyle = { enabled = false },
					pyflakes = { enabled = false },
					-- pylint = {
					--   enabled = true,
					--   executable = "pylint",
					-- },
					-- isort = {enabled = true},
					-- yapf = {enabled = true},
				},
			},
		},
		single_file_support = true,
	}

	require("lspconfig")["pylsp"].setup(opts)
end

return M
