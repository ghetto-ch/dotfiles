-- lsp-status ################################################
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

local sumneko_root_path = vim.fn.expand("$HOME").."/tools/lua-language-server"
local sumneko_binary = sumneko_root_path.."/bin/Linux/lua-language-server"
require'lspconfig'.sumneko_lua.setup {
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
    },
  },
}

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
