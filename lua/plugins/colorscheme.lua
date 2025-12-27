-- lua/plugins/kanagawa.lua
return {
	"rebelot/kanagawa.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		compile = false,
		undercurl = true,
		commentStyle = { italic = true },
		functionStyle = {},
		keywordStyle = { italic = true },
		statementStyle = { bold = true },
		typeStyle = {},
		transparent = false,
		dimInactive = false,
		terminalColors = true,

		-- Force dragon
		theme = "dragon",
		background = {
			dark = "dragon",
			light = "lotus",
		},

		colors = {
			palette = {},
			theme = {
				wave = {},
				lotus = {},
				dragon = {},
				all = {
					ui = {
						bg_gutter = "none",
					},
				},
			},
		},

		overrides = function(colors)
			local theme = colors.theme
			local palette = colors.palette
			return {
				TelescopeTitle = { fg = theme.ui.special, bold = true },
				TelescopePromptNormal = { bg = theme.ui.bg_p1 },
				TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
				TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
				TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
				TelescopePreviewNormal = { bg = theme.ui.bg_dim },
				TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },

				Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1, blend = vim.o.pumblend }, -- add `blend = vim.o.pumblend` to enable transparency
				PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
				PmenuSbar = { bg = theme.ui.bg_m1 },
				PmenuThumb = { bg = theme.ui.bg_p2 },

				DiagnosticError = { fg = palette.waveRed },
				DiagnosticSignError = { fg = palette.waveRed },
				DiagnosticVirtualTextError = { fg = palette.waveRed },
				DiagnosticUnderlineError = { sp = palette.waveRed, undercurl = true },
				DiagnosticFloatingError = { fg = palette.waveRed },
			}
		end,
	},
	config = function(_, opts)
		require("kanagawa").setup(opts)
		vim.cmd.colorscheme("kanagawa-dragon")
	end,
}
