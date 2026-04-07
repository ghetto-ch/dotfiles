local telescope = require("telescope")
local builtin = require("telescope.builtin")

-- Open search results in quickfix
-- local trouble = require("trouble.sources.telescope")

telescope.setup({
	defaults = {
		path_display = { "smart" },
		mappings = {
			i = {
				-- ['<esc>'] = actions.close,
				-- ["<c-t>"] = trouble.open,
			},
			n = {
				-- ["<c-t>"] = trouble.open,
			},
		},
	},
})

telescope.load_extension("fzf")

vim.keymap.set("n", "<leader>ff", builtin.find_files)
vim.keymap.set("n", "<leader>fg", builtin.git_files)
vim.keymap.set("n", "<leader>gf", builtin.live_grep)
vim.keymap.set("n", "<leader>gs", builtin.grep_string)

-- Search Neovim configuration files
vim.keymap.set("n", "<leader>fn", function()
	builtin.find_files({ cwd = vim.fn.stdpath("config") })
end)

-- registers
vim.keymap.set("n", '"', builtin.registers)
vim.keymap.set("i", "<c-r>", builtin.registers)

-- The rest
vim.keymap.set("n", "<leader>b", builtin.builtin)
