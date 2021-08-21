local g = vim.g
local o = vim.opt
local c = vim.cmd

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
o.timeoutlen = 2000

vim.api.nvim_set_keymap("n", "<up>", "<nop>", { noremap = true, })
vim.api.nvim_set_keymap("n", "<down>", "<nop>", { noremap = true, })
vim.api.nvim_set_keymap("n", "<left>", "<nop>", { noremap = true, })
vim.api.nvim_set_keymap("n", "<right>", "<nop>", { noremap = true, })
vim.api.nvim_set_keymap("i", "<up>", "<nop>", { noremap = true, })
vim.api.nvim_set_keymap("i", "<down>", "<nop>", { noremap = true, })
vim.api.nvim_set_keymap("i", "<left>", "<nop>", { noremap = true, })
vim.api.nvim_set_keymap("i", "<right>", "<nop>", { noremap = true, })

-- Search
vim.api.nvim_set_keymap("n", "<Esc><Esc>", ":<C-u>nohlsearch<CR>", { noremap = true, })
vim.api.nvim_set_keymap("", "<Plug>NohAfter", "zzzo", { noremap = true, })

-- Buffers
vim.api.nvim_set_keymap("n", "<C-n>", ":bnext!<CR>", { noremap = true, })
vim.api.nvim_set_keymap("v", "<C-n>", ":bnext!<CR>", { noremap = true, })
vim.api.nvim_set_keymap("n", "<C-p>", ":bprevious!<CR>", { noremap = true, })
vim.api.nvim_set_keymap("v", "<C-p>", ":bprevious!<CR>", { noremap = true, })
vim.api.nvim_set_keymap("n", "<M-d>", ":Bdelete<CR>", { noremap = true, })
vim.api.nvim_set_keymap("n", "<C-q>", ":quit<CR>", { noremap = true, })

-- Replace selected text pressing C-r, use very nomagic
vim.api.nvim_set_keymap("v", "<C-r>", "\"hy:%s/\\V<C-r>h", { noremap = true, })

-- Replace visual selection with yanked text
-- TODO: fix bug when the text to be replaced is at the end of the line.
vim.api.nvim_set_keymap("v", "<M-r>", "dh\"0p", { noremap = true, })

-- Fuzzy find files
vim.api.nvim_set_keymap("n", "<leader>f", ":Files<CR>", { noremap = true, })
vim.api.nvim_set_keymap("n", "<leader>h", ":History<CR>", { noremap = true, })

-- Ripgrep
vim.api.nvim_set_keymap("n", "<leader>g", ":Rg<CR>", { noremap = true, })

-- cd in the directory of the current file
vim.api.nvim_set_keymap("n", "<leader>cd", ":cd %:p:h<CR>:pwd<CR>", { noremap = true, })

-- Add semicolon at the end of the line
vim.api.nvim_set_keymap("n", "<leader>;", ":normal! mqA;<Esc>`q", { noremap = true, })
-- Add comma at the end of the line
vim.api.nvim_set_keymap("n", "<leader>,", ":normal! mqA,<Esc>`q", { noremap = true, })

-- Move lines
vim.api.nvim_set_keymap("n", "<A-j>", ":m .+1<CR>==", { noremap = true, })
vim.api.nvim_set_keymap("n", "<A-k>", ":m .-2<CR>==", { noremap = true, })
vim.api.nvim_set_keymap("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { noremap = true, })
vim.api.nvim_set_keymap("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { noremap = true, })
vim.api.nvim_set_keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", { noremap = true, })
vim.api.nvim_set_keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", { noremap = true, })

-- Add blank lines
vim.api.nvim_set_keymap("n", "]<Space>", ":set paste<CR>m`o<Esc>``:set nopaste<CR>", { silent = true, noremap = true, })
vim.api.nvim_set_keymap("n", "[<Space>", ":set paste<CR>m`O<Esc>``:set nopaste<CR>", { silent = true, noremap = true, })

-- Export asciidoc to html and open a preview
vim.api.nvim_set_keymap("n", "<leader>a", ":silent !export DISPLAY:=0 & asciidoctor -o ~/.var/tmp/surf-preview.html % && surf-preview<CR>", { noremap = true, })


