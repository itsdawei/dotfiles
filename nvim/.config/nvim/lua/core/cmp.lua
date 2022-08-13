-- TODO understand how this code works (and simplify it)
local M = {}
M.methods = {}

---when inside a snippet, seeks to the nearest luasnip field if possible, and checks if it is jumpable
---@param dir number 1 for forward, -1 for backward; defaults to 1
---@return boolean true if a jumpable luasnip field is found while inside a snippet
local function jumpable(dir)
	local luasnip_ok, luasnip = pcall(require, "luasnip")
	if not luasnip_ok then
		return
	end

	local win_get_cursor = vim.api.nvim_win_get_cursor
	local get_current_buf = vim.api.nvim_get_current_buf

	local function inside_snippet()
		-- for outdated versions of luasnip
		if not luasnip.session.current_nodes then
			return false
		end

		local node = luasnip.session.current_nodes[get_current_buf()]
		if not node then
			return false
		end

		local snip_begin_pos, snip_end_pos = node.parent.snippet.mark:pos_begin_end()
		local pos = win_get_cursor(0)
		pos[1] = pos[1] - 1 -- LuaSnip is 0-based not 1-based like nvim for rows
		return pos[1] >= snip_begin_pos[1] and pos[1] <= snip_end_pos[1]
	end

	---sets the current buffer's luasnip to the one nearest the cursor
	---@return boolean true if a node is found, false otherwise
	local function seek_luasnip_cursor_node()
		-- for outdated versions of luasnip
		if not luasnip.session.current_nodes then
			return false
		end

		local pos = win_get_cursor(0)
		pos[1] = pos[1] - 1
		local node = luasnip.session.current_nodes[get_current_buf()]
		if not node then
			return false
		end

		local snippet = node.parent.snippet
		local exit_node = snippet.insert_nodes[0]

		-- exit early if we're past the exit node
		if exit_node then
			local exit_pos_end = exit_node.mark:pos_end()
			if (pos[1] > exit_pos_end[1]) or (pos[1] == exit_pos_end[1] and pos[2] > exit_pos_end[2]) then
				snippet:remove_from_jumplist()
				luasnip.session.current_nodes[get_current_buf()] = nil

				return false
			end
		end

		node = snippet.inner_first:jump_into(1, true)
		while node ~= nil and node.next ~= nil and node ~= snippet do
			local n_next = node.next
			local next_pos = n_next and n_next.mark:pos_begin()
			local candidate = n_next ~= snippet and next_pos and (pos[1] < next_pos[1])
				or (pos[1] == next_pos[1] and pos[2] < next_pos[2])

			-- Past unmarked exit node, exit early
			if n_next == nil or n_next == snippet.next then
				snippet:remove_from_jumplist()
				luasnip.session.current_nodes[get_current_buf()] = nil

				return false
			end

			if candidate then
				luasnip.session.current_nodes[get_current_buf()] = node
				return true
			end

			local ok
			ok, node = pcall(node.jump_from, node, 1, true) -- no_move until last stop
			if not ok then
				snippet:remove_from_jumplist()
				luasnip.session.current_nodes[get_current_buf()] = nil

				return false
			end
		end

		-- No candidate, but have an exit node
		if exit_node then
			-- to jump to the exit node, seek to snippet
			luasnip.session.current_nodes[get_current_buf()] = snippet
			return true
		end

		-- No exit node, exit from snippet
		snippet:remove_from_jumplist()
		luasnip.session.current_nodes[get_current_buf()] = nil
		return false
	end

	if dir == -1 then
		return inside_snippet() and luasnip.jumpable(-1)
	else
		return inside_snippet() and seek_luasnip_cursor_node() and luasnip.jumpable()
	end
end

M.methods.jumpable = jumpable

