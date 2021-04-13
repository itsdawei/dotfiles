vim.api.nvim_exec(
[[
fun! GotoWindow(id)
    call win_gotoid(a:id)
    MaximizerToggle
endfun
]], true)

local opts = { noremap = true }
Keybind.g({
	{ 'n', '<Leader>mz', [[<Cmd>MaximizerToggle!<CR>]], opts },
	{ 'n', '<Leader>dd', [[:call vimspector#Launch()<CR>]], opts },
	{ 'n', '<Leader>dc', [[:call GotoWindow(g:vimspector_session_windows.code)<CR>]], opts },
	{ 'n', '<Leader>dt', [[:call GotoWindow(g:vimspector_session_windows.tagpage)<CR>]], opts },
	{ 'n', '<Leader>dv', [[:call GotoWindow(g:vimspector_session_windows.variables)<CR>]], opts },
	{ 'n', '<Leader>dw', [[:call GotoWindow(g:vimspector_session_windows.watches)<CR>]], opts },
	{ 'n', '<Leader>ds', [[:call GotoWindow(g:vimspector_session_windows.stack_trace)<CR>]], opts },
	{ 'n', '<Leader>do', [[:call GotoWindow(g:vimspector_session_windows.output)<CR>]], opts },
	{ 'n', '<Leader>de', [[:call vimspector#Reset()<CR>]], opts },

	{ 'n', '<Leader>dtcb', [[:call vimspector#CleanLineBreakPoint()<CR>]], opts },

	{ 'n', '<Leader>drc', [[<Plug>VimspectorRunToCursor]],},
	{ 'n', '<Leader>dbp', [[<Plug>VimspectorToggleBreakpoint]],},
	{ 'n', '<Leader>dcbp', [[<Plug>VimspectorToggleConditionalBreakpoint]],},
})

Variable.g({
    maximizer_set_default_mapping = 0,
    maximizer_restore_on_winleave = 1,
})
