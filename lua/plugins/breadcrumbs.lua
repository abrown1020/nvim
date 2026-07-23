-- plugins.lua
return {
	{
		"SmiteshP/nvim-navic",
		enabled = true,
		event = "LspAttach", -- lazy-load when any LSP attaches
		opts = {
			preference = { "pylsp", "ty" },
			lsp = { auto_attach = false }, -- automatically call navic.attach()
		},
	},
	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons", -- optional dependency
		},
		opts = {
			attach_navic = false,
		},
	},
}
