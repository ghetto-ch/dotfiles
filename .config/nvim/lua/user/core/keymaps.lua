local map = vim.keymap.set
vim.g.mapleader = " "

-- Buffers
map('n', '<C-n>', ':bnext!<CR>')
map('x', '<C-n>', ':bnext!<CR>')
map('n', '<C-p>', ':bprevious!<CR>')
map('x', '<C-p>', ':bprevious!<CR>')

-- Add semicolon at the end of the line
map('n', '<leader>;', ':normal! mqA;<Esc>`q')
-- Add comma at the end of the line
map('n', '<leader>,', ':normal! mqA,<Esc>`q')

-- Move lines
map('n', '<A-j>', ':m .+1<CR>==', { noremap = true, silent = true })
map('n', '<A-k>', ':m .-2<CR>==', { noremap = true, silent = true })
map('i', '<A-j>', '<Esc>:m .+1<CR>==gi', { noremap = true, silent = true })
map('i', '<A-k>', '<Esc>:m .-2<CR>==gi', { noremap = true, silent = true })
map('x', '<A-j>', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
map('x', '<A-k>', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })


-- Textobject to select the entire buffer
map('x', 'ae', ':normal! ggVG<CR>', { noremap = true, silent = true })
map('o', 'ae', ':normal! ggVG<CR>', { noremap = true, silent = true })

-- Add blank lines
map('n', ']<Space>', ':set paste<CR>m`o<Esc>``:set nopaste<CR>', { silent = true, noremap = true })
map('n', '[<Space>', ':set paste<CR>m`O<Esc>``:set nopaste<CR>', { silent = true, noremap = true })

-- Navigate quickfix
map('n', ']q', ':cnext<CR>', { noremap = true, silent = true })
map('n', '[q', ':cprev<CR>', { noremap = true, silent = true })

-- Search
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Replace selected text pressing C-r, use very nomagic
map('x', '<C-r>', '"hy:%s/\\V<C-r>h')
