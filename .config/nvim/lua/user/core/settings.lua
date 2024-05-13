vim.cmd('let g:netrw_liststyle = 3')
local o = vim.opt

o.undofile = true

o.termguicolors = true

o.signcolumn = 'yes'
o.cursorline = true
o.relativenumber = true
o.number = true
o.wrap = false
o.scrolloff = 999

o.ignorecase = true
o.smartcase = true

o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 0
o.smartindent = true

o.inccommand = 'split'

o.list = true
o.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

o.splitbelow = true
o.splitright = true

o.wildmode = { 'longest:full', 'full' }

o.timeoutlen = 2000
