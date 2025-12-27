require("core.options")
require("core.keymaps")
require("lsp")
-- require("core.colors").apply()

-- Load general config
require("config.lazy")

vim.api.nvim_create_user_command("TypstDoc", function()
	vim.fn.jobstart({ "firefox.exe", "--new-tab", "https://typst.app/docs/reference/symbols/sym/" }, { detach = true })
end, {})

vim.lsp.enable("pylsp")
vim.lsp.enable("ruff")
