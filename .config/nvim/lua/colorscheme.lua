vim.cmd('let g:nvcode_termcolors=256')

vim.cmd('colorscheme ' .. O.colorscheme)

vim.cmd[[
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
]]
