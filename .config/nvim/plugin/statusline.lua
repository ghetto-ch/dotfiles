require("lualine").setup({
	options = {
		theme = "auto",
		component_separators = "",
		section_separators = "",
	},
	sections = {
		lualine_b = { "diagnostics" },
	},
})
