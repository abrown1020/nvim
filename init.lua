require("core.options")
require("core.keymaps")
require("lsp")
require("core.colors").apply()
vim.o.completeopt = "menu,menuone,noselect"

-- this is enough to hook up lsp/pylsp.lua:
vim.lsp.enable("pylsp") -- name must match pylsp.lua
-- Load general config
require("config.lazy")
-- Use PowerShell Core
vim.opt.shell = "/usr/bin/zsh"

vim.opt.winbar = "%{%v:lua.require'breadcrumbs'.get_winbar()%}"
vim.opt.showtabline = 0

vim.api.nvim_create_user_command("TypstDoc", function()
	vim.fn.jobstart({ "firefox.exe", "--new-tab", "https://typst.app/docs/reference/symbols/sym/" }, { detach = true })
end, {})

vim.lsp.enable("pylsp")
vim.lsp.enable("ruff")
