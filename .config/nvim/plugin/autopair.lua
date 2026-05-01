vim.api.nvim_create_autocmd({ 'InsertEnter' }, {
	once = true,
	callback = function()
		require('nvim-autopairs').setup({
			check_ts = true,
			ts_config = {
				lua = { 'string' },
			},
		})
	end,
})
