vim.api.nvim_set_keymap('n', '<Space>', '<NOP>', {noremap = true, silent = true})
vim.g.mapleader = ' '

-- no hl
vim.api.nvim_set_keymap('n', '<Leader>h', ':set hlsearch!<CR>', {noremap = true, silent = true})

-- explorer
vim.api.nvim_set_keymap('n', '<Leader>e', ':NvimTreeToggle<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '-', ':RnvimrToggle<CR>', {noremap = true, silent = true})

-- better window movement
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', {silent = true})
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', {silent = true})
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', {silent = true})
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', {silent = true})

-- TODO fix this
-- Terminal window navigation
vim.cmd([[
  tnoremap <C-h> <C-\><C-N><C-w>h
  tnoremap <C-j> <C-\><C-N><C-w>j
  tnoremap <C-k> <C-\><C-N><C-w>k
  tnoremap <C-l> <C-\><C-N><C-w>l
  inoremap <C-h> <C-\><C-N><C-w>h
  inoremap <C-j> <C-\><C-N><C-w>j
  inoremap <C-k> <C-\><C-N><C-w>k
  inoremap <C-l> <C-\><C-N><C-w>l
  tnoremap <Esc> <C-\><C-n>
]])

-- TODO fix this
-- resize with arrows
vim.api.nvim_set_keymap('n', '<C-Up>', ':resize -2<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<C-Down>', ':resize +2<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<C-Left>', ':vertical resize -2<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<C-Right>', ':vertical resize +2<CR>', {silent = true})

-- better indenting
vim.api.nvim_set_keymap('n', '<', '<<', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<', '<<', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '>', '>>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '>', '>>', {noremap = true, silent = true})

-- Move selected line / block of text in visual mode
vim.api.nvim_set_keymap('x', 'K', ':move \'<-2<CR>gv-gv', {noremap = true, silent = true})
vim.api.nvim_set_keymap('x', 'J', ':move \'>+1<CR>gv-gv', {noremap = true, silent = true})

-- [[Telescope]]
-- search entered word within project
vim.api.nvim_set_keymap('n', '<Leader>ps', [[<Cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>]], { noremap = true, silent = true })
-- search by selected word
vim.api.nvim_set_keymap('n', '<Leader>pw', [[<Cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.expand("<cword>") })<CR>]], { noremap = true, silent = true })
-- search by filename in git files
vim.api.nvim_set_keymap('n', '<C-p>', [[<Cmd>lua require('telescope.builtin').git_files()<CR>]], { noremap = true, silent = true })
-- buffer list window
vim.api.nvim_set_keymap('n', '<Leader>pb', [[<Cmd>lua require('telescope.builtin').buffers()<CR>]], { noremap = true, silent = true })
-- search by filename in all project files
vim.api.nvim_set_keymap('n', '<Leader>pf', [[<Cmd>lua require('telescope.builtin').find_files()<CR>]], { noremap = true, silent = true })
-- telescope through dotfiles
vim.api.nvim_set_keymap('n', '<Leader>vrc', [[<Cmd>lua require('plugins.telescope.settings').search_dotfiles()<CR>]], { noremap = true })
-- telescope help tags
vim.api.nvim_set_keymap('n', '<Leader>vh', [[<Cmd>lua require('telescope.builtin').help_tags()<CR>]], { noremap = true })

vim.api.nvim_set_keymap('v', '<Leader>p', [["_dP]], { noremap = true })

vim.api.nvim_set_keymap('n', '<Leader>y', [["+y]], { noremap = true })
vim.api.nvim_set_keymap('v', '<Leader>y', [["+y]], { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>Y', [[gg"+yG]], { noremap = true })

vim.api.nvim_set_keymap('n', '<Leader>d', [["_d]], { noremap = true })
vim.api.nvim_set_keymap('v', '<Leader>d', [["_d]], { noremap = true })

vim.api.nvim_set_keymap('', '<C-q>', ':call QuickFixToggle()<CR>', {noremap = true, silent = true})