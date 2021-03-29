-- Globals
Option.g({
	number = true,
	hidden = true,
	errorbells = false,
	hlsearch = false,

	tabstop = 4,
	softtabstop = 4,
	shiftwidth = 4,

	backup = false,
	undodir = tostring(os.getenv("HOME")) .. "/.vim/undodir",
	undofile = true,

	incsearch = true,
	termguicolors = true,
	showmode = false,

	ignorecase = true,
	smartcase = true,

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
	tabstop = 4,
	softtabstop = 4,
	shiftwidth = 4,
})
