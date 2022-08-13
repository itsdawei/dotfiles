local M = {}

M.config = function()
	G.which_key = {
		setup = {
			plugins = {
				marks = true, -- shows a list of your marks on ' and `
				registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
				-- the presets plugin, adds help for a bunch of default keybindings in Neovim
				-- No actual key bindings are created
				presets = {
					operators = false, -- adds help for operators like d, y, ...
					motions = false, -- adds help for motions
					text_objects = false, -- help for text objects triggered after entering an operator
					windows = false, -- default bindings on <c-w>
					nav = true, -- misc bindings to work with windows
					z = true, -- bindings for folds, spelling and others prefixed with z
					g = true, -- bindings for prefixed with g
				},
				spelling = { enabled = true, suggestions = 20 }, -- use which-key for spelling hints
			},
			icons = {
				breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
				separator = "➜", -- symbol used between a key and it's label
				group = "+", -- symbol prepended to a group
			},
			popup_mappings = {
				scroll_down = "<c-d>", -- binding to scroll down inside the popup
				scroll_up = "<c-u>", -- binding to scroll up inside the popup
			},
			window = {
				border = "single", -- none, single, double, shadow
				position = "bottom", -- bottom, top
				margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
				padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
				winblend = 0,
			},
			layout = {
				height = { min = 4, max = 25 }, -- min and max height of the columns
				width = { min = 20, max = 50 }, -- min and max width of the columns
				spacing = 3, -- spacing between columns
				align = "left", -- align columns left, center or right
			},
			hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
			ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
			show_help = true, -- show help message on the command line when the popup is visible
			triggers = "auto", -- automatically setup triggers
			-- triggers = {"<leader>"} -- or specify a list manually
			triggers_blacklist = {
				-- list of mode / prefixes that should never be hooked by WhichKey
				-- this is mostly relevant for key maps that start with a native binding
				-- most people should not need to change this
				i = { "j", "k" },
				v = { "j", "k" },
			},
		},

		opts = {
			mode = "n", -- NORMAL mode
			prefix = "<leader>",
			buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
			silent = true, -- use `silent` when creating keymaps
			noremap = true, -- use `noremap` when creating keymaps
			nowait = true, -- use `nowait` when creating keymaps
		},
		vopts = {
			mode = "v", -- VISUAL mode
			prefix = "<leader>",
			buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
			silent = true, -- use `silent` when creating keymaps
			noremap = true, -- use `noremap` when creating keymaps
			nowait = true, -- use `nowait` when creating keymaps
		},
		-- NOTE: Prefer using : over <cmd> as the latter avoids going back in normal-mode.
		-- see https://neovim.io/doc/user/map.html#:map-cmd
		vmappings = {
			["/"] = { "<ESC><CMD>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>", "Comment" },
		},
		mappings = {
			["/"] = { "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>", "Comment" },
			["c"] = { "<cmd>BufferKill<CR>", "Close Buffer" },
			-- ["f"] = { require("lvim.core.telescope.custom-finders").find_project_files, "Find File" },
			["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
			b = {
				name = "Buffers",
				j = { "<cmd>BufferLinePick<cr>", "Jump" },
				f = { "<cmd>Telescope buffers<cr>", "Find" },
				b = { "<cmd>BufferLineCyclePrev<cr>", "Previous" },
				-- w = { "<cmd>BufferWipeout<cr>", "Wipeout" }, -- TODO: implement this for bufferline
				e = { "<cmd>BufferLinePickClose<cr>", "Pick which buffer to close" },
				h = { "<cmd>BufferLineCloseLeft<cr>", "Close all to the left" },
				l = { "<cmd>BufferLineCloseRight<cr>", "Close all to the right" },
				D = { "<cmd>BufferLineSortByDirectory<cr>", "Sort by directory" },
				L = { "<cmd>BufferLineSortByExtension<cr>", "Sort by language" },
			},
			p = {
				name = "Packer",
				s = { "<cmd>PackerSync<cr>", "Sync" },
				S = { "<cmd>PackerStatus<cr>", "Status" },
			},

			-- " Available Debug Adapters:
			-- "   https://microsoft.github.io/debug-adapter-protocol/implementors/adapters/
			-- " Adapter configuration and installation instructions:
			-- "   https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
			-- " Debug Adapter protocol:
			-- "   https://microsoft.github.io/debug-adapter-protocol/
			-- " Debugging
			g = {
				name = "Git",
				j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
				k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
				l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
				p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
				r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
				R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
				s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
				u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk" },
				o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
				b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
				c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
				C = { "<cmd>Telescope git_bcommits<cr>", "Checkout commit(for current file)" },
				d = { "<cmd>DiffviewOpen<cr>", "Git Diff" },
			},
			l = {
				name = "LSP",
				a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
				d = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", "Buffer Diagnostics" },
				w = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
				f = { "<cmd>lua vim.lsp.buf.format()<cr>", "Format" },
				i = { "<cmd>LspInfo<cr>", "Info" },
				I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
				j = { vim.diagnostic.goto_next, "Next Diagnostic" },
				k = { vim.diagnostic.goto_prev, "Prev Diagnostic" },
				l = { vim.lsp.codelens.run, "CodeLens Action" },
				p = {
					name = "Peek",
					d = { "<cmd>lua require('lvim.lsp.peek').Peek('definition')<cr>", "Definition" },
					t = { "<cmd>lua require('lvim.lsp.peek').Peek('typeDefinition')<cr>", "Type Definition" },
					i = { "<cmd>lua require('lvim.lsp.peek').Peek('implementation')<cr>", "Implementation" },
				},
				q = { vim.diagnostic.setloclist, "Quickfix" },
				r = { vim.lsp.buf.rename, "Rename" },
				s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
				S = {
					"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
					"Workspace Symbols",
				},
				e = { "<cmd>Telescope quickfix<cr>", "Telescope Quickfix" },
			},
			-- F = {
			-- 	name = "Find",
			-- 	f = { "<cmd>lua require('telescope').curbuf()<cr>", "Current Buffer" },
			-- 	g = { "<cmd>lua require('telescope').git_files()<cr>", "Git Files" },
			-- 	l = {
			-- 		"<cmd>lua require('telescope.builtin').resume()<cr>",
			-- 		"Last Search",
			-- 	},
			-- 	p = { "<cmd>lua require('user.telescope').project_search()<cr>", "Project" },
			-- 	s = { "<cmd>lua require('user.telescope').git_status()<cr>", "Git Status" },
			-- 	z = { "<cmd>lua require('user.telescope').search_only_certain_files()<cr>", "Certain Filetype" },
			-- },
			s = {
				name = "Search",
				b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
				c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
				f = { "<cmd>Telescope find_files<cr>", "Find File" },
				h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
				H = { "<cmd>Telescope highlights<cr>", "Find highlight groups" },
				M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
				r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
				R = { "<cmd>Telescope registers<cr>", "Registers" },
				t = { "<cmd>Telescope live_grep<cr>", "Text" },
				k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
				C = { "<cmd>Telescope commands<cr>", "Commands" },
				p = {
					"<cmd>lua require('telescope.builtin.internal').colorscheme({enable_preview = true})<cr>",
					"Colorscheme with Preview",
				},
			},
			t = {
				name = "Trouble",
				d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnosticss" },
				f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
				l = { "<cmd>Trouble loclist<cr>", "LocationList" },
				q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
				r = { "<cmd>Trouble lsp_references<cr>", "References" },
				t = { "<cmd>TodoLocList <cr>", "Todo" },
				w = { "<cmd>Trouble workspace_diagnostics<cr>", "Diagnosticss" },
			},

      -- Symbols
			o = { "<cmd>SymbolsOutline<cr>", "Symbol Outline" },

      -- Harpoon
			a = { "<cmd>lua require('harpoon.mark').add_file()<CR>", " Add Mark" },
			["<leader>"] = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", " Harpoon" },
			["<leader>1"] = { "<CMD>lua require('harpoon.ui').nav_file(1)<CR>", " goto1" },
			["<leader>2"] = { "<CMD>lua require('harpoon.ui').nav_file(2)<CR>", " goto2" },
			["<leader>3"] = { "<CMD>lua require('harpoon.ui').nav_file(3)<CR>", " goto3" },
			["<leader>4"] = { "<CMD>lua require('harpoon.ui').nav_file(4)<CR>", " goto4" },
		},
	}
end

M.setup = function()
	local wk_status, wk = pcall(require, "which-key")
	if not wk_status then
		return
	end

	wk.setup(G.which_key)

	local opts = G.which_key.opts
	local vopts = G.which_key.vopts

	local mappings = G.which_key.mappings
	local vmappings = G.which_key.vmappings

	wk.register(mappings, opts)
	wk.register(vmappings, vopts)

	-- Navigate merge conflict markers
	wk.register({
		["]n"] = { "[[:call search('^(@@ .* @@|[<=>|]{7}[<=>|]@!)', 'W')<cr>]]", "next merge conflict" },
		["[n"] = { "[[:call search('^(@@ .* @@|[<=>|]{7}[<=>|]@!)', 'bW')<cr>]]", "prev merge conflict" },
	})
end

return M
