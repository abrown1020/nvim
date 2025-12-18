return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
	config = function()
		require("noice").setup({
			cmdline = {
				enabled = true,
				view = "cmdline_popup",
				format = {
					cmdline = { pattern = "^:", icon = "", lang = "vim" },
					search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
					search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
					lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
					help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
					input = { view = "cmdline_input", icon = "󰥻 " },
					filter = { pattern = "^:%s*!", icon = "λ", lang = "zsh" },
				},
			},

			messages = {
				enabled = true,
				view_search = "notify",
				view_error = "notify",
				view_warn = "notify",
				view_history = "messages",
			},

			popupmenu = {
				enabled = true,
				backend = "nui",
			},

			notify = {
				enabled = true,
				-- view = "notify",
				view = "mini",
			},

			lsp = {
				progress = { enabled = false },
				signature = { enabled = false },
				hover = { enabled = true },
				message = { enabled = true },
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},

			views = {
				cmdline_popup = {
					position = {
						row = "90%",
						col = "50%",
					},
					size = {
						width = 60,
						height = "auto",
					},
					border = {
						-- style = "rounded",
						padding = { 0, 1 },
					},
					win_options = {
						winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
					},
				},

				split = {
					enter = true,
					win_options = {
						winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
					},
				},
			},

			presets = {
				bottom_search = false,
				command_palette = true,
				long_message_to_split = true,
				inc_rename = false,
				lsp_doc_border = true,
			},
		})

		vim.notify = require("notify")
	end,
}
