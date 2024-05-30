return {
	'folke/trouble.nvim',
	event = { 'BufNewFile', 'BufReadPre' },
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	keys = {
		{
			'<leader>tt',
			'<cmd>Trouble diagnostics toggle<cr>',
			desc = 'Diagnostics (Trouble)',
		},
		{
			'<leader>ts',
			'<cmd>Trouble symbols toggle focus=false<cr>',
			desc = 'Symbols (Trouble)',
		},
		{
			'<leader>tl',
			'<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
			desc = 'LSP Definitions / references / ... (Trouble)',
		},
		{
			'<leader>tq',
			'<cmd>Trouble qflist toggle<cr>',
			desc = 'Quickfix List (Trouble)',
		},
	},
	opts = {},
}
