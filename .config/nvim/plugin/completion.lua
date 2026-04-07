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
})
