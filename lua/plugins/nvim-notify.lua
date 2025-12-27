return {
	"rcarriga/nvim-notify",
	event = "VeryLazy",
	config = function()
		local notify = require("notify")

		-- Resolve a concrete background color:
		-- 1) Use Normal.bg if defined
		-- 2) Fall back to a sane dark value
		local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
		local bg_hex = normal.bg and string.format("#%06x", normal.bg) or "#1e1e2e"

		notify.setup({
			render = "minimal",
			stages = "fade",

			background_colour = bg_hex, -- fixes NotifyBackground warning
			timeout = 2500,

			max_width = math.floor(vim.o.columns * 0.45),
			max_height = math.floor(vim.o.lines * 0.25),
		})

		vim.notify = notify
	end,
}
