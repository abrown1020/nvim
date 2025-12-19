return {
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

				pyright = { enabled = true },
			},
		},
	},
}
