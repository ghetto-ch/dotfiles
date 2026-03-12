return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	branch = "main",
	dependencies = {
		{ "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
	},

	config = function()
		require("nvim-treesitter").setup({

			require("nvim-treesitter").install({
				"lua",
				"vimdoc",
				"c",
				"bash",
				"python",
				"fish",
			}),
		})
	end,
}
