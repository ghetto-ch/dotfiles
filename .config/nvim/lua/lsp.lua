-- LSP and completion #######################################
local lsp_config = require('lspconfig')
local bmap = vim.api.nvim_buf_set_keymap

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local general_on_attach = function(client, bufnr)
	local opts = { silent = true, noremap = true }
	-- stylua: ignore
	local maps = {
		{ 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts },
		{ 'n', '<c-]>', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts },
		{ 'n', 'gD', ':Telescope lsp_implementations<CR>', opts },
		{ 'i', 'c-k', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts },
		{ 'n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts },
		{ 'n', 'gr', ':Telescope lsp_references<CR>', opts },
		{ 'n', 'g0', ':Telescope lsp_document_symbols<CR>', opts },
		{ 'n', 'gW', ':Telescope lsp_workspace_symbols<CR>', opts },
		{ 'n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<CR>', opts },
		{ 'n', '<leader>dn', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts },
		{ 'n', '<leader>dp', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts },
		{ 'n', '<leader>db', ':Telescope lsp_document_diagnostics<CR>', opts },
		{ 'n', '<leader>dw', ':Telescope lsp_workspace_diagnostics<CR>', opts },
		{ 'n', '<leader>ca', ':Telescope lsp_code_actions<CR>', opts },
		{ 'v', '<leader>ca', ':Telescope lsp_code_actions<CR>', opts },
		{ 'n', '<A-n>', '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>', opts },
		{ 'n', '<A-p>', '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>', opts },
	}

	require('illuminate').on_attach(client)

	for _, map in ipairs(maps) do
		bmap(bufnr, map[1], map[2], map[3], map[4])
	end
end

-- Setup basic lsp servers
local servers = {
	'vimls',
	'bashls',
	'clangd',
	'gopls',
	'cssls',
	'jsonls',
	'html',
}

for _, server in ipairs(servers) do
	lsp_config[server].setup({
		-- Add capabilities
		capabilities = capabilities,
		on_attach = general_on_attach,
	})
end

-- Lua lsp
local sumneko_root_path = '/usr/share/lua-language-server'
local sumneko_binary = '/usr/bin/lua-language-server'

-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

require('lspconfig').sumneko_lua.setup({
	cmd = { sumneko_binary, '-E', sumneko_root_path .. '/main.lua' },
	on_attach = general_on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = 'LuaJIT',
				-- Setup your lua path
				path = runtime_path,
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { 'vim' },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file('', true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})

-- customize diagnostics
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics,
	{
		underline = true,
		virtual_text = {
			spacing = 1,
			prefix = '',
		},
	}
)
