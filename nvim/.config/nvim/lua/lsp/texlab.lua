M = {}

function M.setup()
	vim.g.vimtex_view_enabled = true
	vim.g.vimtex_compiler_method = "latexmk"
	vim.g.vimtex_view_method = "zathura"
	vim.g.vimtex_fold_enabled = 0
	vim.g.vimtex_quickfix_ignore_filters = {}

	vim.cmd([[
	  augroup vimtex_event_1
	    au!
	    au User VimtexEventQuit     VimtexClean
	    au User VimtexEventInitPost VimtexCompile
	  augroup END
  ]])

	local latexmk_args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" }
	local tex_preview_settings = { "--synctex-forward", "%l:1:%f", "%p" }

	local forward_search_executable = "zathura"
	local opts = {
		setup = {
			cmd = { vim.fn.stdpath("data") .. "/mason/packages/texlab/texlab" },
			filetypes = { "tex", "bib" },
			root_dir = function(fname)
				return require("lspconfig").util.path.dirname(fname)
			end,
			settings = {
				texlab = {
					auxDirectory = nil,
					bibtexFormatter = "texlab",
					build = {
						executable = "latexmk",
						args = latexmk_args,
						on_save = false,
						forward_search_after = false,
					},
					chktex = {
						on_open_and_save = false,
						on_edit = false,
					},
					forward_search = {
						executable = nil,
						args = {},
					},
					latexindent = {
						["local"] = nil,
						modify_line_breaks = false,
					},
					linters = { "chktex" },
					auto_save = false,
					ignore_errors = {},
					diagnosticsDelay = 300,
					formatterLineLength = 120,
					forwardSearch = {
						args = tex_preview_settings,
						executable = forward_search_executable,
					},
					latexFormatter = "latexindent",
				},
			},
		},
	}

	require("lspconfig")["texlab"].setup(opts)
end

return M
