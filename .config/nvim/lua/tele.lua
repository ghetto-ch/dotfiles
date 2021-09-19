local actions = require('telescope.actions')
require("telescope").setup({
	defaults = {
		winblend = 10,
		mappings = {
			i = {
				["<esc>"] = actions.close
			},
		}
	}
})

local M = {}

function M.edit_neovim()
	require('telescope.builtin').find_files({
		cwd = '~/.config/nvim'
	})
end

function M.dotfiles()
	require('telescope.builtin').git_files({
		cwd = '~/dotfiles'
	})
end

vim.cmd('command! Teledot lua require("tele").dotfiles()')
vim.cmd('command! Televim lua require("tele").edit_neovim()')
return M
