vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
	once = true,
	callback = function()
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
	end,
})
