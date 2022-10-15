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
local isn = require("luasnip.nodes.snippet").ISN
local psn = require("luasnip.nodes.snippet").PSN
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

local function column_count_from_string(descr)
	return #(descr:gsub("[^clmrp]", ""))
end

local tab = function(args, snip)
	local cols = column_count_from_string(args[1][1])
	if not snip.rows then
		snip.rows = 1
	end
	local nodes = {}
	local ins_indx = 1
	for j = 1, snip.rows do
		table.insert(nodes, r(ins_indx, tostring(j) .. "x1", i(1)))
		ins_indx = ins_indx + 1
		for k = 2, cols do
			table.insert(nodes, t(" & "))
			table.insert(nodes, r(ins_indx, tostring(j) .. "x" .. tostring(k), i(1)))
			ins_indx = ins_indx + 1
		end
		table.insert(nodes, t({ "\\\\", "" }))
	end
	-- fix last node.
	nodes[#nodes] = t("")
	return sn(nil, nodes)
end

return {
  -- Preamble
	s(
		{ trig = "template", name = "basic template", dscr = "Insert basic template." },
		fmt(
			[[
      \documentclass[a4paper]{{/Users/dawei/.dotfiles/templates/preamble}}

      \cfoot{{\thepage}}
      \lhead{{Lee}}
      \chead{{}}
      \rhead{{}}

      \begin{{document}}
      {}
      \end{{document}}
      ]],
			{ i(1) }
		)
	),

	-- Environments
	s(
		{ trig = "beg", desc = "Insert Environment" },
		fmt(
			[[
      \begin{{{}}}
        {}
      \end{{{}}}
      ]],
			{ i(1), i(2), r(1) }
		)
	),
	s(
		{ trig = "beq", desc = "Insert Equation Environment" },
		fmt(
			[[
      \begin{{equation*}}
        {}
      \end{{equation*}}
      ]],
			i(1)
		)
	),
	s(
		{ trig = "bal", desc = "Insert Align Environment" },
		fmt(
			[[
      \begin{{align*}}
        {}
      \end{{align*}}
      ]],
			i(1)
		)
	),
	s(
		"item",
		fmt(
			[[
      \begin{{itemize}}
        \item {}{}
      \end{{itemize}}
      ]],
			{
				i(1),
				d(2, rec_ls, {}),
			}
		)
	),

	s(
		"enum",
		fmt(
			[[
        \begin{{enumerate}}[label = (\alph*)]
          \item {}{}
        \end{{enumerate}}
      ]],
			{
				i(1),
				d(2, rec_ls, {}),
			}
		)
	),
	s("fig", {
		t({ "\\begin{figure}[ht]", "\t\\centering", "\t\\includegraphics[width=0.8\\textwidth]{" }),
		i(1),
		t({ "}", "\t\\caption{" }),
		i(2),
		t({ "}\\label{fig:" }),
		i(3),
		t({ "}", "\\end{figure}" }),
	}),
	s(
		"table",
		fmt(
			[[
      \begin{{table}}[{}]
        \centering
        \caption{{}}\label{{}}
        \begin{{tabular}}{{{}}}
        {}
        \end{{tabular}}
      \end{{table}}
      ]],
			{
				i(1, "ht"),
				i(2, "c"),
				d(3, tab, { 1 }, {
					user_args = {
						function(snip)
							snip.rows = snip.rows + 1
						end,
						-- don't drop below one.
						function(snip)
							snip.rows = math.max(snip.rows - 1, 1)
						end,
					},
				}),
			}
		)
	),

	ls.parser.parse_snippet({ trig = "ab", wordTrig = true }, "\\langle $1 \\rangle"),
	ls.parser.parse_snippet({ trig = "lra", wordTrig = true }, "\\leftrightarrow"),
	ls.parser.parse_snippet({ trig = "Lra", wordTrig = true }, "\\Leftrightarrow"),
	ls.parser.parse_snippet({ trig = "fr", wordTrig = true }, "\\frac{$1}{$2}"),
	ls.parser.parse_snippet({ trig = "tr", wordTrig = true }, "\\item $1"),
	ls.parser.parse_snippet({ trig = "abs", wordTrig = true }, "\\|$1\\|"),

	s({ trig = "bf" }, fmt("\\textbf{{{}}}", { i(1) })),
	ls.parser.parse_snippet("it", [[\textit{$1}]]),
	ls.parser.parse_snippet("tx", [[\text{$1}]]),
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

}
