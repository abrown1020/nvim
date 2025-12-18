--[
-- LuaSnip Conditions
--]

local ls = require 'luasnip'
local s = ls.snippet
local sn = ls.snippet_node
local i = ls.insert_node

local M = {}

-- Returns true iff cursor is inside a Typst `math` node, excluding the '$'s.
function M.in_typst_math()
  if vim.bo.filetype ~= 'typst' then
    return false
  end

  local ok = pcall(vim.treesitter.get_parser, 0, 'typst')
  if not ok then
    return false
  end

  local tsu = require 'nvim-treesitter.ts_utils'
  local node = tsu.get_node_at_cursor()
  while node and node:type() ~= 'math' do
    node = node:parent()
  end
  if not node then
    return false
  end

  local sr, sc, er, ec = node:range() -- end col is exclusive
  local pos = vim.api.nvim_win_get_cursor(0) -- {row, col}
  local r, c = pos[1] - 1, pos[2]

  -- inside the node's rectangle…
  if r < sr or r > er then
    return false
  end
  -- …but not on the opening '$'
  if r == sr and c <= sc then
    return false
  end
  -- …and not on the closing '$'
  if r == er and c >= ec - 1 then
    return false
  end

  return true
end
M.get_visual = function(_, parent)
  return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
end
-- math / not math zones

function M.in_math()
  return vim.api.nvim_eval 'vimtex#syntax#in_mathzone()' == 1
end

-- comment detection
function M.in_comment()
  return vim.fn['vimtex#syntax#in_comment']() == 1
end

-- document class
function M.in_beamer()
  return vim.b.vimtex['documentclass'] == 'beamer'
end

-- general env function
local function env(name)
  local is_inside = vim.fn['vimtex#env#is_inside'](name)
  return (is_inside[1] > 0 and is_inside[2] > 0)
end

function M.in_preamble()
  return not env 'document'
end

function M.in_text()
  return env 'document' and not M.in_math()
end

function M.in_tikz()
  return env 'tikzpicture'
end

function M.in_bullets()
  return env 'itemize' or env 'enumerate'
end

function M.in_align()
  return env 'align' or env 'align*' or env 'aligned'
end

function M.show_line_begin(line_to_cursor)
  return #line_to_cursor <= 3
end

return M
