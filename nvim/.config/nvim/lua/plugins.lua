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
	{
		"max397574/which-key.nvim",
		dependencies = {
			{
				"echasnovski/mini.nvim",
				version = false,
				config = function()
					require("mini.icons").setup()
				end,
			},
			{ "nvim-tree/nvim-web-devicons" },
		},
	},
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
	{
		"ray-x/lsp_signature.nvim",
		config = function()
			require("core.lsp_signature").setup()
		end,
		event = { "BufRead", "BufNew" },
	},
	{
		"zeioth/garbage-day.nvim",
		dependencies = "neovim/nvim-lspconfig",
		event = "VeryLazy",
		opts = {
			-- your options here
		},
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
		event = "InsertEnter",
		opts = {
			check_ts = true,
			ts_config = { java = false },
			fast_wrap = {
				map = "<M-e>",
				chars = { "{", "[", "(", '"', "'" },
				pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
				offset = 0,
				end_key = "$",
				keys = "qwertyuiopzxcvbnmasdfghjkl",
				check_comma = true,
				highlight = "PmenuSel",
				highlight_grey = "LineNr",
			},
		},
		config = function(_, opts)
			local npairs = require("nvim-autopairs")
			npairs.setup(opts)
			local cmp_status_ok, cmp = pcall(require, "cmp")
			if cmp_status_ok then
				cmp.event:on(
					"confirm_done",
					require("nvim-autopairs.completion.cmp").on_confirm_done({
						tex = false,
					})
				)
			end
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
		dependencies = {
			-- https://github.com/cli/cli/blob/trunk/docs/install_linux.md#arch-linux
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("octo").setup({
				suppress_missing_scope = {
					projects_v2 = true,
				},
			})
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
		commit = "f6f00d9ac1a51483ac78418f9e63126119a70709",
		event = "BufWinEnter",
	},

	-- trim.nvim [auto trim spaces]
	-- https://github.com/cappyzawa/trim.nvim
	{
		"cappyzawa/trim.nvim",
		event = "BufWrite",
		opts = {
			trim_on_write = true,
			trim_trailing = true,
			trim_last_line = false,
			trim_first_line = false,
		},
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
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("harpoon"):setup({})
		end,
	},
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

	-- filtypes
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
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

	{
		"Zeioth/compiler.nvim",
		cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
		dependencies = { "stevearc/overseer.nvim" },
		opts = {},
	},
	{
		"stevearc/overseer.nvim",
		commit = "68a2d344cea4a2e11acfb5690dc8ecd1a1ec0ce0",
		cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
		opts = {
			task_list = {
				direction = "bottom",
				min_height = 25,
				max_height = 25,
				default_detail = 1,
			},
		},
	},
})
