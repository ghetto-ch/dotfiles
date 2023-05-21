-- LSP and completion #######################################
local lsp_config = require('lspconfig')
local bmap = vim.api.nvim_buf_set_keymap

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local general_on_attach = function(client, bufnr)
	require('illuminate').on_attach(client)

	client.server_capabilities.document_formatting = false

	-- stylua: ignore
	local maps = {
		{ 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>' },
		{ 'n', '<c-]>', '<cmd>lua vim.lsp.buf.declaration()<CR>' },
		{ 'n', 'gD', ':Telescope lsp_implementations<CR>' },
		{ 'i', 'c-k', '<cmd>lua vim.lsp.buf.signature_help()<CR>' },
		{ 'n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>' },
		{ 'n', 'gr', ':Telescope lsp_references<CR>' },
		{ 'n', 'g0', ':Telescope lsp_document_symbols<CR>' },
		{ 'n', 'gW', ':Telescope lsp_workspace_symbols<CR>' },
		{ 'n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<CR>' },
		{ 'n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>' },
		{ 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>' },
		{ 'n', '<leader>db', ':vim.diagnostic.open_float<CR>' },
		{ 'n', '<leader>ca', ':vim.lsp.buf.code_action<CR>' },
		{ 'x', '<leader>ca', ':vim.lsp.buf.code_action<CR>' },
		{ 'n', '<A-n>', '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>' },
		{ 'n', '<A-p>', '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>' },
	}

	local opts = { silent = true, noremap = true }

	for _, map in ipairs(maps) do
		bmap(bufnr, map[1], map[2], map[3], opts)
	end
end

require("mason-lspconfig").setup()

-- Setup basic lsp servers
local servers = {
	'vimls',
	'bashls',
	'clangd',
	'gopls',
	'cssls',
	'jsonls',
	'html',
	'pylsp',
	'yamlls',
}

for _, server in ipairs(servers) do
	lsp_config[server].setup({
		-- Add capabilities
		capabilities = capabilities,
		on_attach = general_on_attach,
	})
end

require('lspconfig').lua_ls.setup({
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = 'LuaJIT',
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
vim.lsp.handlers['textDocument/publishDiagnostics'] =
	vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
		underline = true,
		virtual_text = {
			spacing = 1,
			prefix = '',
		},
	})
