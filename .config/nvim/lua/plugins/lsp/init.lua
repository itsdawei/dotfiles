-- TODO figure out why this don't work
vim.fn.sign_define("LspDiagnosticsSignError", {
    texthl = "LspDiagnosticsSignError",
    text = "",
    numhl = "LspDiagnosticsSignError"
})
vim.fn.sign_define("LspDiagnosticsSignWarning", {
    texthl = "LspDiagnosticsSignWarning",
    text = "",
    numhl = "LspDiagnosticsSignWarning"
})
vim.fn.sign_define("LspDiagnosticsSignHint", {
    texthl = "LspDiagnosticsSignHint",
    text = "",
    numhl = "LspDiagnosticsSignHint"
})
vim.fn.sign_define("LspDiagnosticsSignInformation", {
    texthl = "LspDiagnosticsSignInformation",
    text = "",
    numhl = "LspDiagnosticsSignInformation"
})

local opts = {noremap = true, silent = true}

Keybind.g({
    {'n', '<leader>vd', [[<cmd>lua vim.lsp.buf.definition()<CR>]], opts},
    {'n', '<leader>vD', [[<cmd>lua vim.lsp.buf.declaration()<CR>]], opts},
    {'n', 'K', [[<cmd>lua vim.lsp.buf.hover()<CR>]], opts},
    {'n', '<leader>vi', [[<cmd>lua vim.lsp.buf.implementation()<CR>]], opts},
    {'n', '<leader>vsh', [[<cmd>lua vim.lsp.buf.signature_help()<CR>]], opts},
    {'n', '<leader>vrr', [[<cmd>lua vim.lsp.buf.references()<CR>]], opts},
    {'n', '<leader>vrn', [[<cmd>lua vim.lsp.buf.rename()<CR>]], opts}, {
        'n', '<leader>vsd',
        [[<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>]], opts
    },
    {'n', '<leader>vn', [[<cmd>lua vim.lsp.diagnostic.goto_next()<CR>]], opts},
    {
        'n', '<leader>vll', [[<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>]],
        opts
    }
})

-- symbols for autocomplete
vim.lsp.protocol.CompletionItemKind = {
    "   (Text) ", "   (Method)", "   (Function)",
    "   (Constructor)", " ﴲ  (Field)", "[] (Variable)", "   (Class)",
    " ﰮ  (Interface)", "   (Module)", " 襁 (Property)", "   (Unit)",
    "   (Value)", " 練 (Enum)", "   (Keyword)", " ﬌  (Snippet)",
    "   (Color)", "   (File)", "   (Reference)", "   (Folder)",
    "   (EnumMember)", " ﲀ  (Constant)", " ﳤ  (Struct)", "   (Event)",
    "   (Operator)", "   (TypeParameter)"
}

local function documentHighlight(client, bufnr)
    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=#464646
      hi LspReferenceText cterm=bold ctermbg=red guibg=#464646
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=#464646
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
    end
end

local lsp_config = {}

function lsp_config.common_on_attach(client, bufnr)
    documentHighlight(client, bufnr)
end

function lsp_config.tsserver_on_attach(client, bufnr)
    lsp_config.common_on_attach(client, bufnr)
    client.resolved_capabilities.document_formatting = false
end

-- Use a loop to conveniently both setup defined servers
-- and map buffer local keybindings when the language server attaches
-- local servers = {"clangd"}
-- for _, lsp in ipairs(servers) do require'lspconfig'[lsp].setup {on_attach = on_attach} end

return lsp_config
