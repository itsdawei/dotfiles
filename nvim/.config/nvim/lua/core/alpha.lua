local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

local M = {}

local function configure_additional_autocmds()
	local group = "_dashboard_settings"
	vim.api.nvim_create_augroup(group, {})
	vim.api.nvim_create_autocmd("FileType", {
		group = group,
		pattern = "alpha",
		command = "set showtabline=0 | autocmd BufLeave <buffer> set showtabline=" .. vim.opt.showtabline._value,
	})
	-- https://github.com/goolord/alpha-nvim/issues/42
	vim.api.nvim_create_autocmd("FileType", {
		group = group,
		pattern = "alpha",
		command = "set laststatus=0 | autocmd BufUnload <buffer> set laststatus=" .. vim.opt.laststatus._value,
	})
end

local function footer()
	local datetime = os.date(" %d-%m-%Y   %H:%M:%S")
	local version = vim.version()
	local nvim_version_info = "   v" .. version.major .. "." .. version.minor .. "." .. version.patch

	return datetime .. nvim_version_info
end

function M.setup()
	dashboard.section.buttons.val = {
		dashboard.button("<leader>r", "  Recent", ":Telescope oldfiles<CR>"),
		dashboard.button("<leader>n", "  Neu", ":ene <BAR> startinsert <CR>"),
		dashboard.button("<leader>f", "  Find Local", ":Telescope find_files cwd=.<CR>"),
		dashboard.button("<leader>g", "  Find Global", ":Telescope find_files cwd=~<CR>"),
		dashboard.button("<leader>p", "  Find Development", ":Telescope find_files search_dirs=['~/dev']<CR>"),
		dashboard.button("<leader>p", "  Configurations", ":Telescope find_files cwd=~/.config/nvim/<CR>"),
	}

	dashboard.section.footer.val = footer()
	dashboard.section.footer.opts.hl = "Constant"

	alpha.setup(dashboard.opts)
	configure_additional_autocmds()
end

return M
