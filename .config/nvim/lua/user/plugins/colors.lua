return {
	'rebelot/kanagawa.nvim',
	priority = 1000,
	config = function()
		require('kanagawa').setup({
			transparent = true,
			-- dimInactive = true,

			overrides = function(colors)
				local theme = colors.theme

				return {
					TelescopeTitle = { fg = theme.ui.special, bold = true },
					TelescopeBorder = { bg = 'NONE' },
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
	end,
}
