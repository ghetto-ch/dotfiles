vim.api.nvim_create_autocmd({ 'BufRead', 'BufNew' }, {
	once = true,
	callback = function()
		require('conform').setup({
			formatters_by_ft = {
				lua = { 'stylua' },
				python = { 'ruff' },
				c = { 'astyle' },
				go = { 'gofmt' },
				sh = { 'shfmt' },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			},
		})
	end,
})
