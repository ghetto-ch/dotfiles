return {
	'rebelot/kanagawa.nvim',
	priority = 1000,
	config = function()
		require('kanagawa').setup({
			transparent = true,

			-- overrides = function(colors)
			-- 	local theme = colors.theme
			-- 	return {
			-- 		TelescopeTitle = { fg = theme.ui.special, bold = true },
			-- 		TelescopePromptNormal = { bg = theme.ui.bg_p0 },
			-- 		TelescopePromptBorder = { fg = theme.ui.bg_p2, bg = theme.ui.bg_p0 },
			-- 		TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_p0 },
			-- 		TelescopeResultsBorder = { fg = theme.ui.bg_p2, bg = theme.ui.bg_p0 },
			-- 		TelescopePreviewNormal = { bg = theme.ui.bg_p0 },
			-- 		TelescopePreviewBorder = { fg = theme.ui.bg_p2, bg = theme.ui.bg_p0 },
			-- 	}
			-- end,

			overrides = function(colors)
				local theme = colors.theme
				return {
					TelescopeTitle = { fg = theme.ui.special, bold = true },
					TelescopePromptNormal = { bg = theme.ui.bg_p1 },
					TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
					TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
					TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
					TelescopePreviewNormal = { bg = theme.ui.bg_dim },
					TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
				}
			end,

			colors = {
				theme = {
					all = {
						ui = {
							bg_gutter = 'none',
						},
					},
				},
			},
		})

		vim.cmd('colorscheme kanagawa')
	end,
}
