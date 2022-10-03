local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local l = require("luasnip.extras").lambda
local r = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.expand_conditions")
local pi = ls.parent_indexer
local isn = require("luasnip.nodes.snippet").ISN
local psn = require("luasnip.nodes.snippet").PSN
local l = require("luasnip.extras").l
local r = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local types = require("luasnip.util.types")
local events = require("luasnip.util.events")
local su = require("luasnip.util.util")

local function rec_ls()
	return sn(
		nil,
		c(1, {
			-- Order is important, sn(...) first would cause infinite loop of expansion.
			t(""),
			sn(nil, { t({ "", "\t\\item " }), i(1), d(2, rec_ls, {}) }),
		})
	)
end

local tex = {}

tex.in_mathzone = function()
	return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

tex.in_text = function()
	return not tex.in_mathzone()
end

return {
	ls.parser.parse_snippet({ trig = "beg", wordTrig = true }, "\\begin{$1}\n\t$2\n\\end{$1}"),
	ls.parser.parse_snippet({ trig = "beq", wordTrig = true }, "\\begin{equation*}\n\t$1\n\\end{equation*}"),
	ls.parser.parse_snippet({ trig = "bal", wordTrig = true }, "\\begin{align*}\n\t$1\n\\end{align*}"),
	ls.parser.parse_snippet({ trig = "ab", wordTrig = true }, "\\langle $1 \\rangle"),
	ls.parser.parse_snippet({ trig = "lra", wordTrig = true }, "\\leftrightarrow"),
	ls.parser.parse_snippet({ trig = "Lra", wordTrig = true }, "\\Leftrightarrow"),
	ls.parser.parse_snippet({ trig = "fr", wordTrig = true }, "\\frac{$1}{$2}"),
	ls.parser.parse_snippet({ trig = "tr", wordTrig = true }, "\\item $1"),
	ls.parser.parse_snippet({ trig = "abs", wordTrig = true }, "\\|$1\\|"),

	s("item", {
		t({ "\\begin{itemize}", "\t\\item " }),
		i(1),
		d(2, rec_ls, {}),
		t({ "", "\\end{itemize}" }),
		i(0),
	}),

	s("enum", {
		t({ "\\begin{enumerate}[label = (\\alph*)]", "\t\\item " }),
		i(1),
		d(2, rec_ls, {}),
		t({ "", "\\end{enumerate}" }),
		i(0),
	}),

  s({trig = "fig", dscr = "Insert Figure Environment"}, {
    t({ "\\begin{figure}[ht]", "\t\\centering", "\t\\includegraphics[width=0.8\\textwidth]{" }),
    i(1),
    t({"}", "\t\\caption{"}),
    i(2),
    t({"}\\label{fig:"}),
    i(3),
    t({"}", "\\end{figure}"}),
  }),

	s({ trig = "mk", name = "inline math", dscr = "Insert inline Math Environment." }, {
		t("$"),
		i(1),
		t("$"),
	}, {
		condition = tex.in_text,
	}),

	s({ trig = "problem" }, {
		t({ "\\noindent\\textbf{" }),
		i(1),
		t({ "}" }),
	}),

	s({ trig = "template", name = "basic template", dscr = "Insert basic template." }, {
		t({
			"\\documentclass[a4paper]{/Users/dawei/.dotfiles/templates/preamble}",
			"",
			"\\cfoot{\\thepage}",
			"\\lhead{Lee}",
			"\\chead{}",
			"\\rhead{}",
			"",
		}),
		t({ "\\begin{document}", "" }),
		i(1),
		t({ "", "\\end{document}" }),
	}),
}
