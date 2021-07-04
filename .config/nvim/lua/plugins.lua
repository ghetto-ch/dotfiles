local lsp_config = require("lspconfig")
local lsp_completion = require("completion")

--Enable snippets completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local general_on_attach = function(client)
	lsp_completion.on_attach(client)
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
		enable = true,
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

-- treesitter text objects ###################################
require'nvim-treesitter.configs'.setup {
	textobjects = {
		select = {
			enable = true,
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
				},
			},
			move = {
				enable = true,
				set_jumps = true, -- whether to set jumps in the jumplist
				goto_next_start = {
					["]m"] = "@function.outer",
					["]]"] = "@class.outer",
				},
				goto_next_end = {
					["]M"] = "@function.outer",
					["]["] = "@class.outer",
				},
				goto_previous_start = {
					["[m"] = "@function.outer",
					["[["] = "@class.outer",
				},
				goto_previous_end = {
					["[M"] = "@function.outer",
					["[]"] = "@class.outer",
				},
			},
		},
	}
