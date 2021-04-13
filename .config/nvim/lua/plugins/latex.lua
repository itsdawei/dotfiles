Keybind.g({
    -- { 'n', '<leader>ll', [[<Cmd>LLPStartPreview<CR>]], { noremap = true } }
    {'n', '<leader>ll', [[<plug>(vimtex-compile)]], {noremap = true}}
})

Variable.g({
        -- livepreview_previewer='open -a Skim',
        tex_flavor='latex',
        vimtex_view_method='Skim',
        vimtex_quickfix_mode=0,
        tex_conceal='abdmg',
})

Option.g({
    conceallevel=1,
})

