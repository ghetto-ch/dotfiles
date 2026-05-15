local autocmd = vim.api.nvim_create_autocmd

autocmd('TextYankPost', {
	desc = 'Highlight when yanking (copying) text',
	group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- open help in vertical split
vim.api.nvim_create_autocmd('FileType', {
	pattern = 'help',
	command = 'wincmd L',
})

-- Filetypes
vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'asciidoc', 'text', 'gitcommit' },
	callback = function()
		vim.opt_local.wrap = true
	end,
})
