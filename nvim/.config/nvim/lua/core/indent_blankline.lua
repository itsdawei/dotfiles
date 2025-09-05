local M = {}

M.setup = function()
	local status_ok, ibl = pcall(require, "ibl")
	if not status_ok then
		return
	end
	ibl.setup({
		indent = {
			char = { "", "┊", "┆", "¦", "|", "¦", "┆", "┊", "" },
		},
		exclude = {
			buftypes = { "terminal", "nofile" },
			filetypes = {
				"alpha",
				"log",
				"gitcommit",
				"dapui_scopes",
				"dapui_stacks",
				"dapui_watches",
				"dapui_breakpoints",
				"dapui_hover",
				"LuaTree",
				"dbui",
				"UltestSummary",
				"UltestOutput",
				"vimwiki",
				"markdown",
				"json",
				"txt",
				"vista",
				"NvimTree",
				"git",
				"TelescopePrompt",
				"undotree",
				"flutterToolsOutline",
				"help",
				"startify",
				"dashboard",
				"lazy",
				"neogitstatus",
				"Outline",
				"Trouble",
				"lspinfo",
				"", -- for all buffers without a file type
			},
		},
		scope = {
			enabled = true,
			show_start = false,
		},
	})
	local hooks = require("ibl.hooks")
	hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_tab_indent_level)
end

return M
