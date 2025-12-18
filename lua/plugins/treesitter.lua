return {
	"nvim-treesitter/nvim-treesitter",
	event = "BufReadPost",
	build = ":TSUpdate",
	priority = 500,
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	main = "nvim-treesitter.configs",
	opts = {
		ensure_installed = {
			"lua",
			"vim",
			"vimdoc",
			"python",
			-- 'latex',
			-- 'javascript',
			"json",
			"yaml",
			-- 'html',
			-- 'css',
			"toml",
			"markdown",
			"markdown_inline",
			"regex",
			"gitignore",
			"typst",
		},
		auto_install = true,
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = { "ruby" }, -- latex may need both regex + TS
		},
		indent = {
			enable = true,
			disable = { "ruby", "latex" }, -- latex indentation still not reliable
		},
		textobjects = {
			select = {
				enable = true,
				lookahead = true,
				keymaps = {
					["am"] = "@math.outer",
					["im"] = "@math.inner",
				},
			},
			move = {
				enable = true,
				set_jumps = true,
				goto_next_start = { ["]m"] = "@math.outer" },
				goto_previous_start = { ["[m"] = "@math.outer" },
			},
		},
	},
}
