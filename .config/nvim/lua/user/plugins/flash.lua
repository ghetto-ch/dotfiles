return {
	'folke/flash.nvim',
	event = { 'BufReadPre', 'BufNewFile' },
	---@type Flash.Config
	opts = {
		modes = {
			search = {
				enabled = true,
			},
			char = {
				enabled = true,
			},
		},
	},
	keys = {
		{
			'<c-f>',
			mode = 'c',
			function()
				require('flash').toggle()
			end,
		},
	},
}
