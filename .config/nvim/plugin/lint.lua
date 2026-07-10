vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
	once = true,
	callback = function()
		require('lint').linters_by_ft = {
			markdown = { 'vale' },
			asciidoc = { 'vale' },
			python = { 'ruff' },
			bash = { 'shellharden', 'shellcheck' },
			haskell = { 'hlint' },
			c = { 'clang-tidy' },
		}

		vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
			callback = function()
				require('lint').try_lint()
			end,
		})
	end,
})
