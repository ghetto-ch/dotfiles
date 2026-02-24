return {
	"kylechui/nvim-surround",
	event = { "BufReadPre", "BufNewFile" },
	version = "*",
	config = function()
		require("nvim-surround").setup({
			highlight = {
				vim.api.nvim_set_hl(0, "NvimSurroundHighlight", { link = "IncSearch" }),
			},
		})
	end,
}
