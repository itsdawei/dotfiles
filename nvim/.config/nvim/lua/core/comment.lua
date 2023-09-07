return {
	setup = function()
		require("Comment").setup({
			-- Ignore empty lines
			ignore = "^$",
			-- LHS of toggle mappings in NORMAL mode
			toggler = {
				-- line-comment toggle
				line = "gcc",
				-- block-comment toggle
				block = "gbc",
			},
			-- LHS of operator-pending mappings in NORMAL and VISUAL mode
			opleader = {
				-- line-comment opfunc mapping
				line = "gc",
				-- block-comment opfunc mapping
				block = "gb",
			},
			-- Enable keybindings
			mappings = {
				-- Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
				basic = true,
				-- Extra mapping; `gco`, `gcO`, `gcA`
				extra = true,
			},

			-- Pre-hook, called before commenting the line
			pre_hook = function(_)
				return require("ts_context_commentstring.internal").calculate_commentstring()
			end,

			-- Post-hook, called after commenting is done
			-- @type function|nil
			post_hook = nil,
		})
	end,
}
