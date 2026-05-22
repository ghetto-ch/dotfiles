local autocmd = vim.api.nvim_create_autocmd

autocmd('TextYankPost', {
	desc = 'Highlight when yanking (copying) text',
	group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- open help in vertical split
autocmd('FileType', {
	pattern = 'help',
	command = 'wincmd L',
})

-- Filetypes
autocmd('FileType', {
	pattern = { 'asciidoc', 'text', 'gitcommit' },
	callback = function()
		vim.opt_local.wrap = true
	end,
})

-- Close these buffers with q
autocmd('FileType', {
	pattern = { 'man', 'help', 'qf' },
	callback = function()
		vim.keymap.set('n', 'q', ':quit<CR>', { buffer = true, silent = true })
	end,
})

-- Open diagnostic popup on hover
vim.o.updatetime = 500
vim.api.nvim_create_autocmd('CursorHold', {
	callback = function()
		vim.diagnostic.open_float()
	end,
})
