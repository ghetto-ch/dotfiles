local o = vim.opt

vim.g.c_syntax_for_h = 1

o.undofile = true
o.clipboard = 'unnamedplus'

-- Visual settings
o.termguicolors = true
o.signcolumn = 'yes'
o.cursorline = true
o.relativenumber = true
o.number = true
o.wrap = false
o.scrolloff = 999

-- Indentation
o.tabstop = 4
o.softtabstop = 4
o.expandtab = false
o.smartindent = true
o.shiftwidth = 4

-- Search
o.ignorecase = true
o.smartcase = true

o.inccommand = 'split'

-- o.list = true
o.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

o.splitbelow = true
o.splitright = true

o.wildmode = { 'longest:full', 'full' }
o.completeopt = { 'menu', 'menuone', 'noselect' }

o.timeoutlen = 2000

o.confirm = true

-- vim.diagnostic.config({
-- 	virtual_lines = { current_line = true },
-- })

-- vim.diagnostic.config({
-- 	virtual_text = { current_line = true },
-- })
