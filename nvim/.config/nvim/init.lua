G = {
	transparent_window = false,
	use_icons = true,
}

vim.opt.termguicolors = true

vim.g.mapleader = " "

require("plugins")

require("keymappings").setup()

require("settings").setup()

require("autocmds").setup()

-- load snippets.
require("core.luasnip")

require("lsp").setup()

-- colorscheme must get called after plugins are loaded or it will break new installs.
vim.cmd([[
  " Set contrast.
  " This configuration option should be placed before `colorscheme gruvbox-material`.
  " Available values: 'hard', 'medium'(default), 'soft'
  let g:gruvbox_material_background = 'hard'

  " For better performance
  let g:gruvbox_material_better_performance = 1

  colorscheme gruvbox-material
]])
