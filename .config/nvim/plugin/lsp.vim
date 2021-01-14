set completeopt=menuone,noinsert,noselect

nnoremap <Leader>vd :lua vim.lsp.buf.definition()<CR>
nnoremap <Leader>vi :lua vim.lsp.buf.implementation()<CR>
nnoremap <Leader>vsh :lua vim.lsp.buf.signature_help()<CR>
nnoremap <Leader>vrr :lua vim.lsp.buf.references()<CR>
nnoremap <Leader>vrn :lua vim.lsp.buf.rename()<CR>
nnoremap <Leader>vh :lua vim.lsp.buf.hover()<CR>
nnoremap <Leader>vca :lua vim.lsp.buf.code_action()<CR>
nnoremap <Leader>vsd :lua vim.lsp.util.show_line_diagnostics(); vim.lsp.util.show_line_diagnostics()<CR>

lua << EOF
    require'lspconfig'.clangd.setup{ on_attach=require'completion'.on_attach }
    require'lspconfig'.pyls.setup{ on_attach=require'completion'.on_attach }
    require'lspconfig'.sourcekit.setup{ on_attach=require'completion'.on_attach,
                \ filetypes={"swift"}
                \ }
    require'lspconfig'.jsonls.setup{ on_attach=require'completion'.on_attach}
EOF

let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
let g:vimsyn_embed = "l"
let g:completion_confirm_key = ""
let g:completion_enable_snippet = 'UltiSnips'
let g:completion_trigger_on_delete = 1

autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()
command! Format execute 'lua vim.lsp.buf.formatting()'
nnoremap <Leader>F :Format<CR>
" inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
