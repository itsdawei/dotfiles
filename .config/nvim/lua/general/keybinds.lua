Keybind.g({
    -- reload nvim configuration file
    { 'n', '<Leader><CR>', ':luafile $MYVIMRC<CR>' },

    -- Navigation
    { 'n', '<Leader>h', '<Cmd>wincmd h<CR>', { noremap = true } },
    { 'n', '<Leader>j', '<Cmd>wincmd j<CR>', { noremap = true } },
    { 'n', '<Leader>k', '<Cmd>wincmd k<CR>', { noremap = true } },
    { 'n', '<Leader>l', '<Cmd>wincmd l<CR>', { noremap = true } },

    -- what in the hell ?????  (╯°□°）╯︵ ┻━┻
    -- delete without registering word
    { 'v', 'X', '"_d', { noremap = true } },

    -- delete&local-paste without registering
    { 'v', '<Leader>p', '"_dP', { noremap = true } },

    -- yank it to global register
    { 'n', '<Leader>y', '"+y', { noremap = true } },
    { 'v', '<Leader>y', '"+y', { noremap = true } },

    -- ????????
    { 'n', '<Leader>d', '"_d', { noremap = true } },
    { 'v', '<Leader>d', '"_d', { noremap = true } },

    -- yank all the content of file to global register ?? (╯°□°）╯︵ ┻━┻
    { 'n', '<Leader>Y', 'gg"+yG', { noremap = true } },

    -- resize window
    { 'n', '<Leader>+', '<Cmd>vertical resize +5<CR>', { noremap = true } },
    { 'n', '<Leader>-', '<Cmd>vertical resize -5<CR>', { noremap = true } },
    { 'n', '<Leader>rp', '<Cmd>resize 100<CR>', { noremap = true } },

    -- move selected line to up/down
    { 'v', 'J', '<Cmd>m \'>+1<CR>gv=gv', { noremap = true } },
    { 'v', 'K', '<Cmd>m \'<-2<CR>gv=gv', { noremap = true } },

    -- shorcut for indent
    { 'n', '>', '>>', { noremap = true } },
    { 'n', '<', '<<', { noremap = true } },
})

Keybind.g({
    -- open neovim terminal
    { 'n', '<c-n>', '<Cmd>call OpenTerminal()<CR>', { noremap = true } },
})

Keybind.g({
    -- ctrl-c
    { 'i', '<C-c>', '<esc>', { noremap = true } },
    -- Vim with me!! (customize theme with shortcut)
    { 'n', '<Leader>vwm', '<Cmd>call ColorMyPencils()<CR>', { noremap = true } },
})
