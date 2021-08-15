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
o.undofile = false
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
