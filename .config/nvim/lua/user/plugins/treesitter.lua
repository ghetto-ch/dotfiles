return {
	'nvim-treesitter/nvim-treesitter',
	event = { 'BufReadPre', 'BufNewFile' },
	build = ':TSUpdate',
	dependencies = {
		'nvim-treesitter/nvim-treesitter-textobjects',
		'RRethy/nvim-treesitter-textsubjects',
	},

	config = function()
		local treesitter = require('nvim-treesitter.configs')

		treesitter.setup({

			highlight = {
				enable = true,
			},

			indent = {
				enable = true,
			},

			textobjects = {
				select = {
					enable = true,
					keymaps = {
						-- You can use the capture groups defined in textobjects.scm
						['af'] = '@function.outer',
						['if'] = '@function.inner',
						['ac'] = '@class.outer',
						['ic'] = '@class.inner',
					},
				},
			},

			textsubjects = {
				enable = true,
				prev_selection = ',', -- (Optional) keymap to select the previous selection
				keymaps = {
					['.'] = 'textsubjects-smart',
					[';'] = 'textsubjects-container-outer',
					['i;'] = 'textsubjects-container-inner',
				},
			},

			move = {
				enable = true,
				set_jumps = true, -- whether to set jumps in the jumplist
				goto_next_start = {
					[']f'] = '@function.outer',
					[']c'] = '@class.outer',
				},
				goto_next_end = {
					[']F'] = '@function.outer',
					[']C'] = '@class.outer',
				},
				goto_previous_start = {
					['[f'] = '@function.outer',
					['[c'] = '@class.outer',
				},
				goto_previous_end = {
					['[F'] = '@function.outer',
					['[C'] = '@class.outer',
				},
			},

			ensure_installed = {
				'lua',
				'vimdoc',
				'c',
				'bash',
				'python',
				'fish',
				'nix',
			},
		})
	end,
}
