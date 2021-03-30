vim.api.nvim_exec([[
	hi FloatermBorder guibg=black guifg=orange
]], true)

Variable.g({
    floaterm_title = '',
    floaterm_shell = "fish",

    floaterm_keymap_toggle = '<F1>',
    floaterm_keymap_next = '<F2>',
    floaterm_keymap_prev = '<F3>',
    floaterm_keymap_new = '<F4>',

    floaterm_gitcommit = 'floaterm',
    floaterm_autoinsert = 1,
    floaterm_width = 0.8,
    floaterm_height = 0.8,
    floaterm_wintitle = 0,
    floaterm_autoclose = 1
})
