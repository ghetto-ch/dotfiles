require("mason").setup()

require('mason-tool-installer').setup {
  ensure_installed = {
		'vim-language-server',
		'lua-language-server',
		'bash-language-server',
		'clangd',
		'gopls',
		'css-lsp',
		'json-lsp',
		'html-lsp',
		'python-lsp-server',
		'yaml-language-server',
	},
}
