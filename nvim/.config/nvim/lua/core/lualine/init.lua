local M = {}
local colors = require("core.lualine.colors")

local window_width_limit = 70

local hide_in_width = function()
	return vim.fn.winwidth(0) > window_width_limit
end

local function diff_source()
	local gitsigns = vim.b.gitsigns_status_dict
	if gitsigns then
		return {
			added = gitsigns.added,
			modified = gitsigns.changed,
			removed = gitsigns.removed,
		}
	end
end

local function env_cleanup(venv)
	if string.find(venv, "/") then
		local final_venv = venv
		for w in venv:gmatch("([^/]+)") do
			final_venv = w
		end
		venv = final_venv
	end
	return venv
end

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
			{
				function()
					return " "
				end,
				padding = { left = 0, right = 0 },
				color = {},
				cond = nil,
			},
		},
		lualine_b = {
			{
				"b:gitsigns_head",
				icon = " ",
				color = { gui = "bold" },
				cond = hide_in_width,
			},
			{
				"filename",
				path = 1,
				color = {},
				cond = nil,
			},
		},
		lualine_c = {
			{
				"diff",
				source = diff_source,
				symbols = { added = "  ", modified = " ", removed = " " },
				diff_color = {
					added = { fg = colors.green },
					modified = { fg = colors.yellow },
					removed = { fg = colors.red },
				},
				cond = nil,
			},
			{
				function()
					if vim.bo.filetype == "python" then
						local venv = os.getenv("CONDA_DEFAULT_ENV")
						if venv then
							-- return string.format("  (%s)", env_cleanup(venv))
							return string.format("(%s)", env_cleanup(venv))
						end
						return ""
					end
					return ""
				end,
				color = { fg = colors.green },
				cond = hide_in_width,
			},
		},
		lualine_x = {
			{
				"diagnostics",
				sources = { "nvim_diagnostic" },
				symbols = { error = " ", warn = " ", info = " ", hint = " " },
				cond = hide_in_width,
			},
			{
				function()
					local b = vim.api.nvim_get_current_buf()
					if next(vim.treesitter.highlighter.active[b]) then
						return ""
					end
					return ""
				end,
				color = { fg = colors.green },
				cond = hide_in_width,
			},
			{
				function(msg)
					msg = msg or "LS Inactive"
					local buf_clients = vim.lsp.get_clients()
					if next(buf_clients) == nil then
						-- TODO: clean up this if statement
						if type(msg) == "boolean" or #msg == 0 then
							return "LS Inactive"
						end
						return msg
					end
					local buf_ft = vim.bo.filetype
					local buf_client_names = {}

					-- add client
					for _, client in pairs(buf_clients) do
						if client.name ~= "null-ls" then
							table.insert(buf_client_names, client.name)
						end
					end

					-- add formatter
					local formatters = require("lvim.lsp.null-ls.formatters")
					local supported_formatters = formatters.list_registered(buf_ft)
					vim.list_extend(buf_client_names, supported_formatters)

					-- add linter
					local linters = require("lvim.lsp.null-ls.linters")
					local supported_linters = linters.list_registered(buf_ft)
					vim.list_extend(buf_client_names, supported_linters)

					local unique_client_names = vim.fn.uniq(buf_client_names)
					return "[" .. table.concat(unique_client_names, ", ") .. "]"
				end,
				color = { gui = "bold" },
				cond = hide_in_width,
			},
			{ "filetype", cond = hide_in_width },
			{ "location" },
		},
		lualine_y = {},
		lualine_z = {},
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
