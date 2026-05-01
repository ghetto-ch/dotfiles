local function load_telescope()
	local telescope = require('telescope')
	local builtin = require('telescope.builtin')

	telescope.setup({
		defaults = {
			path_display = { 'smart' },
		},
	})

	telescope.load_extension('fzf')

	return builtin
end

vim.keymap.set('n', '<leader>ff', function()
	local builtin = load_telescope()
	builtin.find_files()
end)
vim.keymap.set('n', '<leader>fg', function()
	local builtin = load_telescope()
	builtin.git_files()
end)
vim.keymap.set('n', '<leader>gf', function()
	local builtin = load_telescope()
	builtin.live_grep()
end)
vim.keymap.set('n', '<leader>gs', function()
	local builtin = load_telescope()
	builtin.grep_string()
end)

-- Search Neovim configuration files
vim.keymap.set('n', '<leader>fn', function()
	local builtin = load_telescope()
	builtin.find_files({ cwd = vim.fn.stdpath('config') })
end)

-- registers
vim.keymap.set('n', '"', function()
	local builtin = load_telescope()
	builtin.registers()
end)
vim.keymap.set('i', '<c-r>', function()
	local builtin = load_telescope()
	builtin.registers()
end)

-- The rest
vim.keymap.set('n', '<leader>b', function()
	local builtin = load_telescope()
	builtin.builtin()
end)
