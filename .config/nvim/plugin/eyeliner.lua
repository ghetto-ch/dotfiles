vim.api.nvim_create_autocmd({ 'BufRead', 'BufNew' }, {
	once = true,
	callback = function()
		require('eyeliner').setup({
			vim.api.nvim_set_hl(0, 'EyelinerPrimary', { fg = '#BF0000', bold = true }),
			vim.api.nvim_set_hl(0, 'EyelinerSecondary', { fg = '#BF0000' }),
		})
	end,
})
