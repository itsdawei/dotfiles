local opts = {noremap = true, silent = true}

Keybind.g({
	{ 'n', '<leader>vd', [[<cmd>lua vim.lsp.buf.definition()<CR>]], opts },
	{ 'n', '<leader>vD', [[<cmd>lua vim.lsp.buf.declaration()<CR>]], opts },
    { 'n', 'K', [[<cmd>lua vim.lsp.buf.hover()<CR>]], opts},
	{ 'n', '<leader>vi', [[<cmd>lua vim.lsp.buf.implementation()<CR>]], opts },
	{ 'n', '<leader>vsh', [[<cmd>lua vim.lsp.buf.signature_help()<CR>]], opts },
	{ 'n', '<leader>vrr', [[<cmd>lua vim.lsp.buf.references()<CR>]], opts },
	{ 'n', '<leader>vrn', [[<cmd>lua vim.lsp.buf.rename()<CR>]], opts },
	{ 'n', '<leader>vsd', [[<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>]], opts },
	{ 'n', '<leader>vn', [[<cmd>lua vim.lsp.diagnostic.goto_next()<CR>]], opts },
	{ 'n', '<leader>vll', [[<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>]], opts },
})
