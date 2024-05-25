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
				enabled = false,
			},
		},
	},
}
