local g = vim.g
local o = vim.opt
local c = vim.cmd
local a = vim.api
local map = vim.api.nvim_set_keymap

g.mapleader = ' '
o.termguicolors = true
o.background = 'dark'
c('colorscheme base16-ghetto')
o.wrap = false
o.textwidth = 0
o.scrolloff = 999
o.runtimepath:append({'~/.local/share/nvim/runtime/'})
o.shell = '/bin/zsh'
o.spelllang = {'it', 'en'}
o.tabstop = 4
o.softtabstop = 4
o.expandtab = false
o.shiftwidth = 0
o.foldnestmax = 1
o.undofile = true
o.path:append({'**'})
o.splitbelow = true
o.splitright = true
o.cursorline = true
o.number = true
o.relativenumber = true
o.numberwidth = 5
o.ignorecase = true
o.smartcase = true
o.inccommand = 'nosplit'
o.wildmenu = true
o.wildmode = {'longest:full', 'full'}
o.mouse = 'a'
o.clipboard:append({'unnamedplus'})
o.lazyredraw = true
o.hidden = true
o.list = true
o.listchars = 'tab:→ ,trail:▒,extends:…,precedes:…,conceal:┊,nbsp:␣'
o.complete:append({'i'})
o.timeoutlen = 1000

map("n", "<up>", "<nop>", { noremap = true, })
map("n", "<down>", "<nop>", { noremap = true, })
map("n", "<left>", "<nop>", { noremap = true, })
map("n", "<right>", "<nop>", { noremap = true, })
map("i", "<up>", "<nop>", { noremap = true, })
map("i", "<down>", "<nop>", { noremap = true, })
map("i", "<left>", "<nop>", { noremap = true, })
map("i", "<right>", "<nop>", { noremap = true, })

-- Search
map("n", "<Esc><Esc>", ":<C-u>nohlsearch<CR>",
	{ noremap = true, })
map("", "<Plug>NohAfter", "zzzo",
	{ noremap = true, })

-- Buffers
map("n", "<C-n>", ":bnext!<CR>", { noremap = true, })
map("v", "<C-n>", ":bnext!<CR>", { noremap = true, })
map("n", "<C-p>", ":bprevious!<CR>", { noremap = true, })
map("v", "<C-p>", ":bprevious!<CR>", { noremap = true, })
map("n", "<M-d>", ":Bdelete<CR>", { noremap = true, })
map("n", "<C-q>", ":quit<CR>", { noremap = true, })

-- Replace selected text pressing C-r, use very nomagic
map("v", "<C-r>", "\"hy:%s/\\V<C-r>h", { noremap = true, })

-- Replace visual selection with yanked text
-- TODO: fix bug when the text to be replaced is at the end of the line.
map("v", "<M-r>", "dh\"0p", { noremap = true, })

-- cd in the directory of the current file
map("n", "<leader>cd", ":cd %:p:h<CR>:pwd<CR>",
	{ noremap = true, })

-- Add semicolon at the end of the line
map("n", "<leader>;", ":normal! mqA;<Esc>`q",
	{ noremap = true, })
-- Add comma at the end of the line
map("n", "<leader>,", ":normal! mqA,<Esc>`q",
	{ noremap = true, })

-- Move lines
map("n", "<A-j>", ":m .+1<CR>==", { noremap = true, })
map("n", "<A-k>", ":m .-2<CR>==", { noremap = true, })
map("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { noremap = true, })
map("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { noremap = true, })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { noremap = true, })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { noremap = true, })

-- Add blank lines
map("n", "]<Space>", ":set paste<CR>m`o<Esc>``:set nopaste<CR>",
	{ silent = true, noremap = true, })
map("n", "[<Space>", ":set paste<CR>m`O<Esc>``:set nopaste<CR>",
	{ silent = true, noremap = true, })

-- Export asciidoc to html and open a preview
map("n", "<leader>a",
":silent !export DISPLAY:=0 &" ..
"asciidoctor -o ~/.var/tmp/surf-preview.html % &&" ..
"surf-preview<CR>",
{ noremap = true, })

