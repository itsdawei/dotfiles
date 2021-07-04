require('default-config')
vim.cmd('luafile ' .. CONFIG_PATH .. '/lv-config.lua')
require('settings')
require('plugins')
vim.g.colors_name = O.colorscheme
vim.g.syntax = true
require('lv-utils')
require('keymappings')
require('lv-galaxyline')
require('lv-treesitter')
require('lv-which-key')
require('lsp')
if O.lang.emmet.active then require('lsp.emmet-ls') end

-- require('lv-comment')
-- require('lv-compe')
-- require('lv-dashboard')
-- require('lv-telescope')
-- require('lv-gitsigns')
-- require('lv-matchup')
-- require('lv-autopairs')
-- require('lv-rnvimr')
-- require('lv-lsp-rooter')
-- require('lv-zen')
-- require('lv-gitblame')

-- require('colorizer')
-- require('fugitive')

-- vim.cmd('source '..CONFIG_PATH..'/vimscript/functions.vim')

