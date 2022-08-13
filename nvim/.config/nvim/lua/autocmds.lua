local M = {}

--- Set up the default set of autogroups and autocommands.
function M.setup()
	local definitions = {
		{
			"WinEnter",
			{
				group = "_lvim_user",
				pattern = "*",
				command = "set relativenumber number cursorline",
			},
		},
		{
			"WinLeave",
			{
				group = "_lvim_user",
				pattern = "*",
				command = "set norelativenumber nonumber nocursorline",
			},
		},
		{
			"TextYankPost",
			{
				group = "_general_settings",
				pattern = "*",
				desc = "Highlight text on yank",
				callback = function()
					require("vim.highlight").on_yank({ higroup = "Search", timeout = 200 })
				end,
			},
		},
		{
			"FileType",
			{
				group = "_filetype_settings",
				pattern = "qf",
				command = "set nobuflisted",
			},
		},
		{
			"FileType",
			{
				group = "_filetype_settings",
				pattern = { "gitcommit", "markdown" },
				command = "setlocal wrap spell",
			},
		},
		{
			"FileType",
			{
				group = "_buffer_mappings",
				pattern = { "qf", "help", "man", "floaterm", "lspinfo", "lsp-installer", "null-ls-info" },
				command = "nnoremap <silent> <buffer> q :close<CR>",
			},
		},
		{
			{ "BufWinEnter", "BufRead", "BufNewFile" },
			{
				group = "_format_options",
				pattern = "*",
				command = "setlocal formatoptions-=c formatoptions-=r formatoptions-=o",
			},
		},
		{
			"VimResized",
			{
				group = "_auto_resize",
				pattern = "*",
				command = "tabdo wincmd =",
			},
		},
	}

	--- Create autocommand groups based on the passed definitions
	--- Also creates the augroup automatically if it doesn't exist
	for _, entry in ipairs(definitions) do
		local event = entry[1]
		local opts = entry[2]
		if type(opts.group) == "string" and opts.group ~= "" then
			local exists, _ = pcall(vim.api.nvim_get_autocmds, { group = opts.group })
			if not exists then
				vim.api.nvim_create_augroup(opts.group, {})
			end
		end
		vim.api.nvim_create_autocmd(event, opts)
	end
end

function M.enable_transparent_mode()
	vim.api.nvim_create_autocmd("ColorScheme", {
		pattern = "*",
		callback = function()
			local hl_groups = {
				"Normal",
				"SignColumn",
				"NormalNC",
				"TelescopeBorder",
				"NvimTreeNormal",
				"EndOfBuffer",
				"MsgArea",
			}
			for _, name in ipairs(hl_groups) do
				vim.cmd(string.format("highlight %s ctermbg=none guibg=none", name))
			end
		end,
	})
	vim.opt.fillchars = "eob: "
end

--- Clean autocommand in a group if it exists
--- This is safer than trying to delete the augroup itself
---@param name string the augroup name
function M.clear_augroup(name)
	-- defer the function in case the autocommand is still in-use
	local exists, _ = pcall(vim.api.nvim_get_autocmds, { group = name })
	if not exists then
		return
	end
	vim.schedule(function()
		local status_ok, _ = xpcall(function()
			vim.api.nvim_clear_autocmds({ group = name })
		end, debug.traceback)
	end)
end

return M
