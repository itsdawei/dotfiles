fun! ColorMyPencils()
    colorscheme gruvbox
    set background=dark

    let g:gruvbox_contrast_dark = 'hard'
    let g:gruvbox_invert_selection='0'

    highlight ColorColumn ctermbg=0 guibg=grey
    highlight Normal guibg=none
    highlight LineNr guifg=#5eacd3
    highlight netrwDir guifg=#5eacd3
    highlight qfFileName guifg=#aed75f
endfun
call ColorMyPencils()

" Vim with me
nnoremap <leader>vwm :call ColorMyPencils()<CR>

