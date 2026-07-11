vim.api.nvim_create_autocmd({ "InsertEnter" }, {
	once = true,
	callback = function()
		require("nvim-autopairs").setup({
			check_ts = true,
			ts_config = {
				lua = { "string" },
			},
		})

		require("nvim-surround").setup({
			highlight = {
				vim.api.nvim_set_hl(0, "NvimSurroundHighlight", { link = "IncSearch" }),
			},
		})
	end,
})
