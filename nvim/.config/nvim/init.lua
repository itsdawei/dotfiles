G = {
	transparent_window = false,
	use_icons = true,
}

require("keymappings").setup()

require("builtins").setup()

require("settings").setup()

require("autocmds").setup()
-- autocmds.enable_transparent_mode()

vim.g.mapleader = " "

require("plugins").setup()
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
