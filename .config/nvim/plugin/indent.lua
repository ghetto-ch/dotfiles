vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
	once = true,
	callback = function()
		vim.cmd.packadd('hlchunk.nvim')
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
