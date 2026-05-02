vim.api.nvim_create_autocmd({ 'BufRead', 'BufNew' }, {
	once = true,
	callback = function()
		require('hlchunk').setup({
			chunk = {
				enable = true,
			},
			indent = {
				enable = true,
			},
		})
	end,
})
