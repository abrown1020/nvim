return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").setup({
			install_dir = vim.fn.stdpath("data") .. "/site",
			ensure_installed = {
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
			},
			auto_install = true,
			highlight = { enable = true },
		})

		-- Filetype detection
		vim.filetype.add({ extension = { typ = "typst" } })

		-- Treesitter highlighting
		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"typst",
				"latex",
				"python",
				"lua",
				"vim",
				"bash",
				"c",
				"cpp",
				"markdown",
				"json",
				"toml",
				"yaml",
			},
			callback = function()
				vim.treesitter.start()
			end,
		})

		-- Treesitter folding for typst and markdown
		-- vim.api.nvim_create_autocmd("FileType", {
		-- 	pattern = { "typst", "markdown" },
		-- 	callback = function()
		-- 		vim.wo[0][0].foldmethod = "expr"
		-- 		vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
		-- 	end,
		-- })
	end,
}
