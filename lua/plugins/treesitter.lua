return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	branch = "main",
	config = function()
		local parsers = {
			"typst",
			"latex",
			"python",
			"lua",
			"vim",
			"vimdoc",
			"bash",
			"c",
			"cpp",
			"markdown",
			"markdown_inline",
			"json",
			"toml",
			"yaml",
		}

		-- Custom install directory (must be set before install)
		require("nvim-treesitter.config").setup({
			install_dir = vim.fn.stdpath("data") .. "/site",
		})

		-- Install parsers (async; no-op for already-installed ones)
		require("nvim-treesitter").install(parsers)

		-- Filetype detection
		vim.filetype.add({ extension = { typ = "typst" } })

		-- Enable treesitter highlighting per-buffer
		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"typst",
				"latex",
				"python",
				"lua",
				"vim",
				"help", -- vimdoc filetype is "help"
				"bash",
				"sh",
				"c",
				"cpp",
				"markdown",
				"json",
				"toml",
				"yaml",
			},
			callback = function()
				pcall(vim.treesitter.start)
			end,
		})
	end,
}
