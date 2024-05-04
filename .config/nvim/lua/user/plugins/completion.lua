return {
	'hrsh7th/nvim-cmp',
	event = 'InsertEnter',
	dependencies = {
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-path',
		'onsails/lspkind.nvim',
		'saadparwaiz1/cmp_luasnip',
	},
	config = function()
		local cmp = require('cmp')
		local lspkind = require('lspkind')

		cmp.setup({
			snippet = {
				expand = function(args)
					require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
					-- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
				end,
			},

			completion = {
				completeopt = 'menu,menuone,preview,noselect',
			},

			sources = cmp.config.sources({
				{ name = 'buffer' },
				{ name = 'path' },
				{ name = 'luasnip' },
				{ name = 'nvim_lsp' },
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
		})
	end,
}
