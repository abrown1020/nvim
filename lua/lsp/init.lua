vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufnr = args.buf
		local opts = { buffer = bufnr, silent = true, noremap = true }

		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	end,
})

vim.diagnostic.config({
	-- virtual_lines = true,
	virtual_text = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = true,
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚",
			[vim.diagnostic.severity.WARN] = "󰀪",
			[vim.diagnostic.severity.INFO] = "󰋽",
			[vim.diagnostic.severity.HINT] = "󰌶",
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = "ErrorMsg",
			[vim.diagnostic.severity.WARN] = "WarningMsg",
		},
	},
})

local lsps = {
	{ "rust_analyzer" },
	{ "lua_ls" },
	{ "py_lsp" },
	{ "ruff" },
	{ "ty" },
	{
		"harper_ls",
		{
			settings = {
				["harper-ls"] = {
					userDictPath = vim.fn.stdpath("config") .. "/spell/harper-dict.txt",
					workspaceDictPath = "",
					fileDictPath = "",
					linters = {
						SpellCheck = true,
						SpelledNumbers = true,
						AnA = true,
						SentenceCapitalization = true,
						UnclosedQuotes = true,
						WrongApostrophe = false,
						LongSentences = false,
						RepeatedWords = true,
						Spaces = true,
						CorrectNumberSuffix = true,
					},
					codeActions = {
						ForceStable = false,
					},
					markdown = {
						IgnoreLinkTitle = false,
					},
					diagnosticSeverity = "hint",
					isolateEnglish = false,
					dialect = "American",
					maxFileLength = 120000,
					ignoredLintsPath = "",
					excludePatterns = {},
				},
			},
		},
	},
	{
		"texlab",
		{
			settings = {
				texlab = {
					build = {
						onSave = false,
						forwardSearchAfter = false,
					},
					chktex = {
						onEdit = true,
						onOpenAndSave = true,
					},
				},
			},
		},
	},
	{
		"tinymist",
		{

			cmd = { "tinymist" },
			filetypes = { "typst" },
			settings = {
				formatterMode = "typstyle",
				exportPdf = "onSave",
				semanticTokens = "disable",
			},
			on_attach = function(client, bufnr)
				vim.api.nvim_create_user_command("PinMain", function()
					client:exec_cmd({

						title = "pin",

						command = "tinymist.pinMain",

						arguments = { vim.api.nvim_buf_get_name(0) },
					}, { bufnr = bufnr })

					vim.notify("Main file pinned.", vim.log.levels.INFO)
				end, { desc = "[T]inymist [P]in" })
			end,
		},
	},
	{
		"pylsp",
		{
			cmd = { "pylsp" },
			filetypes = { "python" },
			root_markers = {
				".git",
				"pyproject.toml",
				"setup.py",
				"setup.cfg",
				"requirements.txt",
			},
			settings = {
				pylsp = {
					plugins = {
						-- formatters
						black = { enabled = true },
						autopep8 = { enabled = false },
						yapf = { enabled = false },
						-- linters
						pylint = { enabled = false },
						pyflakes = { enabled = false },
						pycodestyle = { enabled = false },
						-- type checker
						pylsp_mypy = { enabled = false },
						-- completion
						jedi_completion = { fuzzy = true, include_params = true, showroom_variables = true },
						jedi_definition = { enabled = true },

						pyright = { enabled = true },
					},
				},
			},
		},
	},
}

-- see: https://neovim.io/doc/user/news-0.11.html#_lsp
for _, lsp in pairs(lsps) do
	local name, config = lsp[1], lsp[2]
	vim.lsp.enable(name)
	if config then
		vim.lsp.config(name, config)
	end
end
