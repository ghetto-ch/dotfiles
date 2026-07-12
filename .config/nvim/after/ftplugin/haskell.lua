vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.expandtab = true

vim.lsp.config.hls = {
	settings = {
		haskell = {
			formattingProvider = 'fourmolu', -- Specifica Fourmolu come formatter
		},
	},
}
vim.lsp.enable('hls')

vim.treesitter.start()
