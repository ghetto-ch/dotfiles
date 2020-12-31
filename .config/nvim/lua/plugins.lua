-- lsp-status
local lsp_status = require('lsp-status')
lsp_status.register_progress()

-- nvim-lsp ##################################################
local on_attach_vim = function(client)
  require'completion'.on_attach(client)
  lsp_status.on_attach(client)
end

require'lspconfig'.clangd.setup{
	on_attach=on_attach_vim,
	handlers = lsp_status.extensions.clangd.setup(),
	init_options = {
		clangdFileStatus = true
	},
	capabilities = lsp_status.capabilities
}

-- require'lspconfig'.ccls.setup{
-- 	on_attach=on_attach_vim,
-- 	capabilities = lsp_status.capabilities
-- }


require'lspconfig'.bashls.setup{
	on_attach=on_attach_vim,
	capabilities = lsp_status.capabilities
}

require'lspconfig'.vimls.setup{
	on_attach=on_attach_vim,
	capabilities = lsp_status.capabilities

}
require'lspconfig'.gopls.setup{
	on_attach=on_attach_vim,
	capabilities = lsp_status.capabilities
}

require('nlua.lsp.nvim').setup(require('lspconfig'), {
	on_attach = on_attach_vim,
	globals = {
		-- Colorbuddy
		"Color", "c", "Group", "g", "s",
	},
	capabilities = lsp_status.capabilities
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = {
      spacing = 4,
      prefix = ' ',
    },
  }
)

-- nvim-treesitter ###########################################
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = false,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  indent = {
    enable = false
  },
}

