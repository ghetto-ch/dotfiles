local M = {}

function M.apply(config)
	config.window_background_opacity = 0.85
	config.enable_tab_bar = false
	config.window_decorations = 'NONE'
	config.color_scheme = nil
	config.colors = {
		foreground = '#dcd7ba',
		-- background = '#000000',

		cursor_bg = '#dcd7ba',
		cursor_border = '#dcd7ba',
		cursor_fg = '#000000',

		selection_fg = '#c8c093',
		selection_bg = '#2d4f67',

		ansi = {
			'#090618',
			'#c34043',
			'#76946a',
			'#c0a36e',
			'#7e9cd8',
			'#957fb8',
			'#6a9589',
			'#c8c093',
		},
		brights = {
			'#727169',
			'#e82424',
			'#98bb6c',
			'#e6c384',
			'#7fb4ca',
			'#938aa9',
			'#7aa89f',
			'#dcd7ba',
		},

		indexed = { [16] = '#ffa066', [17] = '#ff5d62' },
	}
end

return M
