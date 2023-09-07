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
				plugins = {
					jedi_completion = { enabled = false },
					jedi_hover = { enabled = false },
					jedi_references = { enabled = false },
					jedi_signature_help = { enabled = false },
					jedi_symbols = { enabled = false, all_scopes = false },
					pycodestyle = { enabled = false },
					pyflakes = { enabled = false },
					pylint = { enabled = true },
					-- pylint = { enabled = true , executable = "pylint"},
					-- isort = { enabled = true },
					-- yapf = { enabled = true },
				},
			},
		},
		single_file_support = true,
	}

	require("lspconfig")["pylsp"].setup(opts)
end

return M
