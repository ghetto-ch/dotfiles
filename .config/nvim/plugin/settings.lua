local o = vim.opt

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
o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 0
o.smartindent = true

-- Search
o.ignorecase = true
o.smartcase = true

o.inccommand = 'split'

-- o.list = true
o.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

o.splitbelow = true
o.splitright = true

o.wildmode = { 'longest:full', 'full' }
-- o.completeopt = "fuzzy,menuone,preview,noselect"

o.timeoutlen = 2000

o.confirm = true

vim.diagnostic.config({
	virtual_lines = { current_line = true },
})
