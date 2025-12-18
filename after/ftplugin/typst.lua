-- after/ftplugin/typst.lua
-- after/ftplugin/typst.lua
local ok, npairs = pcall(require, "nvim-autopairs")
if not ok then
	return
end

local Rule = require("nvim-autopairs.rule")
local cond = require("nvim-autopairs.conds")

-- Utility: Detect if we are inside a Typst math context
local function in_typst_math()
	local ok, ts_utils = pcall(require, "nvim-treesitter.ts_utils")
	if not ok then
		return false
	end
	local node = ts_utils.get_node_at_cursor()
	while node do
		local type = node:type()
		if type == "math" or type == "math_block" or type == "equation" then
			return true
		end
		node = node:parent()
	end
	return false
end
-- Pair underscores in Typst, but avoid pairing inside identifiers (x_i, foo_bar)
npairs.add_rules({
	Rule("_", "_", "typst")
		:with_pair(cond.not_before_regex("[%w_]", 1))
		:with_pair(cond.not_after_regex("[%w_]"))
		:with_move(function(opts)
			return opts.char == "_"
		end)
		-- Disable inside Typst math nodes
		:with_pair(function()
			return not in_typst_math()
		end),
	Rule("*", "*", "typst")
		:with_pair(cond.not_before_regex("[%w_]", 1))
		:with_pair(cond.not_after_regex("[%w_]"))
		:with_move(function(opts)
			return opts.char == "_"
		end)
		-- Disable inside Typst math nodes
		:with_pair(function()
			return not in_typst_math()
		end),
	-- Rule("$", " $", "typst")
	-- 	-- don't add a pair if the LEFT neighbor is a word/underscore
	-- 	:with_pair(cond.not_before_regex("[%w_]", 1))
	-- 	-- don't add a pair if the RIGHT neighbor is a word/underscore
	-- 	:with_pair(cond.not_after_regex("[%w_]"))
	-- 	-- when you type the second `_`, jump over the closer instead of inserting another
	-- 	:with_move(function(opts)
	-- 		return opts.char == "_"
	-- 	end),
})
