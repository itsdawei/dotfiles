" [[ Markdown Live Preview ]]
nnoremap <Leader>mm :MarkdownPreview<CR>
let g:vim_markdown_folding_disabled=1
let g:vim_markdown_math=1
let g:markdown_fenced_languages=['swift', 'vim']

let g:mkdp_auto_close=0
let g:mkdp_filetypes = ['markdown']
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0
    \ }
