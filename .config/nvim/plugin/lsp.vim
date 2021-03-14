set completeopt=menuone,noinsert,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

nnoremap <Leader>vd :lua vim.lsp.buf.definition()<CR>
nnoremap <Leader>vi :lua vim.lsp.buf.implementation()<CR>
nnoremap <Leader>vsh :lua vim.lsp.buf.signature_help()<CR>
nnoremap <Leader>vrr :lua vim.lsp.buf.references()<CR>
nnoremap <Leader>vrn :lua vim.lsp.buf.rename()<CR>
nnoremap <Leader>vsh :lua vim.lsp.buf.hover()<CR>
nnoremap <Leader>vca :lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>vsd :lua vim.lsp.util.show_line_diagnostics(); vim.lsp.util.show_line_diagnostics()<CR>
nnoremap <Leader>vn :lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <leader>vll :lua vim.lsp.diagnostic.set_loclist()<CR>

lua << EOF
    local on_attach = require'completion'.on_attach

    require'lspconfig'.tsserver.setup{ on_attach=on_attach }
    require'lspconfig'.clangd.setup {
        on_attach = on_attach,
        root_dir = function() return vim.loop.cwd() end
    }
    require'lspconfig'.pyls.setup{ on_attach=on_attach }
    require'lspconfig'.cssls.setup{ on_attach=on_attach }
    require'lspconfig'.html.setup{ on_attach=on_attach }
EOF

let g:vimsyn_embed = "l"
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
let g:completion_confirm_key = ""
let g:completion_enable_snippet = 'UltiSnips'
let g:completion_trigger_on_delete = 1

lua << EOF
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    -- This will disable virtual text, like doing:
    -- let g:diagnostic_enable_virtual_text = 0
    virtual_text = false,

    -- This is similar to:
    -- let g:diagnostic_show_sign = 1
    -- To configure sign display,
    --  see: ":help vim.lsp.diagnostic.set_signs()"
    signs = true,

    -- This is similar to:
    -- "let g:diagnostic_insert_delay = 1"
    update_in_insert = false,
    underline = false,
  }
)
EOF

nnoremap <Leader>F :Neoformat<CR>
