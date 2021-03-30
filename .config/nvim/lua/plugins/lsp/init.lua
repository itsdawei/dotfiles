vim.cmd [[packadd nvim-lspconfig]]
vim.cmd [[packadd nvim-compe]]

require('plugins.lsp.settings')
require('plugins.lsp.keybinds')
