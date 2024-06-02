return {
	'neovim/nvim-lspconfig',
	event = { 'BufReadPre', 'BufNewFile' },
	dependencies = {
		{
			'folke/lazydev.nvim',
			ft = 'lua', -- only load on lua files
			opts = {
				library = {
					vim.env.LAZY .. '/luvit-meta/library', -- see below
				},
			},
		},
		'Bilal2453/luvit-meta', -- optional `vim.uv` typings
		'hrsh7th/cmp-nvim-lsp',
	},

	config = function()
		local lspconfig = require('lspconfig')
		local cmp_nvim_lsp = require('cmp_nvim_lsp')
		local map = vim.keymap.set

		vim.api.nvim_create_autocmd('LspAttach', {
			group = vim.api.nvim_create_augroup('UserLspConfig', {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }

				map('n', 'gd', vim.lsp.buf.definition, opts)
				map('n', '<c-]>', vim.lsp.buf.declaration, opts)
				map('n', 'gD', require('telescope.builtin').lsp_implementations, opts)
				map('i', '<c-k>', vim.lsp.buf.signature_help, opts)
				map('n', 'gt', vim.lsp.buf.type_definition, opts)
				map('n', 'gr', require('telescope.builtin').lsp_references, opts)
				map('n', '<F2>', vim.lsp.buf.rename, opts)
				map('n', ']d', vim.diagnostic.goto_next, opts)
				map('n', '[d', vim.diagnostic.goto_prev, opts)
				map('n', '<leader>db', vim.diagnostic.open_float, opts)
				map('n', '<leader>ca', vim.lsp.buf.code_action, opts)
				map('x', '<leader>ca', vim.lsp.buf.code_action, opts)
			end,
		})

		local capabilities = cmp_nvim_lsp.default_capabilities()

		lspconfig['lua_ls'].setup({
			settings = {
				Lua = {
					completion = {
						callSnippet = 'Replace',
					},
					diagnostics = {
						disable = { 'missing-fields' },
					},
				},
			},
		})

		-- Setup basic lsp servers
		local servers = {
			'clangd',
			'pylsp',
		}

		for _, server in ipairs(servers) do
			lspconfig[server].setup({
				capabilities = capabilities,
			})
		end
	end,
}
