vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		local opts = { buffer = ev.buf, silent = true }

		vim.keymap.set('n', 'grd', vim.lsp.buf.definition, opts)
		vim.keymap.set('n', 'grD', vim.lsp.buf.declaration, opts)
	end,
})
