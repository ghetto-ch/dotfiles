local actions = require('telescope.actions')
require("telescope").setup({
	defaults = {
		winblend = 10,
		mappings = {
			i = {
				["<esc>"] = actions.close
			},
		}
	},
	pickers = {
		lsp_code_actions = {
			theme = 'cursor',
		},
		registers = {
			layout_config = {width = 0.5, height = 0.5}
		},
		current_buffer_fuzzy_find = {
			sorting_strategy = 'ascending',
			layout_config = {prompt_position = 'top'},
		},
		file_browser = {
			sorting_strategy = 'ascending',
			layout_config = {prompt_position = 'top'},
		},
	}
})

local M = {}

function M.edit_neovim()
	require('telescope.builtin').find_files({
		cwd = '~/.config/nvim'
	})
end

vim.cmd('command! Televim lua require("tele").edit_neovim()')

function M.dotfiles()
	require('telescope.builtin').git_files({
		cwd = '~/dotfiles'
	})
end

vim.cmd('command! Teledot lua require("tele").dotfiles()')

return M
