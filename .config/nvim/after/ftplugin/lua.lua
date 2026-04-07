vim.treesitter.start()

vim.opt_local.tabstop = 2
vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.wo[0][0].foldmethod = "expr"
vim.wo[0][0].foldlevel = 99

vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
