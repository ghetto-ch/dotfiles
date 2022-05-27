local o = vim.opt
local c = vim.cmd
local map = vim.keymap.set

o.termguicolors = true
o.background = 'dark'
c('colorscheme base16-ghetto')
o.wrap = false
o.textwidth = 0
o.scrolloff = 999
o.runtimepath:append({ '~/.local/share/nvim/runtime/' })
o.shell = '/bin/zsh'
o.spelllang = { 'it', 'en' }
o.tabstop = 2
o.softtabstop = 2
o.expandtab = false
o.shiftwidth = 0
o.foldnestmax = 1
o.undofile = true
o.path:append({ '**' })
o.splitbelow = true
o.splitright = true
o.cursorline = false
o.number = true
o.relativenumber = true
o.numberwidth = 5
o.signcolumn = 'yes'
o.ignorecase = true
o.smartcase = true
o.inccommand = 'nosplit'
o.wildmenu = true
o.wildmode = { 'longest:full', 'full' }
o.mouse = 'a'
o.clipboard:append({ 'unnamedplus' })
o.lazyredraw = true
o.hidden = true
o.list = true
o.listchars = 'tab:→ ,trail:▒,extends:…,precedes:…,conceal:┊,nbsp:␣'
o.complete:append({ 'i' })
o.timeoutlen = 2000
o.pumblend = 10
o.laststatus = 3

map('n', '<up>', '<nop>')
map('n', '<down>', '<nop>')
map('n', '<left>', '<nop>')
map('n', '<right>', '<nop>')
map('i', '<up>', '<nop>')
map('i', '<down>', '<nop>')
map('i', '<left>', '<nop>')
map('i', '<right>', '<nop>')

-- Search
map('n', '<Esc><Esc>', ':<C-u>nohlsearch<CR>')
map('', '<Plug>NohAfter', 'zz', { noremap = true, silent = true })

-- Buffers
map('n', '<C-n>', ':bnext!<CR>')
map('x', '<C-n>', ':bnext!<CR>')
map('n', '<C-p>', ':bprevious!<CR>')
map('x', '<C-p>', ':bprevious!<CR>')
map('n', '<M-d>', ':Bdelete<CR>')
map('n', '<C-q>', ':quit<CR>')

-- Replace selected text pressing C-r, use very nomagic
map('x', '<C-r>', '"hy:%s/\\V<C-r>h')

-- Replace visual selection with yanked text
-- FIXME: fix bug when the text to be replaced is at the end of the line.
map('x', '<M-r>', 'dh"0p')

-- cd in the directory of the current file
map('n', '<leader>cd', ':cd %:p:h<CR>:pwd<CR>')

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
map(
	'n',
	']<Space>',
	':set paste<CR>m`o<Esc>``:set nopaste<CR>',
	{ silent = true, noremap = true }
)
map(
	'n',
	'[<Space>',
	':set paste<CR>m`O<Esc>``:set nopaste<CR>',
	{ silent = true, noremap = true }
)

-- Navigate quickfix
map('n', ']q', ':cnext<CR>', { noremap = true, silent = true })
map('n', '[q', ':cprev<CR>', { noremap = true, silent = true })

-- Export asciidoc to html and open a preview
map(
	'n',
	'<leader>a',
	':silent !export DISPLAY:=0 &'
	.. 'asciidoctor -o ~/.var/tmp/surf-preview.html % &&'
	.. 'surf-preview<CR>',
	{ noremap = true }
)

-- -- Fuzzy find files
map('n', '<leader>f', ':Telescope find_files<CR>')
map('n', '<leader>o', ':Telescope oldfiles<CR>')
map('n', '<leader>gf', ':Telescope git_files<CR>')
map('n', '<leader>df', ':Teledot<CR>')
map('n', '<leader>nf', ':Televim<CR>')

-- grep
map('n', '<leader>gs', ':Telescope grep_string<CR>')
map('n', '<leader>gl', ':Telescope live_grep<CR>')
-- Grep current buffer with <C-/>
map('n', '<c-_>', ':Telescope current_buffer_fuzzy_find<CR>')

-- The rest
map('n', '<leader>b', ':Telescope builtin<CR>')

-- registers
map('n', '"', ':Telescope registers<CR>')
map('i', '<c-r>', '<Cmd>Telescope registers<CR>')
