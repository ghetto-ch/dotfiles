local function lines()
	return vim.api.nvim_buf_line_count(0)
end

require('lualine').setup({
	options = {
		theme = 'auto',
		component_separators = '',
		section_separators = '',
	},
	sections = {
		lualine_b = { 'diagnostics' },
		lualine_z = { 'location', lines },
	},
})
