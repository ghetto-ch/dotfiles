return {
	'stevearc/oil.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	config = function()
		require('oil').setup({
			keymaps = {
				['<C-h>'] = false,
			},
		})

		-- Open parent directory
		vim.keymap.set('n', '-', '<CMD>Oil<CR>')
	end,
}
