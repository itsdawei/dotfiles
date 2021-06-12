require('lv-globals')
vim.cmd('luafile ~/.config/nvim/lv-settings.lua')
require('settings')
require('plugins')
require('lv-utils')
require('lv-autocommands')
require('keymappings')

-- require('lv-galaxyline')
-- require('lv-comment')
-- require('lv-compe')
-- require('lv-dashboard')
-- require('lv-telescope')
-- require('lv-gitsigns')
-- require('lv-treesitter')
-- require('lv-matchup')
-- require('lv-autopairs')
-- require('lv-rnvimr')
-- require('lv-which-key')
-- require('lv-lsp-rooter')
-- require('lv-zen')
-- require('lv-gitblame')

require('colorscheme')

require('colorizer')
require('fugitive')

vim.cmd('source '..CONFIG_PATH..'/vimscript/functions.vim')

-- LSP
require('lsp')
require('lsp.angular-ls')
require('lsp.bash-ls')
require('lsp.clangd')
require('lsp.cmake-ls')
require('lsp.css-ls')
require('lsp.dart-ls')
require('lsp.docker-ls')
require('lsp.efm-general-ls')
require('lsp.elm-ls')
require('lsp.emmet-ls')
require('lsp.graphql-ls')
require('lsp.go-ls')
require('lsp.html-ls')
require('lsp.json-ls')
require('lsp.js-ts-ls')
require('lsp.kotlin-ls')
require('lsp.latex-ls')
require('lsp.lua-ls')
require('lsp.php-ls')
require('lsp.python-ls')
require('lsp.ruby-ls')
require('lsp.rust-ls')
require('lsp.svelte-ls')
require('lsp.terraform-ls')
require('lsp.tailwindcss-ls')
require('lsp.vim-ls')
require('lsp.vue-ls')
require('lsp.yaml-ls')
require('lsp.elixir-ls')
