local is_ssh = os.getenv("SSH_CLIENT") ~= nil or os.getenv("SSH_TTY") ~= nil

return {
	"chomosuke/typst-preview.nvim",
	version = "1.*",
	lazy = false,
	opts = {
		debug = false,
		follow_cursor = true,
		open_cmd = is_ssh and "echo %s" or "$BROWSER %s --no-preview",
		port = is_ssh and 8888 or nil,
		dependencies_bin = {
			["tinymist"] = "/home/andbr/.cargo/bin/tinymist",
			["websocat"] = nil,
		},
	},
	keys = {
		{ "<leader>tp", "<cmd>TypstPreview<CR>", desc = "Run Typst Preview" },
	},
}
