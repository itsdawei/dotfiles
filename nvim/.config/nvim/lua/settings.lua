local M = {}

function M.setup()
	local default_options = {
		backup = false, -- creates a backup file
		clipboard = "unnamedplus", -- allows neovim to access the system clipboard
		cmdheight = 1, -- more space in the neovim command line for displaying messages
		colorcolumn = "99999", -- fixes indentline for now
		completeopt = { "menu", "menuone", "noselect" },
		conceallevel = 0, -- so that `` is visible in markdown files
		fileencoding = "utf-8", -- the encoding written to a file
		foldmethod = "manual", -- folding, set to "expr" for treesitter based folding
		foldexpr = " ", -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
		guifont = "monospace:h17", -- the font used in graphical neovim applications
		hidden = true, -- required to keep multiple buffers and open multiple buffers
		hlsearch = true, -- highlight all matches on previous search pattern
		ignorecase = true, -- ignore case in search patterns
		mouse = "a", -- allow the mouse to be used in neovim
		pumheight = 10, -- pop up menu height
		pumblend = 10,
		showmode = false, -- we don't need to see things like -- INSERT -- anymore
		showtabline = 2, -- always show tabs
		smartcase = true, -- smart case
		smartindent = true, -- make indenting smarter again
		splitbelow = true, -- force all horizontal splits to go below current window
		splitright = true, -- force all vertical splits to go to the right of current window
		swapfile = false, -- don't use swapfiles
		termguicolors = true, -- set term gui colors (most terminals support this)
		timeoutlen = 250, -- time to wait for a mapped sequence to complete (in milliseconds)
		title = true, -- set the title of window to the value of the titlestring
		-- opt.titlestring = "%<%F%=%l/%L - nvim" -- what the title of the window will be set to
		-- undodir = undodir, -- set an undo directory
		undofile = true, -- enable persistent undo
		updatetime = 300, -- faster completion
		writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
		expandtab = true, -- convert tabs to spaces
		shiftwidth = 2, -- the number of spaces inserted for each indentation
		tabstop = 2, -- insert 2 spaces for a tab
		cursorline = true, -- highlight the current line
		number = true, -- set numbered lines
		relativenumber = true, -- set relative numbered lines
		numberwidth = 2, -- set number column width to 2 {default 4}
		signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
		wrap = false, -- display lines as one long line
		scrolloff = 8, -- minimal number of screen lines to keep above and below the cursor.
		sidescrolloff = 8, -- minimal number of screen lines to keep left and right of the cursor.
		diffopt = { "internal", "filler", "closeoff", "hiddenoff", "algorithm:minimal" },
		redrawtime = 1500,
		wrapscan = true,
		confirm = true, -- make vim prompt me to save before doing destructive things
		autowriteall = true, -- automatically :write before running commands and changing files
		fillchars = {
			vert = "▕", -- alternatives │
			fold = " ",
			eob = " ", -- suppress ~ at EndOfBuffer
			diff = "╱", -- alternatives = ⣿ ░ ─
			msgsep = "‾",
			foldopen = "▾",
			foldsep = "│",
			foldclose = "▸",
		},
	}

	vim.wo.foldmethod = "expr"
	vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
	vim.wo.foldlevel = 4
	vim.wo.foldtext =
		[[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]
	vim.wo.foldnestmax = 3
	vim.wo.foldminlines = 1

	---  SETTINGS  ---
	vim.opt.shortmess = {
		t = true, -- truncate file messages at start
		A = true, -- ignore annoying swap file messages
		o = true, -- file-read message overwrites previous
		O = true, -- file-read message overwrites previous
		T = true, -- truncate non-file messages in middle
		f = true, -- (file x of x) instead of just (x of x
		F = true, -- Don't give file info when editing a file, NOTE: this breaks autocommand messages
		s = true,
		c = true,
		W = true, -- Don't show [w] or written when writing
	}
	vim.opt.whichwrap:append("<,>,[,],h,l")
	vim.opt.wildignore = {
		"*.aux,*.out,*.toc",
		"*.o,*.obj,*.dll,*.jar,*.pyc,__pycache__,*.rbc,*.class",
		-- media
		"*.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp",
		"*.avi,*.m4a,*.mp3,*.oga,*.ogg,*.wav,*.webm",
		"*.eot,*.otf,*.ttf,*.woff",
		"*.doc,*.pdf",
		-- archives
		"*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz",
		-- temp/system
		"*.*~,*~ ",
		"*.swp,.lock,.DS_Store,._*,tags.lock",
		-- version control
		".git,.svn",
	}
	vim.opt.formatoptions = {
		["1"] = true,
		["2"] = true, -- Use indent from 2nd line of a paragraph
		q = true, -- continue comments with gq"
		c = true, -- Auto-wrap comments using textwidth
		r = true, -- Continue comments when pressing Enter
		n = true, -- Recognize numbered lists
		t = false, -- autowrap lines using text width value
		j = true, -- remove a comment leader when joining lines.
		-- Only break if the line was not longer than 'textwidth' when the insert
		-- started and only at a white character that has been entered during the
		-- current insert command.
		l = true,
		v = true,
	}
	vim.opt.listchars = {
		eol = nil,
		tab = "│ ",
		extends = "›", -- Alternatives: … »
		precedes = "‹", -- Alternatives: … «
		trail = "•", -- BULLET (U+2022, UTF-8: E2 80 A2)
	}

	for k, v in pairs(default_options) do
		vim.opt[k] = v
	end

	--- DISABLED PLUGINS ---
	local disabled_plugins = {
		"2html_plugin",
		"getscript",
		"getscriptPlugin",
		"gzip",
		"logipat",
		-- "netrw",
		"netrwPlugin",
		"netrwSettings",
		"netrwFileHandlers",
		"matchit",
		"tar",
		"tarPlugin",
		"rrhelper",
		"spellfile_plugin",
		"vimball",
		"vimballPlugin",
		"zip",
		"zipPlugin",
	}
	for _, plugin in pairs(disabled_plugins) do
		vim.g["loaded_" .. plugin] = 1
	end

	--- FILETYPE ---
	vim.filetype.add({
		extension = {
			fnl = "fennel",
			wiki = "markdown",
		},
		filename = {
			["go.sum"] = "gosum",
			["go.mod"] = "gomod",
		},
		pattern = {
			["*.tml"] = "gohtmltmpl",
			["%.env.*"] = "sh",
		},
	})
end

return M
