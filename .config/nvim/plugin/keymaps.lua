local map = vim.keymap.set

local opts = { noremap = true, silent = true }

-- Buffers
map('n', '<C-n>', ':bnext!<CR>', opts)
map('x', '<C-n>', ':bnext!<CR>', opts)
map('n', '<C-p>', ':bprevious!<CR>', opts)
map('x', '<C-p>', ':bprevious!<CR>', opts)
map('n', '<A-d>', ':bdelete<CR>', opts)

-- Add semicolon at the end of the line
map('n', '<leader>;', ':normal! mqA;<Esc>`q', opts)
-- Add comma at the end of the line
map('n', '<leader>,', ':normal! mqA,<Esc>`q', opts)

-- Move lines
map('n', '<A-j>', ':m .+1<CR>==', opts)
map('n', '<A-k>', ':m .-2<CR>==', opts)
map('i', '<A-j>', '<Esc>:m .+1<CR>==gi', opts)
map('i', '<A-k>', '<Esc>:m .-2<CR>==gi', opts)
map('x', '<A-j>', ":m '>+1<CR>gv=gv", opts)
map('x', '<A-k>', ":m '<-2<CR>gv=gv", opts)

-- Textobject to select the entire buffer
map('x', 'ae', ':normal! ggVG<CR>', opts)
map('o', 'ae', ':normal! ggVG<CR>', opts)

-- Add blank lines
map('n', ']<Space>', ':set paste<CR>m`o<Esc>``:set nopaste<CR>', opts)
map('n', '[<Space>', ':set paste<CR>m`O<Esc>``:set nopaste<CR>', opts)

-- Navigate quickfix
map('n', ']q', ':cnext<CR>', opts)
map('n', '[q', ':cprev<CR>', opts)

-- Search
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Replace selected text pressing C-r, use very nomagic
map('x', '<C-r>', '"hy:%s/\\V<C-r>h')

-- Snippets
map({ 'i', 's' }, '<C-l>', function()
	if vim.snippet.active({ direction = 1 }) then
		return '<cmd>lua vim.snippet.jump(1)<cr>'
	else
		return '<C-l>'
	end
end, { expr = true })

map({ 'i', 's' }, '<C-h>', function()
	if vim.snippet.active({ direction = -1 }) then
		return '<cmd>lua vim.snippet.jump(-1)<cr>'
	else
		return '<C-h>'
	end
end, { expr = true })
