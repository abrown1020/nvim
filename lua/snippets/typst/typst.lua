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
local autosnippet = ls.extend_decorator.apply(s, { snippetType = "autosnippet" })
local postfixm = ls.extend_decorator.apply(postfix, { snippetType = "autosnippet", condition = in_math })

-- local conditions = require 'luasnip.extras.expand_conditions'

local auto_backslash_snippet = require("snippets.utils.scaffolding").auto_backslash_snippet
local symbol_snippet = require("snippets.utils.scaffolding").symbol_snippet
local single_command_snippet = require("snippets.utils.scaffolding").single_command_snippet
local postfix_snippet = require("snippets.utils.scaffolding").postfix_snippet
local get_visual = require("snippets.utils.scaffolding").get_visual
--
-- Typst detection functions

local in_math = require("snippets.utils.conditions").in_typst_math

local out_math = function()
	return not in_math()
end

local line_begin = require("luasnip.extras.conditions.expand").line_begin

M = {
	-- Inline math: $ … $
	postfixm(".$", {
		f(function(_, parent)
			local tok = parent.snippet.env.POSTFIX_MATCH -- contiguous (up to space)
			return "$" .. tok .. "$"
		end),
	}, {
		match_pattern = "[^%a]+", -- grab back to the nearest whitespace
		wordTrig = false,
		-- snippetType = 'autosnippet',
		priority = 1000,
	}),

	postfixm(".,", {
		f(function(_, parent)
			local tok = parent.snippet.env.POSTFIX_MATCH -- contiguous (up to space)
			return "cal(" .. tok .. ")"
		end),
	}, {
		match_pattern = "[^%a]+", -- grab back to the nearest whitespace
		wordTrig = false,
		-- snippetType = 'autosnippet',
		priority = 1000,
	}),

	postfixm(".ct", {
		f(function(_, parent)
			local tok = parent.snippet.env.POSTFIX_MATCH -- contiguous (up to space)
			return "cat(" .. tok .. ")"
		end),
	}, {
		match_pattern = "[^%a]+", -- grab back to the nearest whitespace
		wordTrig = false,
		-- snippetType = 'autosnippet',
		priority = 1000,
	}),
	postfixm(".cl", {
		f(function(_, parent)
			local tok = parent.snippet.env.POSTFIX_MATCH -- contiguous (up to space)
			return "overline(" .. tok .. ")"
		end),
	}, {
		match_pattern = "[^%a]+", -- grab back to the nearest whitespace
		wordTrig = false,
		-- snippetType = 'autosnippet',
		priority = 1000,
	}),
	autosnippet(
		{ trig = "dm", condition = line_begin, priority = 200, name = "display math", dscr = "display math" },
		fmta(
			[[ 
    $  
    <>. 
    $ 
    <>]],
			{ i(1), i(0) }
		)
	),
	autosnippet({ trig = "$", condition = out_math, wordTrig = false, priority = 100 }, { t("$"), i(1), t(" $") }),
	autosnippet({ trig = "dk", condition = out_math, wordTrig = false, priority = 100 }, { t("$"), i(1), t(" $") }),
	-- autosnippet({ trig = "_", condition = out_math, wordTrig = false, priority = 100 }, { t("_"), i(1), t("_") }),
	-- autosnippet({ trig = "*", condition = out_math, wordTrig = false, priority = 100 }, { t("*"), i(1), t("*") }),
	autosnippet({ trig = "ooo", condition = in_math, wordTrig = false, priority = 100 }, { t("infinity") }),

	-- autosnippet({ trig = 'lrp', condition = in_math, priority = 100 }, { t 'lr((', i(1), t '))' }),
	-- autosnippet({ trig = 'lrb', condition = in_math, priority = 100 }, { t 'lr([', i(1), t '])' }),
	-- autosnippet({ trig = 'lrs', condition = in_math, priority = 100 }, { t 'lr({', i(1), t '})' }),
	-- autosnippet({ trig = 'lrv', condition = in_math, priority = 100 }, { t 'lr(|', i(1), t '|)' }),
	-- autosnippet({ trig = 'lra', condition = in_math, priority = 100 }, { t 'lr(<', i(1), t '>)' }),
	autosnippet({ trig = "\\\\", condition = line_begin, priority = 100 }, { t("#v(1em)") }),

	-- Proofs Snippets
	autosnippet({ trig = "tx;", condition = not in_math, priority = 100 }, { t("there exist ") }),
	autosnippet({ trig = "ts;", condition = not in_math, priority = 100 }, { t("there exists ") }),
	autosnippet({ trig = "st;", condition = not in_math, priority = 100 }, { t("such that ") }),

	autosnippet(
		{ trig = "-env", dscr = "autofill environment" },
		fmta(
			[[
      #<>(title: "<>")[
      <>      
      ] <<<>>>
      <>
    ]],
			{
				i(1),
				i(2),
				i(3),
				i(4),
				i(0),
			}
		)
	),

	autosnippet(
		{ trig = "#def", name = "Definition environment", condition = line_begin },
		fmta(
			[[
            #def(title: "<>")[
            \
            <>
            ]
            <>
            ]],
			{ i(1), i(2), i(0) }
		)
	),
	autosnippet(
		{ trig = "#th", name = "Theorem environment", condition = line_begin },
		fmta(
			[[
            #thm(title: "<>")[
            \
            <>
            ]
            <>
            ]],
			{ i(1), i(2), i(0) }
		)
	),
	autosnippet(
		{ trig = "#pro", name = "Proof environment", condition = line_begin },
		fmta(
			[[
            #proof[
            <>
            ]
            <>
            ]],
			{ i(1), i(0) }
		)
	),
}

return M
