-- TODO:
-- HACK:
-- WARN:
-- PERF:
-- TEST:

return {
	setup = function()
		local status_ok, todo = pcall(require, "todo-comments")
		if not status_ok then
			return
		end

		todo.setup({
			keywords = {
				FIX = {
					icon = " ",
					color = "error",
					alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
					-- signs = false, -- configure signs for some keywords individually
				},
				TODO = { icon = "", color = "info" },
				HACK = { icon = " ", color = "warning" },
				WARN = { icon = " ", color = "error", alt = { "WARNING", "XXX" } },
				PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
				NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
				TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
			},
			colors = {
				error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
				warning = { "DiagnosticWarning", "WarningMsg", "#FBBF24" },
				info = { "DiagnosticInfo", "#7FB4CA" },
				done = { "DiagnosticDone", "#00A600" },
				hint = { "DiagnosticHint", "#10B981" },
				default = { "Identifier", "#C34043" },
			},
		})
	end,
}
