vim.cmd('set iskeyword+=-') -- treat dash separated words as a word text object"
vim.cmd('set inccommand=split') -- Make substitution work in realtime

vim.o.path = vim.o.path .. '**'
vim.o.wildmode = 'longest,list,full'
vim.o.wildmenu = true
vim.o.wildignore = vim.o.wildignore .. '**/.git/*' .. '**/node_modules/*'

vim.o.number = true
vim.o.hidden = true
vim.o.errorbells = false
vim.o.hlsearch = false

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

vim.o.backup = false
vim.o.undodir = tostring(os.getenv("HOME")) .. '/.vim/undodir'
vim.bo.undofile = true

vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.termguicolors = true
vim.o.showmode = false

vim.o.splitbelow = true
vim.o.splitright = true

vim.o.cmdheight = 1
vim.o.updatetime = 50
vim.o.shortmess = vim.o.shortmess .. 'c'

vim.o.mouse = 'a'

vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.signcolumn = "yes"
vim.wo.scrolloff = 8
vim.wo.wrap = false
vim.wo.colorcolumn = '80'

vim.cmd('set expandtab')
vim.bo.smartindent = true
vim.bo.swapfile = false
vim.bo.tabstop = 4
vim.bo.softtabstop = 4
vim.bo.shiftwidth = 4

vim.cmd('set whichwrap+=<,>,[,],h,l')
vim.o.pumheight = 10
vim.o.fileencoding = "utf-8"
vim.o.conceallevel = 0
vim.wo.cursorline = true
vim.o.timeoutlen = 100
vim.o.clipboard = "unnamedplus"
