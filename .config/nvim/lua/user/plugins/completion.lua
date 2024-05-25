return {
	'hrsh7th/nvim-cmp',
	event = { 'InsertEnter', 'CmdlineEnter' },
	dependencies = {
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-path',
		'hrsh7th/cmp-cmdline',
		'onsails/lspkind.nvim',
	},
	config = function()
		local cmp = require('cmp')
		local lspkind = require('lspkind')

		cmp.setup({
			snippet = {
				expand = function(args)
					vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
				end,
			},

			completion = {
				completeopt = 'menu,menuone,preview,noselect',
			},

			sources = cmp.config.sources({
				{ name = 'luasnip' },
				{ name = 'nvim_lsp' },
				{ name = 'path' },
				{ name = 'buffer' },
			}),

			mapping = cmp.mapping.preset.insert({
				['<C-b>'] = cmp.mapping.scroll_docs(-4),
				['<C-f>'] = cmp.mapping.scroll_docs(4),
				['<C-Space>'] = cmp.mapping.complete(),
				['<C-e>'] = cmp.mapping.abort(),
				['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
				['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' }),
			}),

			formatting = {
				format = lspkind.cmp_format({
					mode = 'symbol_text',
					menu = {
						buffer = '[Buf]',
						path = '[Path]',
						nvim_lsp = '[LSP]',
					},
				}),
			},
		})

		cmp.setup.cmdline('/', {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = 'buffer' },
			},
		})

		cmp.setup.cmdline(':', {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = 'cmdline' },
			},
		})
	end,
}
