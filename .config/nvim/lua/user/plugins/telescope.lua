return {
	'nvim-telescope/telescope.nvim',
	event = 'VeryLazy',
	dependencies = {
		'nvim-lua/plenary.nvim',
		{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
		'nvim-tree/nvim-web-devicons',
	},
	config = function()
		local telescope = require('telescope')
		local actions = require('telescope.actions')
		local builtin = require('telescope.builtin')

		telescope.setup({
			defaults = {
				path_display = { 'smart' },
				mappings = {
					i = {
						['<esc>'] = actions.close,
					},
				},
			},
		})

		telescope.load_extension('fzf')

		local map = vim.keymap.set

		map('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
		map('n', '<leader>fg', '<cmd>Telescope git_files<cr>')
		map('n', '<leader>gf', '<cmd>Telescope live_grep<cr>')
		map('n', '<leader>gs', '<cmd>Telescope grep_string<cr>')

		-- Search Neovim configuration files
		map('n', '<leader>fn', function()
			builtin.find_files({ cwd = vim.fn.stdpath('config') })
		end)

		-- registers
		map('n', '"', ':Telescope registers<CR>')
		map('i', '<c-r>', '<Cmd>Telescope registers<CR>')

		-- The rest
		map('n', '<leader>b', ':Telescope builtin<CR>')

		-- end
	end,
}
