local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
	return
end

return lazy.setup({
	-- Core
	{ "max397574/which-key.nvim" },
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		cmd = "Neotree",
		dependencies = {
			{ "MunifTanjim/nui.nvim" },
		},
		config = function()
			require("core.neotree").config()
		end,
	},
	{
		"goolord/alpha-nvim",
		config = function()
			require("core.alpha").setup()
		end,
	},
	{
		"vladdoster/remember.nvim",
		config = function()
			require("remember").setup({})
		end,
	},

	--- LSP ---
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "neovim/nvim-lspconfig" },
	{ "nvimtools/none-ls.nvim" },
	-- {
	-- 				"kosayoda/nvim-lightbulb",
	-- 				config = function()
	-- 					require("plugins.lsp.nvim-lightbulb")
	-- 				end,
	-- 				event = { "InsertEnter", "CursorMoved" },
	-- 			},
	{ "onsails/lspkind-nvim" },
	{
		"ray-x/lsp_signature.nvim",
		config = function()
			require("core.lsp_signature").setup()
		end,
		event = { "BufRead", "BufNew" },
	},

	--- Navigation ---
	{
		"ggandor/leap.nvim",
		config = function()
			require("core.leap").setup()
		end,
	},

	--- Completion ---
	{
		"hrsh7th/nvim-cmp",
		module = { "nvim-cmp", "cmp" },
		config = function()
			require("core.cmp").setup()
		end,
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-buffer", -- source for text in buffer
			"hrsh7th/cmp-path", -- source for file system paths
			"saadparwaiz1/cmp_luasnip", -- for autocompletion
		},
	},
	{ "hrsh7th/cmp-cmdline" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "kdheepak/cmp-latex-symbols", ft = "tex" },

	-- Snippets
	{
		"L3MON4D3/LuaSnip",
		module = { "luasnip", "LuaSnip" },
		config = function()
			require("core.luasnip")
		end,
	},
	{ "nvim-lua/popup.nvim" },

	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		config = function()
			require("core.telescope").setup()
		end,
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			-- { "nvim-telescope/telescope-fzf-native.nvim" },
			{ "nvim-telescope/telescope-file-browser.nvim" },
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{ "nvim-telescope/telescope-live-grep-args.nvim" },
			{ "xiyaowong/telescope-emoji.nvim" },
			{ "nvim-telescope/telescope-media-files.nvim" },
			{ "nvim-telescope/telescope-project.nvim" },
			{ "nvim-telescope/telescope-frecency.nvim" },
		},
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	},

	-- Autopairs
	{
		"windwp/nvim-autopairs",
		config = function()
			require("core.autopairs").setup()
		end,
	},

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("core.treesitter").setup()
		end,
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		event = "BufReadPost",
	},

	-- Git
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("core.gitsigns").setup()
		end,
		event = "BufRead",
	},
	{
		"pwntester/octo.nvim",
		requires = {
			-- https://github.com/cli/cli/blob/trunk/docs/install_linux.md#arch-linux
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("octo").setup()
		end,
	},

	-- Comments
	{
		"numToStr/Comment.nvim",
		event = "BufRead",
		config = function()
			require("core.comment").setup()
		end,
	},
	{
		"folke/todo-comments.nvim",
		config = function()
			require("core.todo_comments").setup()
		end,
		event = "BufRead",
	},

	-- Status Line and Bufferline
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("core.lualine").setup()
		end,
	},
	{
		"akinsho/bufferline.nvim",
		config = function()
			require("core.bufferline").setup()
		end,
		branch = "main",
		event = "BufWinEnter",
	},

	-- Match-up
	{
		"andymass/vim-matchup",
		event = "BufReadPost",
		config = function()
			vim.g.matchup_enabled = 1
			vim.g.matchup_surround_enabled = 1
			vim.g.matchup_matchparen_deferred = 1
			vim.g.matchup_matchparen_offscreen = { method = "popup" }
		end,
	},

	--- EXTRA PLUGINS ---

	-- Trouble
	{
		"folke/trouble.nvim",
		dependencies = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup({
				auto_open = true,
				auto_close = true,
				padding = false,
				height = 10,
				use_diagnostic_signs = true,
			})
		end,
		cmd = "Trouble",
	},

	-- Outline
	{
		"liuchengxu/vista.vim",
		setup = function()
			require("core.vista").config()
		end,
		event = "BufReadPost",
	},

	-- diffview
	{
		"sindrets/diffview.nvim",
		module = "diffview",
		cmd = { "DiffviewOpen", "DiffviewFileHistory" },
		keys = { "<leader>gd" },
		config = function()
			require("diffview").setup({
				enhanced_diff_hl = true,
				key_bindings = {
					file_panel = { q = "<cmd>DiffviewClose<cr>" },
					view = { q = "<cmd>DiffviewClose<cr>" },
				},
			})
		end,
	},

	-- This is a nice-to-have but I don't have the muscle memory for this yet
	-- use({
	-- 	"abecodes/tabout.nvim",
	-- 	wants = { "nvim-treesitter" },
	-- 	after = { "nvim-cmp" },
	-- 	config = function()
	-- 		require("user.tabout").config()
	-- 	end,
	-- })
	{ "ThePrimeagen/harpoon" },
	{ "stevearc/dressing.nvim", event = "VeryLazy" },
	{
		"ThePrimeagen/refactoring.nvim",
		ft = { "typescript", "javascript", "lua", "c", "cpp", "go", "python", "java", "php" },
		event = "BufRead",
		config = function()
			require("refactoring").setup({})
		end,
	},
	{
		"kevinhwang91/nvim-bqf",
		config = function()
			require("extra.bqf").setup()
		end,
		event = "BufRead",
	},

	-- Winbar
	{
		"fgheng/winbar.nvim",
		config = function()
			require("extra.winbar").setup()
		end,
		event = { "InsertEnter", "CursorMoved" },
	},

	-- filtypes
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		ft = "markdown",
	},
	{
		"lervag/vimtex",
		config = function() end,
		ft = "tex",
		lazy = false,
	},
	{
		"mtdl9/vim-log-highlighting",
		ft = { "text", "log" },
	},

	-- indent line
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		scope_color = "surfact2",
		config = function()
			require("core.indent_blankline").setup()
		end,
	},

	{ "kg8m/vim-simple-align" },

	-- Colorscheme
	{ "sainnhe/gruvbox-material" },
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},

	{
		"nvim-orgmode/orgmode",
		config = function()
			-- Load custom treesitter grammar for org filetype
			require("orgmode").setup_ts_grammar()

			require("nvim-treesitter.configs").setup({
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = { "org" },
				},
				ensure_installed = { "org" }, -- Or run :TSUpdate org
			})

			require("orgmode").setup({
				org_highlight_latex_and_related = "entities",
				org_agenda_files = { "~/Documents/org/**/*" },
				org_default_notes_file = "~/Documents/org/refile.org",
				org_agenda_templates = {
					T = {
						description = "Todo",
						template = "* TODO %?\n  DEADLINE: %T",
						target = "~/Documents/org/todo.org",
					},
				},
			})
		end,
	},
	{ "elkowar/yuck.vim" },
})
