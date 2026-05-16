vim.api.nvim_create_autocmd({ 'BufRead', 'BufNew' }, {
	once = true,
	callback = function()
		require('conform').setup({
			formatters_by_ft = {
				lua = { 'stylua' },
				python = { 'ruff_format' },
				c = { 'astyle' },
				go = { 'gofmt' },
				sh = { 'shfmt' },
				fish = { 'fish_indent' },
				nix = { 'nixpkgs_fmt', lsp_format = 'never' },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			},
		})
	end,
})
