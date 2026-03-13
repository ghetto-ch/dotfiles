return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	branch = "main",

	config = function()
		require("nvim-treesitter").install({
			"lua",
			"vimdoc",
			"c",
			"bash",
			"python",
			"fish",
		})
	end,
}
