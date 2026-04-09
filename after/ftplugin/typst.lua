local ok, npairs = pcall(require, "nvim-autopairs")
if not ok then
	return
end

local Rule = require("nvim-autopairs.rule")
local cond = require("nvim-autopairs.conds")

-- Utility: Detect if we are inside a Typst math context
local function in_typst_math()
	local node = vim.treesitter.get_node()
	while node do
		if node:type() == "math" then
			return true
		end
		node = node:parent()
	end
	return false
end

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
})
