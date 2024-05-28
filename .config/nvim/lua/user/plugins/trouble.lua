return {
	'folke/trouble.nvim',
	event = { 'BufNewFile', 'BufReadPre' },
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
	},
	config = function()
		vim.keymap.set('n', '<leader>xx', function()
			require('trouble').toggle()
		end)

		-- Open search results in quickfix
		local trouble = require('trouble.providers.telescope')

		require('telescope').setup({
			defaults = {
				mappings = {
					i = { ['<c-t>'] = trouble.open_with_trouble },
					n = { ['<c-t>'] = trouble.open_with_trouble },
				},
			},
		})
	end,
}
