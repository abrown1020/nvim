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
-- local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local postfix = require("luasnip.extras.postfix").postfix
-- local autosnippet = ls.extend_decorator.apply(s, { snippetType = 'autosnippet' })
local autosnippet = ls.extend_decorator.apply(s, { snippetType = "autosnippet" })
local in_math = require("snippets.utils.conditions").in_typst_math

local line_begin = require("luasnip.extras.conditions.expand").line_begin

local postfixm = ls.extend_decorator.apply(postfix, { snippetType = "autosnippet", condition = in_math })
local automath = ls.extend_decorator.apply(s, { snippetType = "autosnippet", condition = in_math })

-- Helper: define many postfix wrappers from a spec table.
-- Each entry in `specs` may be:
--   1) "name"           -> produces name(tok), e.g., "hat" -> hat(tok)
--   2) "format %s"      -> string.format with tok, e.g., "\\hat{%s}" -> \hat{tok}
--   3) function(M = M or {}
--
--
local M = M or {}

-- Make N aliases (.alias1, .alias2, ...) expand to name(token) identically.
local function post_wrap(name, aliases, opts)
	opts = opts or {}
	local mp = opts.match_pattern or "[^%s]+" -- contiguous, up to a space
	local cond = opts.condition -- e.g., automath() / in_math

	for _, alias in ipairs(aliases) do
		table.insert(
			M,
			postfixm("." .. alias, {
				f(function(_, parent)
					local tok = parent.snippet.env.POSTFIX_MATCH
					return string.format("%s(%s)", name, tok)
				end),
			}, {
				match_pattern = mp,
				wordTrig = false,
				-- snippetType   = "autosnippet",
				-- priority = opts.priority or 1000,
				condition = cond,
			})
		)
	end
end

-- Examples: add as many aliases as you like.
post_wrap("hat", { "hat", "ht" })
-- post_wrap('conj', { 'conj', 'cj' })
post_wrap("sqrt", { "sqrt", "sq" })
post_wrap("overline", { "bar" })
post_wrap("tilde", { "tilde", "tld" })
post_wrap("cal", { "cal" })
-- post_wrap("T", { "T" })

-- table.insert(
--   M,
--   postfixm('.$', {
--     f(function(_, parent)
--       local tok = parent.snippet.env.POSTFIX_MATCH -- contiguous (up to space)
--       return '$' .. tok .. '$'
--     end),
--   }, {
--     match_pattern = '[^%s]+', -- grab back to the nearest whitespace
--     wordTrig = false,
--     -- snippetType = 'autosnippet',
--     priority = 1000,
--   })
-- )

return M
