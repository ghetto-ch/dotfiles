vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
	once = true,
	callback = function()
		require('hlchunk').setup({
			chunk = {
				enable = true,
				exclude_filetypes = {
					asciidoc = true,
					markdown = true,
				},
			},
			indent = {
				enable = true,
				exclude_filetypes = {
					asciidoc = true,
					markdown = true,
				},
			},
		})
	end,
})
