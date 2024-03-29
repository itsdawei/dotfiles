local M = {}

function M.setup()
	local status_ok, bqf = pcall(require, "bqf")
	if not status_ok then
		return
	end

	bqf.setup({
		auto_resize_height = true,
		func_map = {
			tab = "st",
			split = "sv",
			vsplit = "sg",

			stoggleup = "K",
			stoggledown = "J",
			stogglevm = "<Space>",

			ptoggleitem = "p",
			ptoggleauto = "P",
			ptogglemode = "zp",

			pscrollup = "<C-b>",
			pscrolldown = "<C-f>",

			prevfile = "gk",
			nextfile = "gj",

			prevhist = "<S-Tab>",
			nexthist = "<Tab>",
		},
		preview = {
			auto_preview = true,
			should_preview_cb = function(bufnr)
				local ret = true
				local filename = vim.api.nvim_buf_get_name(bufnr)
				local fsize = vim.fn.getfsize(filename)
				-- file size greater than 10k can't be previewed automatically
				if fsize > 100 * 1024 then
					ret = false
				end
				return ret
			end,
		},
	})
end

return M
