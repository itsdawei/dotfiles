local M = {}

local generic_opts_any = { noremap = true, silent = true }

local generic_opts = {
	insert_mode = generic_opts_any,
	normal_mode = generic_opts_any,
	visual_mode = generic_opts_any,
	visual_block_mode = generic_opts_any,
	command_mode = generic_opts_any,
	term_mode = { silent = true },
}

local mode_adapters = {
	insert_mode = "i",
	normal_mode = "n",
	term_mode = "t",
	visual_mode = "v",
	visual_block_mode = "x",
	command_mode = "c",
}

local wk_settings = {
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
	vmappings = {
		["/"] = { "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", "Comment" },
		l = {
			r = { "<esc><cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
		},
		r = {
			function()
				require("ssr").open()
			end,
			"Structural replace",
		},
	},
	mappings = {
		-- ["<CR>"] = { "<cmd>lua require('user.neovim').maximize_current_split()<CR>", "Maximize"},
		["/"] = { "<cmd>lua require('Comment.api').toggle.linewise.current(nil)<CR>", "Comment" },
		h = { "<cmd>nohlsearch<CR>", "No Highlight" },
		e = { "<cmd>NeoTreeRevealToggle<CR>", " Explorer" },
		f = { require("core.telescope").find_project_files, "Find File" },
		-- Navigate merge conflict markers
		["]n"] = { "[[:call search('^(@@ .* @@|[<=>|]{7}[<=>|]@!)', 'W')<cr>]]", "next merge conflict" },
		["[n"] = { "[[:call search('^(@@ .* @@|[<=>|]{7}[<=>|]@!)', 'bW')<cr>]]", "prev merge conflict" },
		b = {
			name = "﩯Buffer",
			["1"] = { "<Cmd>BufferLineGoToBuffer 1<CR>", "goto 1" },
			["2"] = { "<Cmd>BufferLineGoToBuffer 2<CR>", "goto 2" },
			["3"] = { "<Cmd>BufferLineGoToBuffer 3<CR>", "goto 3" },
			["4"] = { "<Cmd>BufferLineGoToBuffer 4<CR>", "goto 4" },
			["5"] = { "<Cmd>BufferLineGoToBuffer 5<CR>", "goto 5" },
			["6"] = { "<Cmd>BufferLineGoToBuffer 6<CR>", "goto 6" },
			["7"] = { "<Cmd>BufferLineGoToBuffer 7<CR>", "goto 7" },
			["8"] = { "<Cmd>BufferLineGoToBuffer 8<CR>", "goto 8" },
			["9"] = { "<Cmd>BufferLineGoToBuffer 9<CR>", "goto 9" },
			c = { "<Cmd>BufferLinePickClose<CR>", "Delete Buffer" },
			p = { "<Cmd>BufferLineTogglePin<CR>", "Toggle Pin" },
			s = { "<Cmd>BufferLinePick<CR>", "Pick Buffer" },
			f = { "<cmd>Telescope buffers<cr>", "Find" },
			b = { "<cmd>BufferLineCyclePrev<cr>", "Previous" },
			t = { "<cmd>BufferLineGroupToggle docs<CR>", "toggle groups" },
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
			d = { "<cmd>DiffviewOpen<cr>", "Diff" },
			h = { "<cmd>DiffviewFileHistory<cr>", "File History" },
		},
		F = { "<cmd>lua vim.lsp.buf.format({timeout_ms = 10000})<cr>", "Format" },
		l = {
			name = "LSP",
			a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
			w = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
			i = { "<cmd>LspInfo<cr>", "LSP Info" },
			j = {
				"<cmd>lua vim.diagnostic.goto_next({float = {border = 'rounded', focusable = false, source = 'always'}, severity = {min = vim.diagnostic.severity.WARN}})<cr>",
				"Next Diagnostic",
			},
			k = {
				"<cmd>lua vim.diagnostic.goto_prev({float = {border = 'rounded', focusable = false, source = 'always'}, severity = {min = vim.diagnostic.severity.WARN}})<cr>",
				"Prev Diagnostic",
			},
			l = { vim.lsp.codelens.run, "CodeLens Action" },
			q = { vim.diagnostic.setloclist, "Quickfix" },
			r = { vim.lsp.buf.rename, "Rename" },
			s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
			S = {
				"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
				"Workspace Symbols",
			},
			e = { "<cmd>Telescope quickfix<cr>", "Telescope Quickfix" },
		},
		s = {
			name = "Search",
			b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
			c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
			e = { "<cmd>Telescope file_browser<cr>", "File Browser" },
			f = { "<cmd>Telescope find_files<cr>", "Find File" },
			h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
			l = { "<cmd>lua require('telescope.builtin').resume()<cr>", "Last Search" },
			M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
			r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
			-- R = { "<cmd>Telescope registers<cr>", "Registers" },
			s = { "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>", "String" },
			k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
			C = { "<cmd>Telescope commands<cr>", "Commands" },
		},
		t = {
			name = "Trouble",
			d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnosticss" },
			f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
			l = { "<cmd>Trouble loclist<cr>", "LocationList" },
			q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
			r = { "<cmd>Trouble lsp_references<cr>", "References" },
			t = { "<cmd>TodoLocList <cr>", "Todo" },
			w = { "<cmd>Trouble workspace_diagnostics<cr>", "Diagnostics" },
		},
		-- Symbols (https://github.com/liuchengxu/vista.vim)
		v = { "<cmd>Vista!!<cr>", "Symbol Outline" },
		-- Harpoon (https://github.com/ThePrimeagen/harpoon)
		a = { "<cmd>lua require('harpoon.mark').add_file()<CR>", " Add Mark" },
		["<leader>"] = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", " Harpoon" },
		["<leader>1"] = { "<CMD>lua require('harpoon.ui').nav_file(1)<CR>", " goto1" },
		["<leader>2"] = { "<CMD>lua require('harpoon.ui').nav_file(2)<CR>", " goto2" },
		["<leader>3"] = { "<CMD>lua require('harpoon.ui').nav_file(3)<CR>", " goto3" },
		["<leader>4"] = { "<CMD>lua require('harpoon.ui').nav_file(4)<CR>", " goto4" },
		P = { "<cmd>Telescope project<CR>", " Projects" },
		-- Mind
		M = {
			c = {
				function()
					require("mind").wrap_main_tree_fn(function(args)
						require("mind.commands").copy_node_link_index(args.get_tree(), nil, args.opts)
					end)
				end,
				"Copy node link index",
			},
			j = {
				function()
					require("mind").wrap_main_tree_fn(function(args)
						local tree = args.get_tree()
						local path = vim.fn.strftime("/Journal/%Y/%b/%d")
						local _, node = require("mind.node").get_node_by_path(tree, path, true)

						if node == nil then
							vim.notify("cannot open journal 🙁", vim.log.levels.WARN)
							return
						end

						require("mind.commands").open_data(tree, node, args.data_dir, args.save_tree, args.opts)
						args.save_tree()
					end)
				end,
				"Open journal",
			},
			M = { "<cmd>MindOpenMain<CR>", "Open main tree" },
			z = { "<cmd>MindClose<CR>", "Close" },
			m = { "<cmd>MindOpenSmartProject<CR>", "Open smart project tree" },
			s = {
				function()
					require("mind").wrap_smart_project_tree_fn(function(args)
						require("mind.commands").open_data_index(
							args.get_tree(),
							args.data_dir,
							args.save_tree,
							args.opts
						)
					end)
				end,
				"Open data index",
			},
		},
	},
}

local defaults = {
	---@usage change or add keymappings for insert mode
	insert_mode = {
		-- For quitting insert mode.
		["jk"] = "<ESC>",
		["kj"] = "<ESC>",
		["jj"] = "<ESC>",
	},
	---@usage change or add keymappings for normal mode
	normal_mode = {
		-- Better window movement
		-- ["<C-h>"] = "<C-w>h",
		-- ["<C-j>"] = "<C-w>j",
		-- ["<C-k>"] = "<C-w>k",
		-- ["<C-l>"] = "<C-w>l",

		-- Resize with arrows
		["<C-Up>"] = ":resize -2<CR>",
		["<C-Down>"] = ":resize +2<CR>",
		["<C-Left>"] = ":vertical resize -2<CR>",
		["<C-Right>"] = ":vertical resize +2<CR>",
		-- Buffer
		["<S-x>"] = "<cmd>lua require('core.bufferline').delete_buffer()<CR>",
		["<S-l>"] = ":BufferLineCycleNext<CR>",
		["<S-h>"] = ":BufferLineCyclePrev<CR>",
		-- Move current line / block with Alt-j/k a la vscode.
		["<A-j>"] = ":m .+1<CR>==",
		["<A-k>"] = ":m .-2<CR>==",
		-- QuickFix
		["]q"] = ":cnext<CR>",
		["[q"] = ":cprev<CR>",
		["<C-q>"] = ":call QuickFixToggle()<CR>",
		-- Harpoon
		["tu"] = "<cmd>lua require('harpoon.term').gotoTerminal(1)<CR>",
		["te"] = "<cmd>lua require('harpoon.term').gotoTerminal(2)<CR>",
		["cu"] = "<cmd>lua require('harpoon.term').sendCommand(1, 1)<CR>",
		["ce"] = "<cmd>lua require('harpoon.term').sendCommand(1, 2)<CR>",
		-- Reload Luasnip
		-- ["<leader><leader>s"] = "require('luasnip.loaders.from_lua').load({paths = '~/.config/nvim/snippets'})",
	},
	---@usage change or add keymappings for terminal mode
	term_mode = {
		-- Terminal window navigation
		["<C-h>"] = "<C-\\><C-N><C-w>h",
		["<C-j>"] = "<C-\\><C-N><C-w>j",
		["<C-k>"] = "<C-\\><C-N><C-w>k",
		["<C-l>"] = "<C-\\><C-N><C-w>l",
	},
	---@usage change or add keymappings for visual mode
	visual_mode = {
		["<"] = "<gv",
		[">"] = ">gv",
		["Y"] = "y$",
		["p"] = [["_dP]],
		["ga"] = "<esc><cmd>lua vim.lsp.buf.range_code_action()<CR>",
		["<leader>st"] = "<cmd>lua require('user.telescope').grep_string_visual()<CR>",
		-- ["p"] = '"0p',
		-- ["P"] = '"0P',
	},
	---@usage change or add keymappings for visual block mode
	visual_block_mode = {
		-- Move selected line / block of text in visual mode
		["K"] = ":move '<-2<CR>gv-gv",
		["J"] = ":move '>+1<CR>gv-gv",
	},
	---@usage change or add keymappings for command mode
	command_mode = {
		-- navigate tab completion with <c-j> and <c-k>
		-- runs conditionally
		["<C-j>"] = { 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { expr = true, noremap = true } },
		["<C-k>"] = { 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { expr = true, noremap = true } },
	},
}

if vim.fn.has("mac") == 1 then
	defaults.normal_mode["<A-Up>"] = defaults.normal_mode["<C-Up>"]
	defaults.normal_mode["<A-Down>"] = defaults.normal_mode["<C-Down>"]
	defaults.normal_mode["<A-Left>"] = defaults.normal_mode["<C-Left>"]
	defaults.normal_mode["<A-Right>"] = defaults.normal_mode["<C-Right>"]
end

-- Setup the default keymappings
function M.setup()
	local wk = require("which-key")
	wk.setup(wk_settings.setup)
	wk.register(wk_settings.mappings, wk_settings.opts)
	wk.register(wk_settings.vmappings, wk_settings.vopts)

	local keymaps = defaults or {}
	for mode, mapping in pairs(keymaps) do
		mode = mode_adapters[mode] or mode
		for key, val in pairs(mapping) do
			local opt = generic_opts[mode] or generic_opts_any
			if type(val) == "table" then
				opt = val[2]
				val = val[1]
			end
			if val then
				vim.api.nvim_set_keymap(mode, key, val, opt)
			else
				pcall(vim.api.nvim_del_keymap, mode, key)
			end
		end
	end
end

return M
