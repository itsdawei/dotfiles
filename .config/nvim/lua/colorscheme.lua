vim.api.nvim_exec([[
    fun! ColorMyPencils()
        let g:gruvbox_contrast_dark = 'hard'
        if exists('+termguicolors')
            let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
            let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
        endif
        let g:gruvbox_invert_selection='0'

        set background=dark
        hi ColorColumn ctermbg=0 guibg=grey
        hi SignColumn guibg=none
        hi CursorLineNR guibg=None
        hi Normal guibg=none
        " highlight LineNr guifg=#ff8659
        " highlight LineNr guifg=#aed75f
        hi LineNr guifg=#5eacd3
        hi netrwDir guifg=#5eacd3
        hi qfFileName guifg=#aed75f
        hi TelescopeBorder guifg=#5eacd
    endfun
]], false)

vim.api.nvim_exec('autocmd ColorScheme * call ColorMyPencils()', false)

vim.cmd('colorscheme ' .. O.colorscheme)
