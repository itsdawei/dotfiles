vim.cmd [[packadd nvim-lspconfig]]
vim.cmd [[packadd completion-nvim]]

require('plugins.lsp.settings')
require('plugins.lsp.keybinds')
