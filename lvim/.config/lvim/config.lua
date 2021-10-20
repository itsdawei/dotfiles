-- general
lvim.colorscheme = "onedarker"
lvim.format_on_save = false
lvim.transparent_window = false
vim.opt.wrap = false
lvim.debug = false

lvim.shell = "fish"

-- keymappings
lvim.leader = "space"

lvim.keys.normal_mode["<esc><esc>"] = "<cmd>nohlsearch<cr>"
lvim.keys.visual_mode["p"] = [["_dP]]

-- for finding syntax ids for non TS enabled languages
vim.cmd [[
map <F3> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">" . " FG:" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"fg#")<CR>
]]

-- LSP
lvim.lsp.diagnostics.virtual_text = false

-- Builtins
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
lvim.builtin.dap.active = true
lvim.builtin.bufferline.active = true

-- Whichkey
lvim.builtin.which_key.mappings["z"] = { "<cmd>ZenMode<cr>", "Zen" }
lvim.builtin.which_key.mappings["r"] = {
  name = "Replace",
  r = { "<cmd>lua require('spectre').open()<cr>", "Replace" },
  w = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "Replace Word" },
  f = { "<cmd>lua require('spectre').open_file_search()<cr>", "Replace Buffer" },
}
lvim.builtin.which_key.mappings.u = { "<cmd>UndotreeToggle<cr>", "undotree" }

-- Treesitter
lvim.builtin.treesitter.ensure_installed = "maintained"
lvim.builtin.treesitter.autotag.enable = true
lvim.builtin.treesitter.playground.enable = true
lvim.builtin.treesitter.indent.disable = { "python" }

-- Additional Plugins
lvim.plugins = {
  { "glepnir/oceanic-material" },
  { "sainnhe/gruvbox-material" },
  { "arcticicestudio/nord-vim" },
  { "joshdick/onedark.vim" },
  {
    "pwntester/octo.nvim",
    event = "BufRead",
    config = function()
      require("user.octo").config()
    end,
  },
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "InsertEnter",
  --   config = function()
  --     require("user.lsp_signature").config()
  --   end,
  -- },
  {
    "unblevable/quick-scope",
    config = function()
      require "user.quickscope"
    end,
  },
  {
    "kevinhwang91/rnvimr",
    config = function()
      require "user.rnvimr"
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require "user.blankline"
    end,
  },
  {
    "ruifm/gitlinker.nvim",
    event = "BufRead",
    config = function()
      require("user.gitlinker").config()
    end,
  },
  {
    "phaazon/hop.nvim",
    event = "BufRead",
    config = function()
      require("user.hop").config()
    end,
  },
  {
    "tamago324/lir.nvim",
    config = function()
      require "user.lir"
    end,
  },
  {
    "andymass/vim-matchup",
    event = "CursorMoved",
    config = function()
      require "user.matchup"
    end,
  },
  {
    "nacro90/numb.nvim",
    event = "BufRead",
    config = function()
      require("user.numb").config()
    end,
  },
  {
    "monaqa/dial.nvim",
    event = "BufRead",
    config = function()
      require("user.dial").config()
    end,
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("user.colorizer").config()
    end,
  },
  {
    "windwp/nvim-spectre",
    event = "BufRead",
    config = function()
      require("user.spectre").config()
    end,
  },
  {
    "folke/zen-mode.nvim",
    config = function()
      require("user.zen").config()
    end,
  },
  {
    "karb94/neoscroll.nvim",
    config = function()
      require("user.neoscroll").config()
    end,
  },
  {
    "vuki656/package-info.nvim",
    config = function()
      require "user.package-info"
    end,
    requires = { "MunifTanjim/nui.nvim" },
    ft = "json",
  },
  {
    "rcarriga/nvim-notify",
    event = "BufRead",
    config = function()
      require("user.notify").config()
    end,
  },
  {
    "simrat39/symbols-outline.nvim",
    config = function()
      require("user.outline").config()
    end,
  },
  {
    "tzachar/cmp-tabnine",
    config = function()
      local tabnine = require "cmp_tabnine.config"
      tabnine:setup {
        max_lines = 1000,
        max_num_results = 20,
        sort = true,
      }
    end,

    run = "./install.sh",
    requires = "hrsh7th/nvim-cmp",
  },
  {
    "dccsillag/magma-nvim",
    run = ":UpdateRemotePlugins",
  },
  {
    "metakirby5/codi.vim",
    cmd = "Codi",
  },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  {
    "kevinhwang91/nvim-bqf",
    event = "BufRead",
  },
  {
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    ft = "markdown",
  },
  {
    "nvim-treesitter/playground",
    event = "BufRead",
  },
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
  },
  {
    "sindrets/diffview.nvim",
    event = "BufRead",
  },
  { "rhysd/git-messenger.vim" },
  { "mbbill/undotree" },
  {
    "lervag/vimtex",
    ft = "tex",
  },
}
