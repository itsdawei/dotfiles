require('plugins')
require('lv-globals')
require('lv-utils')
vim.cmd('luafile ~/.config/nvim/lv-settings.lua')
require('lv-autocommands')
require('settings')
require('keymappings')
require('colorscheme')

require('lv-galaxyline')
require('lv-comment')
require('lv-compe')
require('lv-dashboard')
require('lv-telescope')
require('lv-gitsigns')
require('lv-nvimtree')
require('lv-treesitter')
require('lv-autopairs')
require('lv-rnvimr')


require('colorizer')
require('floaterm')
require('fugitive')
require('git-messenger')
require('goyo')
require('indentline')

-- Which Key (Hope to replace with Lua plugin someday)
vim.cmd('source ~/.config/nvim/vimscript/lv-whichkey/init.vim')
vim.cmd('source ~/.config/nvim/vimscript/functions.vim')

-- LSP
require('lsp')
require('lsp.clangd')
require('lsp.php-ls')
require('lsp.dart-ls')
require('lsp.lua-ls')
require('lsp.bash-ls')
require('lsp.go-ls')
require('lsp.js-ts-ls')
require('lsp.python-ls')
require('lsp.rust-ls')
require('lsp.json-ls')
require('lsp.yaml-ls')
require('lsp.terraform-ls')
require('lsp.vim-ls')
require('lsp.graphql-ls')
require('lsp.docker-ls')
require('lsp.html-ls')
require('lsp.css-ls')
require('lsp.emmet-ls')
require('lsp.efm-general-ls')
require('lsp.latex-ls')
require('lsp.svelte-ls')
require('lsp.tailwindcss-ls')
require('lsp.ruby-ls')
require('lsp.kotlin-ls')
