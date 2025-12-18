local ls = require 'luasnip'
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require 'luasnip.util.events'
local ai = require 'luasnip.nodes.absolute_indexer'
local extras = require 'luasnip.extras'
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require('luasnip.extras.fmt').fmt
local fmta = require('luasnip.extras.fmt').fmta
-- local autosnippet = ls.extend_decorator.apply(s, { snippetType = 'autosnippet' })
local autosnippet = ls.extend_decorator.apply(s, { snippetType = 'autosnippet' })
local in_math = require('snippets.utils.conditions').in_typst_math
local automath = ls.extend_decorator.apply(s, { snippetType = 'autosnippet', condition = in_math })

local line_begin = require('luasnip.extras.conditions.expand').line_begin

-- local get_visual = require('snippets.utils.scaffolding').get_visual

local function get_visual(_, parent)
  local sel = parent.snippet.env.SELECT_DEDENT or {}
  if #sel > 0 then
    return sn(nil, i(1, sel)) -- table of lines is fine for i()
  else
    return sn(nil, i(1))
  end
end

local M = {
  automath({ trig = 'lrp', name = 'Left-Right ()' }, fmt([[lr(( {} )) {}]], { d(1, get_visual), i(0) })),
  automath({ trig = 'lrb', name = 'Left-Right []' }, fmt([[lr([ {} ]) {}]], { d(1, get_visual), i(0) })),
  automath({ trig = 'lrs', name = 'Left-Right {}' }, fmta([[lr({ <> }) <>]], { d(1, get_visual), i(0) })),
  automath({ trig = 'lra', name = 'Left-Right <>' }, fmt([[lr(angle.l {} angle.r) {}]], { d(1, get_visual), i(0) })),
  automath({ trig = 'lrv', name = 'Left-Right ||' }, fmt([[lr(abs( {} )) {}]], { d(1, get_visual), i(0) })),
}

return M
