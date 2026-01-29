require("core.options")
require("core.keymaps")
require("lsp")

-- optional custom colorscheme
-- require("core.colors").apply()

-- Lazy plugins
-- -------------
require("config.lazy")

-- Custom commands
-- ---------------
vim.api.nvim_create_user_command("TypstDoc", function()
	vim.fn.jobstart({ "firefox.exe", "--new-tab", "https://typst.app/docs/reference/symbols/sym/" }, { detach = true })
end, {})

-- LSP
-- ---
vim.lsp.enable("pylsp")
vim.lsp.enable("ruff")
vim.lsp.enable("ty")
vim.lsp.enable("tinymist")
