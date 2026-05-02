vim.api.nvim_create_autocmd({ 'BufRead', 'BufNew' }, {
	once = true,
	callback = function()
		require('nvim-surround').setup({
			highlight = {
				vim.api.nvim_set_hl(0, 'NvimSurroundHighlight', { link = 'IncSearch' }),
			},
		})
	end,
})
