" [[ Latex Live-Preview ]]
let g:livepreview_previewer='open -a Skim'
let g:livepreview_engine='xelatex'
let g:tex_flavor='latex'
"let g:tex_conceal='abdmg'
let g:tex_conceal=""
let g:tex_conceal_frac=1
autocmd Filetype tex setl updatetime=400
