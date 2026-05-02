vim.api.nvim_create_autocmd({ 'BufRead', 'BufNew' }, {
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
