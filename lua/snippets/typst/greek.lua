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
-- local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require('luasnip.extras.fmt').fmt
local fmta = require('luasnip.extras.fmt').fmta
local postfix = require('luasnip.extras.postfix').postfix
-- local autosnippet = ls.extend_decorator.apply(s, { snippetType = 'autosnippet' })
local autosnippet = ls.extend_decorator.apply(s, { snippetType = 'autosnippet' })
local in_math = require('snippets.utils.conditions').in_typst_math
local automath = ls.extend_decorator.apply(s, { snippetType = 'autosnippet', condition = in_math })

local line_begin = require('luasnip.extras.conditions.expand').line_begin

local postfixm = ls.extend_decorator.apply(postfix, { snippetType = 'autosnippet', condition = in_math })
--
-- Lists of Greek letters
local greek_lower = {
  alpha = true,
  beta = true,
  gamma = true,
  delta = true,
  epsilon = true,
  zeta = true,
  eta = true,
  theta = true,
  iota = true,
  kappa = true,
  lambda = true,
  mu = true,
  nu = true,
  xi = true,
  omicron = true,
  pi = true,
  rho = true,
  sigma = true,
  tau = true,
  upsilon = true,
  phi = true,
  chi = true,
  psi = true,
  omega = true,
  varepsilon = true,
  vartheta = true,
  varpi = true,
  varrho = true,
  varsigma = true,
  varphi = true,
}
local greek_upper = {
  Alpha = true,
  Beta = true,
  Gamma = true,
  Delta = true,
  Epsilon = true,
  Zeta = true,
  Eta = true,
  Theta = true,
  Iota = true,
  Kappa = true,
  Lambda = true,
  Mu = true,
  Nu = true,
  Xi = true,
  Omicron = true,
  Pi = true,
  Rho = true,
  Sigma = true,
  Tau = true,
  Upsilon = true,
  Phi = true,
  Chi = true,
  Psi = true,
  Omega = true,
}

local function wrapper_for(tok)
  -- Greek takes precedence
  if greek_upper[tok] then
    return 'gmatr'
  end
  if greek_lower[tok] then
    return 'gvect'
  end
  -- Latin single-letter: upper -> matr, lower -> vect
  if tok:match '^%u$' then
    return 'matr'
  end
  if tok:match '^%l$' then
    return 'vect'
  end
  -- Fallback: treat multi-letter non-Greek as vectors unless you prefer otherwise
  return tok:match '^%u' and 'matr' or 'vect'
end

local M = {}

local matrix_postfix = {
  postfixm('.m', {
    f(function(_, parent)
      local tok = parent.snippet.env.POSTFIX_MATCH -- the token right before ".m"
      return string.format('%s(%s)', wrapper_for(tok), tok)
    end),
  }, {
    match_pattern = '[%a]+', -- only the contiguous letters before ".m"
    wordTrig = false,
    priority = 1000,
    snippetType = 'autosnippet',
    -- condition   = in_math,        -- uncomment if you have this defined
  }),
}

vim.list_extend(M, matrix_postfix)

local greek_letters = {
  [':a'] = 'alpha',
  [':b'] = 'beta',
  [':g'] = 'gamma',
  [':d'] = 'delta',
  [':e'] = 'epsilon',
  [':z'] = 'zeta',
  [':h'] = 'eta',
  [':q'] = 'theta',
  [':i'] = 'iota',
  [':k'] = 'kappa',
  [':l'] = 'lambda',
  [':m'] = 'mu',
  [':n'] = 'nu',
  [':x'] = 'xi',
  [':p'] = 'pi',
  [':r'] = 'rho',
  [':s'] = 'sigma',
  [':t'] = 'tau',
  [':u'] = 'upsilon',
  [':f'] = 'phi',
  [':c'] = 'chi',
  [':y'] = 'psi',
  [':w'] = 'omega',

  --:Capital versions
  [':G'] = 'Gamma',
  [':D'] = 'Delta',
  [':Q'] = 'Theta',
  [':L'] = 'Lambda',
  [':X'] = 'Xi',
  [':P'] = 'Pi',
  [':S'] = 'Sigma',
  [':U'] = 'Upsilon',
  [':F'] = 'Phi',
  [':Y'] = 'Psi',
  [':W'] = 'Omega',
}

local greek_snippets = {}

-- Regular Greek Letters
for trig, name in pairs(greek_letters) do
  table.insert(
    greek_snippets,
    autosnippet({
      trig = trig,
      name = name,
      dscr = 'Greek letter ' .. name,
      condition = in_math,
      wordTrig = false,
      -- regTrig = true,
      priority = 200,
    }, t(name))
  )
end

vim.list_extend(M, greek_snippets)

return M
