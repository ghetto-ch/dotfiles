require("blink.cmp").setup({
	keymap = {
		["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
		["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
		["<CR>"] = { "accept", "fallback" },
	},
	completion = {
		list = {
			selection = { preselect = false, auto_insert = true },
		},
	},
	snippets = {
		preset = "default",
	},
	sources = {
		-- add lazydev to your completion providers
		default = { "lazydev", "lsp", "path", "snippets", "buffer" },
		providers = {
			lazydev = {
				name = "LazyDev",
				module = "lazydev.integrations.blink",
				-- make lazydev completions top priority (see `:h blink.cmp`)
				score_offset = 100,
			},
		},
	},
})
