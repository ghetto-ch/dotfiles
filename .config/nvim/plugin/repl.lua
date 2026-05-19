local iron = require('iron.core')
local view = require('iron.view')
local common = require('iron.fts.common')

iron.setup({
	config = {
		scratch_repl = true,
		repl_definition = {

			sh = {
				command = { 'bash' },
			},

			python = {
				command = { 'uv', 'run', 'ipython', '--no-autoindent' },
				format = common.bracketed_paste_python,
				block_dividers = { '# %%', '#%%' },
				env = { PYTHON_BASIC_REPL = '1' },
			},

			-- end repl def
		},

		repl_filetype = function(bufnr, ft)
			return ft
		end,

		dap_integration = true,
		repl_open_cmd = view.bottom(15),
	},

	keymaps = {
		toggle_repl = '<space>rt',
		restart_repl = '<space>rr',
		send_motion = '<space>sc',
		visual_send = '<space>sc',
		send_file = '<space>sf',
		send_line = '<space>sl',
		send_paragraph = '<space>sp',
		send_until_cursor = '<space>su',
		send_mark = '<space>sm',
		send_code_block = '<space>sb',
		send_code_block_and_move = '<space>sn',
		mark_motion = '<space>mc',
		mark_visual = '<space>mc',
		remove_mark = '<space>md',
		cr = '<space>s<cr>',
		interrupt = '<space>s<space>',
		exit = '<space>sq',
		clear = '<space>cl',
	},

	highlight = {
		italic = true,
	},

	ignore_blank_lines = true,
})
