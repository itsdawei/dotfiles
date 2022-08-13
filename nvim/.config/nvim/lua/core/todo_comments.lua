local M = {}

function M.setup()
	local status_ok, todo = pcall(require, "todo-comments")
	if not status_ok then
		return
	end

	todo.setup({
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
	})
end

return M
