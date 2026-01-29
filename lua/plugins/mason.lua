return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		-- 1) Mason core
		require("mason").setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		-- 2) Mason-LSPconfig (use ONLY valid options)
		require("mason-lspconfig").setup({
			ensure_installed = {
				-- 'html',
				"lua_ls",
				"rust_analyzer",
				"ltex_plus",
				-- "tinymist",
				-- "pylsp",
			},
			automatic_installation = true,
			-- automatic_enable = true, -- ❌ remove: not a valid option
		})
		-- 3) Optional: tools (linters/formatters)
		-- require("mason-tool-installer").setup({
		-- 	ensure_installed = {
		-- 		"ruff",
		-- 	},
		-- })
	end,
}
