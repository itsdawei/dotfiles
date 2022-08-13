local M = {}

function M.setup()
	local status_ok, neoclip = pcall(require, "neoclip")
	if not status_ok then
		return
	end

	neoclip.setup({
		history = 50,
		enable_persistent_history = true,
	})

	local function clip()
		local opts = {
			winblend = 10,
			layout_strategy = "flex",
			layout_config = {
				prompt_position = "top",
				width = 0.8,
				height = 0.6,
				horizontal = { width = { padding = 0.15 } },
				vertical = { preview_height = 0.70 },
			},
			borderchars = {
				prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
				results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
				preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
			},
			border = {},
			shorten_path = false,
		}
		local dropdown = require("telescope.themes").get_dropdown(opts)
		require("telescope").extensions.neoclip.default(dropdown)
	end

	local wk_status, wk = pcall(require, "which-key")
	if not wk_status then
		return
	end
	wk.register({ ["<leader>y"] = { clip, "Yank History" } })
end

return M
