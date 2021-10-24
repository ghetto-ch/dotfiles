local cmp = require('cmp')
cmp.setup({
	completion = {
		keyword_length = 2,
	},
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},
	mapping = {
		['<C-u>'] = cmp.mapping.scroll_docs(-4),
		['<C-d>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.close(),
		['<CR>'] = cmp.mapping.confirm({ select = true }),
		['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
		['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' }),
	},
	sources = {
		{ name = 'nvim_lua' },
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
		{ name = 'path' },
	},
	formatting = {
		format = require('lspkind').cmp_format({
			with_text = true,
			menu = {
				buffer = '[Buffer]',
				nvim_lsp = '[LSP]',
				luasnip = '[LuaSnip]',
				nvim_lua = '[Lua]',
				latex_symbols = '[Latex]',
			},
		}),
	},
})

local cmp_window = require('cmp.utils.window')
function cmp_window:has_scrollbar()
	return false
end
