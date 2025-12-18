-- Load general config
require("core.options")
require("core.keymaps")

-- Set up Lazy plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv or not vim.uv.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		lazyrepo,
		lazypath,
	})
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Set up plugins
require("lazy").setup({
	{ import = "plugins" },
	{ import = "plugins.lsp" },
	checker = {
		enabled = false,
		notify = false,
	},
	change_detection = {
		notify = false,
	},
})

-- Use PowerShell Core
vim.opt.shell = "/usr/bin/zsh"

vim.opt.winbar = "%{%v:lua.require'breadcrumbs'.get_winbar()%}"
vim.opt.showtabline = 0

-- vim.o.termguicolors = true
require("core.colors").apply()

vim.api.nvim_create_user_command("TypstDoc", function()
	vim.fn.jobstart({ "firefox.exe", "--new-tab", "https://typst.app/docs/reference/symbols/sym/" }, { detach = true })
end, {})
