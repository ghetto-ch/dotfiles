require("oil").setup({
	keymaps = {
		["<C-h>"] = false,
	},
})

-- Open parent directory
vim.keymap.set("n", "-", "<CMD>Oil<CR>")
