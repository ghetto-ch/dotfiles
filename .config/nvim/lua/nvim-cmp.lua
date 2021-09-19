local cmp = require'cmp'
cmp.setup({
	completion = {
		keyword_length = 3,
	},
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	mapping = {
		['<CR>'] = cmp.mapping.confirm({ select = true }),
		['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' })
	},
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'nvim_lua' },
		{ name = 'vsnip' },
		{ name = 'path' },
	}
})
