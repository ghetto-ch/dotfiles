vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
	once = true,
	callback = function()
		vim.cmd.packadd('flash.nvim')
		require('flash').setup({
			modes = {
				search = {
					enabled = true,
				},
				char = {
					enabled = false,
				},
			},
		})

		vim.cmd.packadd('eyeliner.nvim')
		require('eyeliner').setup({})
		vim.api.nvim_set_hl(0, 'EyelinerPrimary', { fg = '#BF0000', bold = true })
		vim.api.nvim_set_hl(0, 'EyelinerSecondary', { fg = '#BF0000' })
	end,
})
