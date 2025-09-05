local M = {}

function M.setup()
	local status_cmp_ok, cmp = pcall(require, "cmp")
	if not status_cmp_ok then
		return
	end

	local status_luasnip_ok, luasnip = pcall(require, "luasnip")
	if not status_luasnip_ok then
		return
	end

	require("luasnip.loaders.from_snipmate").lazy_load()

	cmp.setup({
		completion = {
			completeopt = "menu,menuone,preview,noselect",
		},
		experimental = {
			ghost_text = false,
			native_menu = false,
			custom_menu = true,
		},
		snippet = {
			expand = function(args)
				luasnip.lsp_extend(args.body)
			end,
		},
		mapping = cmp.mapping.preset.insert({
			["<C-k>"] = cmp.mapping.select_prev_item(),
			["<C-j>"] = cmp.mapping.select_next_item(),
			["<C-d>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-Space>"] = cmp.mapping.complete(),
			["<C-e>"] = cmp.mapping.abort(),
			["<CR>"] = cmp.mapping.confirm({ select = false }),
		}),
		sources = {
      { name = "nvim_lsp", max_item_count = 5 },
			{ name = "luasnip", max_item_count = 3 },
			{ name = "buffer", max_item_count = 5, keyword_length = 4 },
			{ name = "path", max_item_count = 5 },
			{ name = "nvim_lua" },
			{ name = "calc" },
			{ name = "emoji" },
			{ name = "treesitter" },
			{ name = "tmux" },
			{ name = "latex_symbols" },
		},
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
