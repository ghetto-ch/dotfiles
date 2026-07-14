require('tunnell').setup({
	target = 'wezterm',
})
local map = vim.keymap.set
local opts = { noremap = true, silent = true }
map('n', '<C-c><C-c>', ':TunnellCell<CR>', opts)
map('v', '<C-c><C-c>', ':TunnellRange<CR>', opts)
map('n', '<C-c><C-i>', ':TunnellInsertCellHeader<CR>', opts)
