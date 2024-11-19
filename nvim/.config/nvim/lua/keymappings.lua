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
		layout = {
			height = { min = 4, max = 25 }, -- min and max height of the columns
			width = { min = 20, max = 50 }, -- min and max width of the columns
			spacing = 3, -- spacing between columns
			align = "left", -- align columns left, center or right
		},
		show_help = true, -- show help message on the command line when the popup is visible
		triggers = "auto", -- automatically setup triggers
	},
	opts = {
		prefix = "<leader>",
		buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
		silent = true, -- use `silent` when creating keymaps
		noremap = true, -- use `noremap` when creating keymaps
		nowait = true, -- use `nowait` when creating keymaps
	},
	vmappings = {
		mode = { "v" },
		{
			"<leader>/",
			"<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
			desc = "Comment",
		},
		{
			"<leader>lr",
			"<esc><cmd>lua vim.lsp.buf.rename()<CR>",
			desc = "Rename",
		},
		{
			"<leader>r",
			function()
				require("ssr").open()
			end,
			desc = "Structural Replace",
		},
	},
	mappings = {
		mode = { "n" },
		-- ["<CR>"] = { "<cmd>lua require('user.neovim').maximize_current_split()<CR>", "Maximize"},
		{ "<leader>/", "<Plug>(comment_toggle_linewise_current)", desc = "Comment" },
		{
			"<leader>F",
			"<cmd>lua vim.lsp.buf.format({timeout_ms = 3000})<cr>",
			desc = "Format",
		},
		{
			"<leader>I",
			"<cmd>lua vim.lsp.inlay_hint(0)<cr>",
			desc = "Toggle Inlay",
			icon = { icon = " ", color = "green" },
		},
		{ "<leader>P", "<cmd>Telescope project<CR>", desc = "Projects", icon = " "},
		-- Navigate merge conflict markers
		{
			"<leader>[n",
			"[[:call search('^(@@ .* @@|[<=>|]{7}[<=>|]@!)', 'bW')<cr>]]",
			desc = "Prev merge conflict",
		},
		{
			"<leader>]n",
			"[[:call search('^(@@ .* @@|[<=>|]{7}[<=>|]@!)', 'W')<cr>]]",
			desc = "Next merge conflict",
		},
		-- Harpoon (https://github.com/ThePrimeagen/harpoon)
		{
			{
				"<leader><leader>",
				function()
					require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
				end,
				desc = "Harpoon",
        icon = " ",
			},
			{
				"<leader>a",
				function()
					require("harpoon"):list():add()
				end,
				desc = "Add Mark",
				icon = " ",
			},
			{
				"1",
				function()
					require("harpoon"):list():select(1)
				end,
				desc = " goto1",
			},
			{
				"2",
				function()
					require("harpoon"):list():select(2)
				end,
				desc = " goto2",
			},
			{
				"3",
				function()
					require("harpoon"):list():select(3)
				end,
				desc = " goto3",
			},
			{
				"4",
				function()
					require("harpoon"):list():select(4)
				end,
				desc = " goto4",
			},
		},
		{
			{ "<leader>b", group = "Buffer" },
			{ "<leader>b1", "<cmd>BufferLineGoToBuffer 1<cr>", desc = "goto 1" },
			{ "<leader>b2", "<cmd>BufferLineGoToBuffer 2<cr>", desc = "goto 2" },
			{ "<leader>b3", "<cmd>BufferLineGoToBuffer 3<cr>", desc = "goto 3" },
			{ "<leader>b4", "<cmd>BufferLineGoToBuffer 4<cr>", desc = "goto 4" },
			{ "<leader>b5", "<cmd>BufferLineGoToBuffer 5<cr>", desc = "goto 5" },
			{ "<leader>b6", "<cmd>BufferLineGoToBuffer 6<cr>", desc = "goto 6" },
			{ "<leader>b7", "<cmd>BufferLineGoToBuffer 7<cr>", desc = "goto 7" },
			{ "<leader>b8", "<cmd>BufferLineGoToBuffer 8<cr>", desc = "goto 8" },
			{ "<leader>b9", "<cmd>BufferLineGoToBuffer 9<cr>", desc = "goto 9" },
			{ "<leader>bc", "<cmd>BufferLinePickClose<cr>", desc = "Delete Buffer" },
			{ "<leader>bp", "<cmd>BufferLineTogglePin<cr>", desc = "Toggle Pin" },
			{ "<leader>bs", "<cmd>BufferLinePick<cr>", desc = "Pick Buffer" },
			{ "<leader>bf", "<cmd>Telescope buffers<cr>", desc = "Find" },
			{ "<leader>bb", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous" },
			{ "<leader>bt", "<cmd>BufferLineGroupToggle docs<CR>", desc = "toggle groups" },
			{
				"<leader>be",
				"<cmd>BufferLinePickClose<cr>",
				desc = "Pick which buffer to close",
			},
			{ "<leader>bh", "<cmd>BufferLineCloseLeft<cr>", desc = "Close all to the left" },
			{
				"<leader>bl",
				"<cmd>BufferLineCloseRight<cr>",
				desc = "Close all to the right",
			},
			{
				"<leader>bD",
				"<cmd>BufferLineSortByDirectory<cr>",
				desc = "Sort by directory",
			},
			{ "<leader>bL", "<cmd>BufferLineSortByExtension<cr>", desc = "Sort by language" },
		},
		{
			"<leader>e",
			"<cmd>Neotree filesystem toggle right<cr>",
			desc = "Explorer",
      icon = " "
		},
		{ "<leader>f", require("core.telescope").find_project_files, desc = "Find File" },
		{
			{ "<leader>g", group = "Git" },
			{
				"<leader>gj",
				"<cmd>lua require('gitsigns').next_hunk()<cr>",
				desc = "Next Hunk",
			},
			{
				"<leader>gk",
				"<cmd>lua require('gitsigns').prev_hunk()<cr>",
				desc = "Prev Hunk",
			},
			{
				"<leader>gl",
				"<cmd>lua require('gitsigns').blame_line()<cr>",
				desc = "Blame",
			},
			{
				"<leader>gp",
				"<cmd>lua require('gitsigns').preview_hunk()<cr>",
				desc = "Preview Hunk",
			},
			{
				"<leader>gr",
				"<cmd>lua require('gitsigns').reset_hunk()<cr>",
				desc = "Reset Hunk",
			},
			{
				"<leader>gR",
				"<cmd>lua require('gitsigns').reset_buffer()<cr>",
				desc = "Reset Buffer",
			},
			{
				"<leader>gs",
				"<cmd>lua require('gitsigns').stage_hunk()<cr>",
				desc = "Stage Hunk",
			},
			{
				"<leader>gu",
				"<cmd>lua require('gitsigns').undo_stage_hunk()<cr>",
				desc = "Undo Stage Hunk",
			},

			{
				"<leader>go",
				"<cmd>Telescope git_status<cr>",
				desc = "Open changed file",
			},
			{ "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch" },
			{ "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Checkout commit" },
			{
				"<leader>gC",
				"<cmd>Telescope git_bcommits<cr>",
				desc = "Checkout commit(for current file)",
			},
			{ "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diff" },
			{ "<leader>gh", "<cmd>DiffviewFileHistory<cr>", desc = "File History" },
		},
		{ "<leader>h", "<cmd>nohlsearch<CR>", desc = "No Highlight" },
		{
			{ "<leader>l", group = "LSP" },
			{
				"<leader>lS",
				"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
				desc = "Workspace Symbols",
			},
			{
				"<leader>la",
				"<cmd>lua vim.lsp.buf.code_action()<cr>",
				desc = "Code Action",
			},
			{
				"<leader>le",
				"<cmd>Telescope quickfix<cr>",
				desc = "Telescope Quickfix",
			},
			{
				"<leader>li",
				"<cmd>LspInfo<cr>",
				desc = "LSP Info",
			},
			{
				"<leader>lj",
				"<cmd>lua vim.diagnostic.goto_next({float = {border = 'rounded', focusable = false, source = 'always'}, severity = {min = vim.diagnostic.severity.WARN}})<cr>",
				desc = "Next Diagnostic",
			},
			{
				"<leader>lk",
				"<cmd>lua vim.diagnostic.goto_prev({float = {border = 'rounded', focusable = false, source = 'always'}, severity = {min = vim.diagnostic.severity.WARN}})<cr>",
				desc = "Prev Diagnostic",
			},
			{ "<leader>ll", vim.lsp.codelens.run, desc = "CodeLens Action" },
			{ "<leader>lq", vim.diagnostic.setloclist, desc = "Quickfix" },
			{ "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename" },
			{
				"<leader>ls",
				"<cmd>Telescope lsp_document_symbols<cr>",
				desc = "Document Symbols",
			},
			{ "<leader>lw", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
		},
		{
			{ "<leader>p", group = "Plugins" },
			{ "<leader>ps", "<cmd>Lazy<cr>", desc = "Lazy" },
		},
		{
			{ "<leader>s", group = "Search" },
			{ "<leader>sb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch" },
			{ "<leader>sc", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme" },
			{ "<leader>se", "<cmd>Telescope file_browser<cr>", desc = "File Browser" },
			{ "<leader>sf", "<cmd>Telescope find_files<cr>", desc = "Find File" },
			{ "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Find Help" },
			{
				"<leader>sl",
				"<cmd>lua require('telescope.builtin').resume()<cr>",
				desc = "Last Search",
			},
			{ "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
			{
				"<leader>sr",
				"<cmd>Telescope oldfiles<cr>",
				desc = "Recent File",
			},
			{
				"<leader>sR",
				"<cmd>Telescope registers<cr>",
				desc = "Registers",
			},
			{
				"<leader>ss",
				"<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>",
				desc = "String",
			},
			{ "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
			{ "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
		},
		{
			{ "<leader>t", group = "Trouble" },
			{
				"<leader>td",
				"<cmd>Trouble document_diagnostics<cr>",
				desc = "Diagnosticss",
			},
			{
				"<leader>tf",
				"<cmd>Trouble lsp_definitions<cr>",
				desc = "Definitions",
			},
			{
				"<leader>tl",
				"<cmd>Trouble loclist<cr>",
				desc = "LocationList",
			},
			{
				"<leader>tq",
				"<cmd>Trouble quickfix<cr>",
				desc = "QuickFix",
			},
			{
				"<leader>tr",
				"<cmd>Trouble lsp_references<cr>",
				desc = "References",
			},
			{
				"<leader>tt",
				"<cmd>TodoLocList <cr>",
				desc = "Todo",
			},
			{
				"<leader>tw",
				"<cmd>Trouble workspace_diagnostics<cr>",
				desc = "Diagnostics",
			},
		},
		-- Symbols (https://github.com/liuchengxu/vista.vim)
		{
			"<leader>v",
			"<cmd>Vista!!<cr>",
			desc = "Symbol Outline",
		},
	},
}

local defaults = {
	---@usage change or add keymappings for insert mode
	insert_mode = {
		-- For quitting insert mode.
		-- ["jk"] = "<ESC>",
		-- ["kj"] = "<ESC>",
		-- ["jj"] = "<ESC>",
	},
	---@usage change or add keymappings for normal mode
	normal_mode = {
		-- Better window movement
		["<C-h>"] = "<C-w>h",
		["<C-j>"] = "<C-w>j",
		["<C-k>"] = "<C-w>k",
		["<C-l>"] = "<C-w>l",

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

	wk.add(wk_settings.mappings, wk_settings.opts)
	wk.add(wk_settings.vmappings, wk_settings.opts)

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