function M.setup()
	-- ensure that cmp and luasnip has been installed
	local status_cmp_ok, cmp = pcall(require, "cmp")
	if not status_cmp_ok then
		return
	end
	local status_luasnip_ok, luasnip = pcall(require, "luasnip")
	if not status_luasnip_ok then
		return
	end

	cmp.setup({
		completion = {
			---@usage The minimum length of a word to complete on.
			keyword_length = 1,
		},
		experimental = {
			ghost_text = false,
			native_menu = false,
			custom_menu = true,
		},
		formatting = {
			fields = { "kind", "abbr", "menu" },
			format = require("lspkind").cmp_format({
				mode = "symbol", -- show only symbol annotations
				maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

				-- The function below will be called before any actual modifications from lspkind
				-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
				before = function(entry, vim_item)
					local cmp_sources = {
						["vim-dadbod-completion"] = "(DadBod)",
						buffer = "(Buffer)",
						cmp_tabnine = "(TabNine)",
						latex_symbols = "(LaTeX)",
						nvim_lua = "(NvLua)",
					}
					if entry.source.name == "cmdline" then
						vim_item.kind = "⌘"
						vim_item.menu = ""
						return vim_item
					end
					vim_item.menu = cmp_sources[entry.source.name] or vim_item.kind

					return vim_item
				end,
			}),
			-- 	format = function(entry, vim_item)
			-- 		local max_width = 0
			-- 		if max_width ~= 0 and #vim_item.abbr > max_width then
			-- 			vim_item.abbr = string.sub(vim_item.abbr, 1, max_width - 1) .. "…"
			-- 		end
			-- 		local kind_icons = {
			-- 			Class = " ",
			-- 			Color = " ",
			-- 			Constant = "ﲀ ",
			-- 			Constructor = " ",
			-- 			Enum = "練",
			-- 			EnumMember = " ",
			-- 			Event = " ",
			-- 			Field = " ",
			-- 			File = "",
			-- 			Folder = " ",
			-- 			Function = " ",
			-- 			Interface = "ﰮ ",
			-- 			Keyword = " ",
			-- 			Method = " ",
			-- 			Module = " ",
			-- 			Operator = "",
			-- 			Property = " ",
			-- 			Reference = " ",
			-- 			Snippet = " ",
			-- 			Struct = " ",
			-- 			Text = " ",
			-- 			TypeParameter = " ",
			-- 			Unit = "塞",
			-- 			Value = " ",
			-- 			Variable = " ",
			-- 		}
			-- 		local source_names = {
			-- 			nvim_lsp = "(LSP)",
			-- 			emoji = "(Emoji)",
			-- 			path = "(Path)",
			-- 			calc = "(Calc)",
			-- 			cmp_tabnine = "(Tabnine)",
			-- 			vsnip = "(Snippet)",
			-- 			luasnip = "(Snippet)",
			-- 			buffer = "(Buffer)",
			-- 			tmux = "(TMUX)",
			-- 		}
			-- 		local duplicates = {
			-- 			buffer = 1,
			-- 			path = 1,
			-- 			nvim_lsp = 0,
			-- 			luasnip = 1,
			-- 		}
			-- 		vim_item.kind = kind_icons[vim_item.kind]
			-- 		vim_item.menu = source_names[entry.source.name]
			-- 		vim_item.dup = duplicates[entry.source.name]
			-- 		return vim_item
			-- 	end,
		},
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},
		window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		},
		sources = {
			{ name = "nvim_lsp" },
			{ name = "path", max_item_count = 5 },
			{ name = "luasnip", max_item_count = 3 },
			{ name = "cmp_tabnine", max_item_count = 3 },
			{ name = "nvim_lua" },
			{ name = "buffer", max_item_count = 5, keyword_length = 5 },
			{ name = "calc" },
			{ name = "emoji" },
			{ name = "treesitter" },
			{ name = "crates" },
			{ name = "tmux" },
			{ name = "latex_symbols" },
		},
		mapping = cmp.mapping.preset.insert({
			["<C-k>"] = cmp.mapping.select_prev_item(),
			["<C-j>"] = cmp.mapping.select_next_item(),
			["<C-d>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.expandable() then
					luasnip.expand()
				elseif jumpable() then
					luasnip.jump(1)
				else
					fallback()
				end
			end, {
				"i",
				"s",
			}),
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, {
				"i",
				"s",
			}),

			["<C-Space>"] = cmp.mapping.complete(),
			["<C-e>"] = cmp.mapping.abort(),
			["<CR>"] = cmp.mapping(function(fallback)
				local confirm_opts = {
					behavior = cmp.ConfirmBehavior.Replace,
					select = false,
				}
				if cmp.visible() and cmp.confirm(confirm_opts) then
					if jumpable(1) then
						luasnip.jump(1)
					end
					return
				end

				if jumpable(1) then
					if not luasnip.jump(1) then
						fallback()
					end
				else
					fallback()
				end
			end),
		}),
	})

	cmp.setup.cmdline(":", {
		mapping = cmp.mapping.preset.cmdline({}),
		sources = {
			{ name = "cmdline" },
			{ name = "path" },
		},
	})

	cmp.setup.filetype("tex", {
		sources = cmp.config.sources({
			{ name = "latex_symbols", max_item_count = 3, keyword_length = 3 },
			{ name = "nvim_lsp", max_item_count = 8 },
			{ name = "luasnip", max_item_count = 5 },
		}, {
			{ name = "buffer", max_item_count = 5, keyword_length = 5 },
		}),
	})
end

return M
