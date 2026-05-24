require('kanagawa').setup({
	transparent = true,
	-- dimInactive = true,

	overrides = function(colors)
		local theme = colors.theme

		return {
			TelescopeTitle = { fg = theme.ui.special, bold = true },
			TelescopeBorder = { bg = 'NONE' },
			NormalFloat = { bg = 'NONE' },
			FloatBorder = { bg = 'NONE' },
		}
	end,

	colors = {
		theme = {
			all = {
				ui = {
					bg_gutter = 'NONE',
				},
			},
		},
	},
})

vim.cmd('colorscheme kanagawa')

-- Not directly related to the colorscheme, but still appearance
vim.diagnostic.config({ float = { border = 'rounded' } })
