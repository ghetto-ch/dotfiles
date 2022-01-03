local telescope = require('telescope')
local actions = require('telescope.actions')
local builtin = require('telescope.builtin')

telescope.setup({
	defaults = {
		winblend = 10,
		mappings = {
			i = {
				['<esc>'] = actions.close,
			},
		},
	},
	pickers = {
		lsp_code_actions = {
			theme = 'cursor',
		},
		registers = {
			layout_config = { width = 0.5, height = 0.5 },
		},
		current_buffer_fuzzy_find = {
			sorting_strategy = 'ascending',
			layout_config = { prompt_position = 'top' },
		},
		file_browser = {
			sorting_strategy = 'ascending',
			layout_config = { prompt_position = 'top' },
		},
	},
})

require('telescope').load_extension('fzf')

local M = {}

function M.edit_neovim()
	builtin.find_files({
		cwd = '~/.config/nvim',
	})
end

vim.cmd('command! Televim lua require("tele").edit_neovim()')

function M.dotfiles()
	builtin.git_files({
		cwd = '~/dotfiles',
	})
end

vim.cmd('command! Teledot lua require("tele").dotfiles()')

return M
