M = {}

function M.setup()
	vim.g.vimtex_view_enabled = true
	vim.g.vimtex_compiler_method = "latexmk"
	vim.g.vimtex_compiler_latexmk = {
		aux_dir = "build",
		options = {
			"-verbose",
			"-file-line-error",
			"-synctex=1",
			"-interaction=nonstopmode",
		},
	}
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

	local opts = {
		setup = {
			cmd = { vim.fn.stdpath("data") .. "/mason/packages/texlab/texlab" },
			-- filetypes = { "tex", "bib" },
			root_dir = function(fname)
				return require("lspconfig").util.path.dirname(fname)
			end,
			settings = {
				-- https://github.com/latex-lsp/texlab/wiki/Configuration
				texlab = {
					build = {
						-- executable = "latexmk",
						-- args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f", "-auxdir=build" },
						-- on_save = false,
						-- forward_search_after = false,
					},
					diagnosticsDelay = 300,
					formatterLineLength = 80,
					chktex = {
						on_open_and_save = false,
						on_edit = true,
					},
					forwardSearch = {
						executable = "zathura",
						args = { "--synctex-forward", "%l:1:%f", "%p" },
					},
					bibtexFormatter = "latexindent",
					latexFormatter = "latexindent",
					latexindent = {
						modify_line_breaks = false,
					},
				},
			},
		},
	}

	require("lspconfig")["texlab"].setup(opts)
end

return M
