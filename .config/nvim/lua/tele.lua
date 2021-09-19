local actions = require('telescope.actions')
require("telescope").setup({
	defaults = {
		winblend = 10,
		mappings = {
			i = {
				["<esc>"] = actions.close
			},
		}
	}
})

