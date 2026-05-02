vim.api.nvim_create_autocmd({ 'BufRead', 'BufNew' }, {
	once = true,
	callback = function()
		require('lint').linters_by_ft = {
			markdown = { 'vale' },
			python = { 'ruff' },
			bash = { 'shellharden' },
		}

		vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
			callback = function()
				require('lint').try_lint()
			end,
		})
	end,
})
