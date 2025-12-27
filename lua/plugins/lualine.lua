return {
	"nvim-lualine/lualine.nvim",
	enabled = true,
	event = "VeryLazy",
	config = function()
		local mode = {
			"mode",
			fmt = function(str)
				return str
				-- return " " .. str
				-- return ' ' .. str:sub(1, 1) -- displays only the first character of the mode
			end,
		}

		local filename = {
			"filename",
			file_status = true, -- displays file status (readonly status, modified status)
			path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
		}

		local hide_in_width = function()
			return vim.fn.winwidth(0) > 100
		end

		local diagnostics = {
			"diagnostics",
			sources = { "nvim_diagnostic" },
			sections = { "error", "warn" },
			symbols = { error = " ", warn = " ", info = " ", hint = " " },
			colored = true,
			update_in_insert = false,
			always_visible = false,
			cond = hide_in_width,
		}

		local diff = {
			"diff",
			colored = false,
			symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
			cond = hide_in_width,
		}

		local bg_color = "#181616"

		require("lualine").setup({
			options = {
				-- theme = "auto",
				theme = {

					normal = {
						a = { bg = bg_color },
						b = { bg = bg_color },
						c = { bg = bg_color },
						x = { bg = bg_color },
						y = { bg = bg_color },
						z = { bg = bg_color },
					},
					insert = {
						a = { bg = bg_color },
						b = { bg = bg_color },
						c = { bg = bg_color },
						x = { bg = bg_color },
						y = { bg = bg_color },
						z = { bg = bg_color },
					},
					visual = {
						a = { bg = bg_color },
						b = { bg = bg_color },
						c = { bg = bg_color },
						x = { bg = bg_color },
						y = { bg = bg_color },
						z = { bg = bg_color },
					},
					replace = {
						a = { bg = bg_color },
						b = { bg = bg_color },
						c = { bg = bg_color },
						x = { bg = bg_color },
						y = { bg = bg_color },
						z = { bg = bg_color },
					},
					command = {
						a = { bg = bg_color },
						b = { bg = bg_color },
						c = { bg = bg_color },
						x = { bg = bg_color },
						y = { bg = bg_color },
						z = { bg = bg_color },
					},
					inactive = {
						a = { bg = bg_color },
						b = { bg = bg_color },
						c = { bg = bg_color },
						x = { bg = bg_color },
						y = { bg = bg_color },
						z = { bg = bg_color },
					},
				},

				globalstatus = true,
				icons_enabled = false,
				-- theme = 'gruvbox', -- Set theme based on environment variable
				-- Some useful glyphs:
				-- https://www.nerdfonts.com/cheat-sheet
				--        
				-- section_separators = { left = "", right = "" },
				section_separators = { left = " ", right = " " },
				-- component_separators = { left = "", right = "" },
				component_separators = { left = " ", right = " " },
				disabled_filetypes = { "alpha", "neo-tree" },
				always_divide_middle = false,
			},
			sections = {
				lualine_a = { mode },
				lualine_b = { "branch" },
				lualine_c = { filename },
				-- lualine_x = {
				-- 	diagnostics,
				-- 	diff,
				-- 	{ "encoding", cond = hide_in_width },
				-- 	{ "filetype", cond = hide_in_width },
				-- },
				-- lualine_y = { "location" },
				-- lualine_z = { "progress" },
				lualine_y = {},
				lualine_z = {},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { { "filename", path = 1 } },
				lualine_x = { { "location", padding = 0 } },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			extensions = { "fugitive", "quickfix", "lazy" },
		})
	end,
}
