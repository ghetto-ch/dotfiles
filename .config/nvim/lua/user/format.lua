require('formatter').setup({
	filetype = {

		sh = {
			-- Shell Script Formatter
			function()
				return {
					exe = 'shfmt',
					args = { '-i', 2 },
					stdin = true,
				}
			end,
		},

		lua = {
			function()
				return {
					exe = 'stylua',
					args = {
						'--config-path '
							.. os.getenv('XDG_CONFIG_HOME')
							.. '/stylua/stylua.toml',
						'-',
					},
					stdin = true,
				}
			end,
		},

		c = {
			function()
				return {
					exe = 'astyle',
					args = {},
					stdin = true,
				}
			end,
		},

		cpp = {
			function()
				return {
					exe = 'astyle',
					args = {},
					stdin = true,
				}
			end,
		},

		go = {
			function()
				return {
					exe = 'goimports',
					args = {},
					stdin = true,
				}
			end,
		},
	},
})

vim.api.nvim_exec(
	[[
	augroup FormatAutogroup
		autocmd!
		autocmd BufWritePost *.js,*.rs,*.lua FormatWrite
	augroup END
	]],
	true
)
