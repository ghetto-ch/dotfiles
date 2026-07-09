vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
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
				yaml = { 'yamlfmt', 'prettier' },
				toml = { 'taplo' },
				kdl = { 'kdlfmt' },
				json = { 'prettier' },
				rust = { 'rustfmt' },
				haskell = { 'fourmolu' },
			},
			formatters = {
				-- v1 used by niri.
				-- Not ideal to specify this here but is my only use case currently
				kdlfmt = {
					args = { 'format', '--kdl-version', 'v1', '-' },
				},
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			},
		})
	end,
})
