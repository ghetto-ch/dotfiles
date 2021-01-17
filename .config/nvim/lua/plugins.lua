local lsp_config = require("lspconfig")
local lsp_completion = require("completion")

--Enable completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local general_on_attach = function(client, bufnr)
	lsp_completion.on_attach(client, bufnr)
	-- if client.resolved_capabilities.completion then
	-- 	lsp_completion.on_attach(client, bufnr)
	-- end
end

-- Setup basic lsp servers
for _, server in pairs({"html", "clangd", "gopls", "html", "bashls", "vimls", "tsserver", "cssls", "pyls"}) do
	lsp_config[server].setup {
		-- Add capabilities
		capabilities = capabilities,
		on_attach = general_on_attach
	}
end

require('nlua.lsp.nvim').setup(require('lspconfig'), {
  on_attach = general_on_attach
  }
)

-- customize diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
vim.lsp.diagnostic.on_publish_diagnostics, {
	underline = true,
	virtual_text = {
		spacing = 1,
		prefix = '',
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

-- colorizer #################################################
require'colorizer'.setup()

-- nvim.cheat.sh
vim.g.cheat_default_window_layout = 'vertical_split'
