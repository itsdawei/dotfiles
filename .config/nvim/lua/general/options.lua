-- Globals
Option.g({
	number = true,
	hlsearch = false,
	hidden = true,
	errorbells = false,

	tabstop = 2,
	softtabstop = 2,
	shiftwidth = 2,

	backup = false,
	undodir = tostring(os.getenv("HOME")) .. "/.vim/undodir",
	undofile = true,

	incsearch = true,
	termguicolors = true,
	showmode = false,

	smartcase = true,
	ignorecase = true,

	splitright = true,
	splitbelow = true,

	cmdheight = 1,
	updatetime = 50,
	shortmess = vim.o.shortmess .. 'c',

	mouse = 'a',

	completeopt = 'menuone,noinsert,noselect',
})


Option.w({
	number = true,
	relativenumber = true,
	signcolumn = 'yes',
	scrolloff = 8,
	wrap = false,
	colorcolumn = "80",
})

Option.b({
	expandtab = true,
	smartindent = true,
	swapfile = false,
})
