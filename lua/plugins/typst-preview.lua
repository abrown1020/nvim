return {
	"chomosuke/typst-preview.nvim",
	version = "1.*",
	lazy = false,
	opts = {
		debug = true,
		-- follow_cursor = true,
		-- port = 8000,
		open_cmd = "firefox.exe %s",
	},
	keys = {
		{ "<leader>tp", "<cmd>TypstPreview<CR>", desc = "Run Typst Preview" },
	},
}
