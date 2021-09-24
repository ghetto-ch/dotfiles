vim.g.slime_target = 'tmux'
vim.g.slime_default_config = {
	socket_name = 'default',
	target_pane = '{last}',
}
vim.g.slime_dont_ask_default = true
vim.g.slime_no_mappings = true
vim.api.nvim_set_keymap('x', 'gs', '<Plug>SlimeRegionSend', {
	noremap = false,
})
vim.api.nvim_set_keymap('n', 'gss', '<Plug>SlimeLineSend', { noremap = false })
vim.api.nvim_set_keymap('n', 'gs', '<Plug>SlimeMotionSend', {
	noremap = false,
})
