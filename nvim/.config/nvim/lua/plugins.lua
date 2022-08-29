local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	PackerBootstrap = vim.fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
end

local M = {}

function M.setup()
	require("packer").startup(function(use)
		use({ "wbthomason/packer.nvim" })

		use({
			"vladdoster/remember.nvim",
			config = function()
				require("remember").setup({})
			end,
			event = "BufWinEnter",
		})

		use({ "neovim/nvim-lspconfig" })
		use({ "onsails/lspkind-nvim" })
		use({
			"ray-x/lsp_signature.nvim",
			config = function()
				require("core.lsp_signature").setup()
			end,
			event = { "BufRead", "BufNew" },
		})
		use({ "jose-elias-alvarez/null-ls.nvim" })

		use({ "antoinemadec/FixCursorHold.nvim" }) -- Needed while issue https://github.com/neovim/neovim/issues/12587 is still open
		use({ "williamboman/nvim-lsp-installer" })

		use({ "sainnhe/gruvbox-material" })

		use({ "nvim-lua/popup.nvim" })
		use({ "nvim-lua/plenary.nvim" })

		-- Telescope
		use({
			"nvim-telescope/telescope.nvim",
			config = function()
				require("core.telescope").setup()
			end,
		})
		use({
			"nvim-telescope/telescope-fzf-native.nvim",
			requires = { "nvim-telescope/telescope.nvim" },
			run = "make",
		})
		use({
			"nvim-telescope/telescope-file-browser.nvim",
			config = function()
				require("telescope").load_extension("file_browser")
			end,
		})
		use({ "nvim-telescope/telescope-live-grep-args.nvim" })

		-- Install nvim-cmp, and buffer source as a dependency
		use({
			"hrsh7th/nvim-cmp",
			config = function()
				require("core.cmp").setup()
			end,
			requires = {
				"L3MON4D3/LuaSnip",
			},
		})
		use({
			"L3MON4D3/LuaSnip",
			config = function()
				-- local utils = require "lvim.utils"
				local paths = {}
				-- local user_snippets = utils.join_paths(get_config_dir(), "snippets")
				-- if utils.is_directory(user_snippets) then
				--   paths[#paths + 1] = user_snippets
				-- end
				require("luasnip.loaders.from_lua").lazy_load()
				require("luasnip.loaders.from_vscode").lazy_load({
					paths = paths,
				})
				require("luasnip.loaders.from_snipmate").lazy_load()
			end,
		})
		use({ "hrsh7th/cmp-nvim-lsp" })
		use({ "saadparwaiz1/cmp_luasnip" })
		use({ "hrsh7th/cmp-buffer" })
		use({ "hrsh7th/cmp-path" })
		use({ "hrsh7th/cmp-cmdline" })
		use({ "kdheepak/cmp-latex-symbols", ft = "tex" })
		use({
			-- NOTE: Temporary fix till folke comes back
			"max397574/lua-dev.nvim",
			module = "lua-dev",
		})

		-- Autopairs
		use({
			"windwp/nvim-autopairs",
			-- event = "InsertEnter",
			config = function()
				require("core.autopairs").setup()
			end,
		})

		-- Treesitter
		use({
			"nvim-treesitter/nvim-treesitter",
			run = ":TSUpdate",
			config = function()
				require("core.treesitter").setup()
			end,
		})
		use({
			"JoosepAlviste/nvim-ts-context-commentstring",
			event = "BufReadPost",
		})

		-- NvimTree
		use({
			"kyazdani42/nvim-tree.lua",
			-- event = "BufWinOpen",
			cmd = "NvimTreeToggle",
			config = function()
				require("core.nvimtree").setup()
			end,
		})

		-- Git
		use({
			"lewis6991/gitsigns.nvim",
			config = function()
				require("core.gitsigns").setup()
			end,
			event = "BufRead",
		})

		-- Whichkey
		use({
			"max397574/which-key.nvim",
			config = function()
				require("core.which-key").setup()
			end,
			event = "BufWinEnter",
		})

		-- Comments
		use({
			"numToStr/Comment.nvim",
			event = "BufRead",
			config = function()
				require("core.comment").setup()
			end,
		})
		use({
			"folke/todo-comments.nvim",
			requires = "nvim-lua/plenary.nvim",
			config = function()
				local status_ok, todo = pcall(require, "todo-comments")
				if not status_ok then
					return
				end

				todo.setup({
					-- your configuration comes here
					-- or leave it empty to use the default settings
					-- refer to the configuration section below
				})
			end,
			event = "BufRead",
		})

		-- Icons
		use({ "kyazdani42/nvim-web-devicons" })

		-- Status Line and Bufferline
		use({
			"nvim-lualine/lualine.nvim",
			config = function()
				require("core.lualine").setup()
			end,
		})
		use({
			"akinsho/bufferline.nvim",
			config = function()
				require("core.bufferline").setup()
			end,
			branch = "main",
			event = "BufWinEnter",
		})

		-- alpha
		use({
			"goolord/alpha-nvim",
			config = function()
				require("core.alpha").setup()
			end,
		})

		--- EXTRA PLUGINS ---

		-- Trouble
		use({
			"folke/trouble.nvim",
			requires = "kyazdani42/nvim-web-devicons",
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
		})

		-- Symbol Outline
		use({
			"simrat39/symbols-outline.nvim",
			event = "BufReadPost",
		})

		-- diffview
		use({
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
		})

		use({
			"mtdl9/vim-log-highlighting",
			ft = { "text", "log" },
		})
		-- This might be a nice-to-have but I don't have the muscle memory for this yet
		-- use({
		-- 	"abecodes/tabout.nvim",
		-- 	wants = { "nvim-treesitter" },
		-- 	after = { "nvim-cmp" },
		-- 	config = function()
		-- 		require("user.tabout").config()
		-- 	end,
		-- })
		use({
			"j-hui/fidget.nvim",
			config = function()
				-- TODO Custom configuration
				-- require("user.fidget_spinner").config()
				require("fidget").setup({})
			end,
		})
		use({
			"ThePrimeagen/harpoon",
			requires = {
				{ "nvim-lua/plenary.nvim" },
				{ "nvim-lua/popup.nvim" },
			},
		})
		use({
			"editorconfig/editorconfig-vim",
			event = "BufRead",
		})
		use({
			"stevearc/dressing.nvim",
			config = function()
				-- require("user.dress").config()
			end,
			event = "BufWinEnter",
		})
		use({
			"ThePrimeagen/refactoring.nvim",
			ft = { "typescript", "javascript", "lua", "c", "cpp", "go", "python", "java", "php" },
			event = "BufRead",
			config = function()
				-- require("refactoring").setup({})
			end,
		})
		use({
			"kevinhwang91/nvim-bqf",
			config = function()
				require("extra.bqf").setup()
			end,
			event = "BufRead",
		})

		-- Winbar
		use({
			"fgheng/winbar.nvim",
			config = function()
				require("extra.winbar").setup()
			end,
			event = { "InsertEnter", "CursorMoved" },
		})

		-- filetype
		use({
			"nathom/filetype.nvim",
			config = function()
				require("extra.filetype").setup()
			end,
		})
		use({
			"iamcco/markdown-preview.nvim",
			run = "cd app && npm install",
			ft = "markdown",
		})
		use({
			"lervag/vimtex",
			ft = "tex",
		})
		use({
			"p00f/clangd_extensions.nvim",
			config = function()
				-- require("user.cle").config()
			end,
			ft = { "c", "cpp", "objc", "objcpp" },
		})
		-- Don't need this yet
		-- use({
		-- 	"chrisbra/csv.vim",
		-- 	ft = { "csv" },
		-- })

		-- clipboard management
		use({
			"AckslD/nvim-neoclip.lua",
			config = function()
				require("extra.neoclip").setup()
			end,
			opt = true,
			keys = "<leader>y",
			requires = { "kkharji/sqlite.lua", module = "sqlite" },
		})

		-- smooth scrolling
		use({
			"karb94/neoscroll.nvim",
			config = function()
				require("neoscroll").setup({
					easing_function = "quadratic",
				})
			end,
			event = "BufRead",
		})
		use({
			"declancm/cinnamon.nvim",
			config = function()
				require("cinnamon").setup({
					default_keymaps = true,
					extra_keymaps = true,
					extended_keymaps = false,
					centered = true,
					scroll_limit = 100,
				})
			end,
			event = "BufRead",
		})

		-- indent line
		use({
			"lukas-reineke/indent-blankline.nvim",
			config = function()
				require("indent_blankline").setup({})
			end,
		})

		-- startup time
		use({ "dstein64/vim-startuptime" })

		-- Tables
		use({
			"dhruvasagar/vim-table-mode",
			config = function()
				vim.cmd([[
          let g:table_mode_corner_corner='+'
          let g:table_mode_header_fillchar='='
        ]])
			end,
		})

		-- Automatically set up your configuration after cloning packer.nvim
		-- Put this at the end after all plugins
		if PackerBootstrap then
			require("packer").sync()
		end
	end)
end

return M
