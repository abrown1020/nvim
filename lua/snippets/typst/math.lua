local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local postfix = require("luasnip.extras.postfix").postfix
-- local autosnippet = ls.extend_decorator.apply(s, { snippetType = 'autosnippet' })
local autosnippet = ls.extend_decorator.apply(s, { snippetType = "autosnippet" })
local in_math = require("snippets.utils.conditions").in_typst_math

local line_begin = require("luasnip.extras.conditions.expand").line_begin

local postfixm =
	ls.extend_decorator.apply(postfix, { snippetType = "autosnippet", condition = in_math, wordTrig = false })
-- local get_visual = require('snippets.utils.scaffolding').get_visual
--
local automath = ls.extend_decorator.apply(s, {
	snippetType = "autosnippet",
	condition = in_math,
	-- regTrig = true,
	-- trigEngine = "vim",
	wordTrig = false,
})

local function get_visual(_, parent)
	local sel = parent.snippet.env.SELECT_DEDENT or {}
	if #sel > 0 then
		return sn(nil, i(1, sel)) -- table of lines is fine for i()
	else
		return sn(nil, i(1))
	end
end

local M = {

	-- Set Operations
	--
	automath({ trig = "cc" }, { t("subset") }),
	automath({ trig = "cq" }, { t("subset.eq") }),
	automath({ trig = "ovl", name = "Text" }, fmt([[overline({}) {}]], { i(1), i(0) })),
	automath({ trig = "UU", name = "Big Union" }, fmt([[union.big_({}) {}]], { i(1), i(0) })),
	automath({ trig = "nN", name = "Big Intersection" }, fmt([[inter.big_({}) {}]], { i(1), i(0) })),
	automath({ trig = "c->", name = "Hook arrow" }, t("arrow.hook")),

	-- Arithmetic
	-- automath({ trig = "**" }, { t("dot.op") }),
	automath({ trig = "sr" }, { t("^(2)") }),
	automath({ trig = "cb" }, { t("^(3)") }),
	-- automath({ trig = "rt" }, { t("^(1/2)") }),
	automath({ trig = "wo" }, { t("without") }),
	automath({ trig = "inv" }, { t("^(-1)") }),
	automath({ trig = "+-", wordTrig = false }, { t("plus.minus") }),
	automath({ trig = "-+", wordTrig = false }, { t("minus.plus") }),

	-- Text and spacing
	automath({ trig = "tt", name = "Text" }, fmt([["{}" {}]], { i(1, "text here"), i(0) })),
	automath({ trig = "qand" }, { t(' quad "and" quad ') }),
	automath({ trig = "_", name = "Subscript" }, fmt([[_({}){}]], { i(1), i(0) })),

	-- Linear Algebra
	automath({ trig = ".t", wordTrig = false, name = "Transpose" }, { t("^T") }),
	automath({ trig = ".h", wordTrig = false, name = "Hermitian Transpose" }, { t("^H") }),

	-- Calculus
	automath({ trig = "del", wordTrig = false, name = "Nabla" }, { t("nabla ") }), -- Statistics
	automath(
		{ trig = "wgni", wordTrig = false, name = "Inverse White Noise Covariance" },
		{ t("1/(sigma^2) matr(I)") }
	),
	automath({ trig = "pfrac", name = "Text" }, fmt([[(diff {})/(diff {})]], { i(1), i(0) })),

	-- Statistics
	automath({ trig = "wgnc", wordTrig = false, name = "White Noise Covariance" }, { t("sigma^2 matr(I)") }),
	automath({ trig = "hat", name = "Text" }, fmt([[hat({}){}]], { i(1), i(0) })),
	automath({ trig = "sigs", wordTrig = false, name = "White Noise Covariance" }, { t("sigma^2") }),

	postfixm(
		{ trig = ".fr", name = "Surround into fraction", match_pattern = "[^%s]+" },
		fmt([[({}) / ({}){}]], {
			d(1, function(_, parent)
				local match = parent.env.POSTFIX_MATCH or parent.env.LS_POSTFIX_MATCH
				-- Wrap the entire matched chunk in parentheses
				return sn(nil, { t("" .. match .. "") })
			end),
			i(2, "den"), -- denominator
			i(0), -- cursor after
		})
	),
}

local function power_wrapper(aliases, power, opts)
	opts = opts or {}
	local mp = opts.match_pattern or "[^%s]+" -- contiguous up to a space
	local prio = opts.priority or 1000
	local cond = opts.condition -- e.g., automath()

	for _, alias in ipairs(aliases) do
		table.insert(
			M,
			postfixm("." .. alias, {
				f(function(_, parent)
					local tok = parent.snippet.env.POSTFIX_MATCH
					local needs_paren = (#tok > 1)
					local base = needs_paren and ("(" .. tok .. ")") or tok
					return base .. "^(" .. tostring(power) .. ")"
				end),
			}, {
				match_pattern = mp,
				-- wordTrig      = false,
				-- snippetType   = "autosnippet",
				priority = prio,
				condition = cond,
			})
		)
	end
end

-- Squares and cubes (with short aliases).
power_wrapper({ "sr" }, 2)
power_wrapper({ "cb", "cu" }, 3)
power_wrapper({ "hf" }, 1 / 2)
-- power_wrapper({ 'invs' }, -1)

return M
