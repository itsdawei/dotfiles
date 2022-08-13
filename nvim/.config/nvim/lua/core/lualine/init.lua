local M = {}
local components = require("core.lualine.components")

local lualine_style = {
	options = {
		theme = "auto",
		icons_enabled = true,
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "alpha", "NvimTree", "Outline" },
	},
	sections = {
		lualine_a = {
			components.mode,
		},
		lualine_b = {
			components.branch,
			components.filename,
		},
		lualine_c = {
			components.diff,
			components.python_env,
		},
		lualine_x = {
			components.diagnostics,
			components.treesitter,
			components.lsp,
			components.filetype,
		},
		lualine_y = {
		},
		lualine_z = {
			components.scrollbar,
		},
	},
	inactive_sections = {
		lualine_a = {
			"filename",
		},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = { "nvim-tree" },
}

M.setup = function()
	-- avoid running in headless mode since it's harder to detect failures
	if #vim.api.nvim_list_uis() == 0 then
		return
	end
	require("lualine").setup(lualine_style)
end

return M
