vim.api.nvim_set_keymap(
	'n',
	'<leader>do',
	':DiffviewOpen<CR>',
	{ noremap = true }
)
vim.api.nvim_set_keymap(
	'n',
	'<leader>dc',
	':DiffviewClose<CR>',
	{ noremap = true }
)
