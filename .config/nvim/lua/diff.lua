vim.api.nvim_set_keymap('n', '<leader>dv', ':Gvdiffsplit!<CR>', { noremap = true })

-- mergetool mappings
vim.api.nvim_set_keymap(
	'n',
	'dgh',
	':diffget //2|diffupdate<CR>',
	{ noremap = true }
)
vim.api.nvim_set_keymap(
	'n',
	'dgl',
	':diffget //3|diffupdate<CR>',
	{ noremap = true }
)
