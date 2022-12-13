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
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "none" })
    end,
  },
})

-- Install your plugins here
return packer.startup(function(use)
  -- Core
  use({
    "lewis6991/impatient.nvim",
    config = function()
      require("impatient").enable_profile()
    end,
  })
  use({ "wbthomason/packer.nvim" })
  use({ "max397574/which-key.nvim" })
  use({
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
      { "MunifTanjim/nui.nvim" },
      { "kyazdani42/nvim-web-devicons" },
    },
    config = function()
      require("core.neotree").config()
    end,
  })
  use({
    "goolord/alpha-nvim",
    config = function()
      require("core.alpha").setup()
    end,
  })
  use({
    "vladdoster/remember.nvim",
    config = function()
      require("remember").setup({})
    end,
    event = "BufWinEnter",
  })

  --- LSP ---
  use({ "williamboman/mason.nvim" })
  use({ "williamboman/mason-lspconfig.nvim" })
  use({ "neovim/nvim-lspconfig" })
  use({ "jose-elias-alvarez/null-ls.nvim" })
  -- {
  -- 				"kosayoda/nvim-lightbulb",
  -- 				config = function()
  -- 					require("plugins.lsp.nvim-lightbulb")
  -- 				end,
  -- 				event = { "InsertEnter", "CursorMoved" },
  -- 			},
  use({ "onsails/lspkind-nvim" })
  use({
    "ray-x/lsp_signature.nvim",
    config = function()
      require("core.lsp_signature").setup()
    end,
    event = { "BufRead", "BufNew" },
  })

  --- Completion ---
  use({
    "hrsh7th/nvim-cmp",
    module = { "nvim-cmp", "cmp" },
    config = function()
      require("core.cmp").setup()
    end,
    event = "InsertEnter *",
  })
  -- Sources
  use({ "hrsh7th/cmp-buffer" })
  use({ "hrsh7th/cmp-path" })
  use({ "hrsh7th/cmp-cmdline" })
  use({ "hrsh7th/cmp-nvim-lsp" })
  use({ "hrsh7th/cmp-nvim-lua" })
  use({ "saadparwaiz1/cmp_luasnip" })
  use({ "kdheepak/cmp-latex-symbols", ft = "tex" })
  -- Snippets
  use({
    "L3MON4D3/LuaSnip",
    modele = { "luasnip", "LuaSnip" },
    config = function()
      -- require("luasnip.loaders.from_vscode").lazy_load()
      -- require("luasnip.loaders.from_vscode").lazy_load({ paths = "~/.config/nvim/snippets" })
      -- require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets" })
      require("luasnip.loaders.from_snipmate").lazy_load()
    end,
  })

  use({ "nvim-lua/popup.nvim" })

  -- Telescope
  use({
    "nvim-telescope/telescope.nvim",
    config = function()
      require("core.telescope").setup()
    end,
    requires = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-file-browser.nvim" },
      { "nvim-telescope/telescope-ui-select.nvim" },
      { "nvim-telescope/telescope-fzf-native.nvim" },
      { "nvim-telescope/telescope-live-grep-args.nvim" },
      { "xiyaowong/telescope-emoji.nvim" },
      { "nvim-telescope/telescope-media-files.nvim" },
      { "nvim-telescope/telescope-project.nvim" },
      { "nvim-telescope/telescope-frecency.nvim" },
    },
  })

  -- Autopairs
  use({
    "windwp/nvim-autopairs",
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

  -- Git
  use({
    "lewis6991/gitsigns.nvim",
    config = function()
      require("core.gitsigns").setup()
    end,
    event = "BufRead",
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
    config = function()
      require("core.todo_comments").config()
    end,
    event = "BufRead",
  })

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

  -- Outline
  use({
    "liuchengxu/vista.vim",
    setup = function()
      require("core.vista").config()
    end,
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

  -- This might be a nice-to-have but I don't have the muscle memory for this yet
  -- use({
  -- 	"abecodes/tabout.nvim",
  -- 	wants = { "nvim-treesitter" },
  -- 	after = { "nvim-cmp" },
  -- 	config = function()
  -- 		require("user.tabout").config()
  -- 	end,
  -- })
  use({ "ThePrimeagen/harpoon" })
  use({
    "editorconfig/editorconfig-vim",
    event = "BufRead",
  })
  use({ "stevearc/dressing.nvim" })
  use({
    "ThePrimeagen/refactoring.nvim",
    ft = { "typescript", "javascript", "lua", "c", "cpp", "go", "python", "java", "php" },
    event = "BufRead",
    config = function()
      require("refactoring").setup({})
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

  -- filtypes
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
    "mtdl9/vim-log-highlighting",
    ft = { "text", "log" },
  })

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

  use("kg8m/vim-simple-align")

  -- Colorscheme
  use({ "sainnhe/gruvbox-material" })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PackerBootstrap then
    require("packer").sync()
  end
end)
