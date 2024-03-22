local M = {}

M.autopairs_configs = {
	---@usage  modifies the function or method delimiter by filetypes
	map_char = {
		all = "(",
		tex = "{",
	},
	---@usage check bracket in same line
	enable_check_bracket_line = false,
	check_ts = true,
	ts_config = {
		java = false,
	},
	disable_filetype = { "TelescopePrompt", "spectre_panel", "tex" },
	ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]], "%s+", ""),
	map_bs = true,
	---@usage  change default fast_wrap
	fast_wrap = {
		map = "<M-e>",
		chars = { "{", "[", "(", '"', "'" },
		pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
		offset = 0,
		end_key = "$",
		keys = "qwertyuiopzxcvbnmasdfghjkl",
		check_comma = true,
		highlight = "PmenuSel",
		highlight_grey = "LineNr",
	},
}

M.setup = function()
	local autopairs = require("nvim-autopairs")
	local rule = require("nvim-autopairs.rule")

	autopairs.setup(M.autopairs_configs)

	require("nvim-treesitter.configs").setup({ autopairs = { enable = true } })

	local ts_conds = require("nvim-autopairs.ts-conds")

	autopairs.add_rules({
		-- press % => %% is only inside comment or string
		rule("%", "%", "lua"):with_pair(ts_conds.is_ts_node({ "string", "comment" })),
		rule("$", "$", "lua"):with_pair(ts_conds.is_not_ts_node({ "function" })),
	})
	local cmp_autopairs = require("nvim-autopairs.completion.cmp")
	local cmp = require("cmp")
	cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

return M
