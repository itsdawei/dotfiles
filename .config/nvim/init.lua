-- generics
require('utils')

-- vim core settings
Reload.reload_module('general')
require('general')

-- vim plugins settings
Reload.reload_module('plugins')
require('plugins')

require('packer-setup')


local indent = 2

-- vim.cmd "colorscheme gruvbox"
-- vim.cmd "colorscheme oceanic_material"
-- vim.cmd "colorscheme onedark"
vim.cmd "colorscheme nord"
