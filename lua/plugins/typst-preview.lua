return {
	"chomosuke/typst-preview.nvim",
	version = "1.*",
	lazy = false,
	opts = {
		debug = false,
		follow_cursor = true,
		open_cmd = "$BROWSER %s --no-preview",
	},
	keys = {
		{ "<leader>tp", "<cmd>TypstPreview<CR>", desc = "Run Typst Preview" },
	},
}
