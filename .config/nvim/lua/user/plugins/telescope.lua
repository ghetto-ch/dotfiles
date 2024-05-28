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

		map('n', '<leader>ff', builtin.find_files)
		map('n', '<leader>fg', builtin.git_files)
		map('n', '<leader>gf', builtin.live_grep)
		map('n', '<leader>gs', builtin.grep_string)

		-- Search Neovim configuration files
		map('n', '<leader>fn', function()
			builtin.find_files({ cwd = vim.fn.stdpath('config') })
		end)

		-- registers
		map('n', '"', builtin.registers)
		map('i', '<c-r>', builtin.registers)

		-- The rest
		map('n', '<leader>b', builtin.builtin)

		-- end
	end,
}
