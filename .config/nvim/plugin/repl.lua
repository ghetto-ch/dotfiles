vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
	once = true,
	callback = function()
		require("tunnell").setup({})
		local map = vim.keymap.set
		local opts = { noremap = true, silent = true }
		map("n", "<C-c><C-c>", ":TunnellCell<CR>", opts)
		map("v", "<C-c><C-c>", ":TunnellRange<CR>", opts)
		map("n", "<C-c><C-i>", ":TunnellInsertCellHeader<CR>", opts)

		-- local iron = require('iron.core')
		-- local view = require('iron.view')
		-- local common = require('iron.fts.common')
		--
		-- iron.setup({
		-- 	config = {
		-- 		scratch_repl = true,
		-- 		repl_definition = {
		--
		-- 			python = {
		-- 				command = { 'uv', 'run', 'ipython', '--no-autoindent' },
		-- 				format = common.bracketed_paste_python,
		-- 				block_dividers = { '# %%', '#%%' },
		-- 				env = { PYTHON_BASIC_REPL = '1' },
		-- 			},
		--
		-- 			haskell = {
		-- 				command = { 'cabal', 'repl' },
		-- 			},
		--
		-- 			-- end repl def
		-- 		},
		--
		-- 		dap_integration = true,
		-- 		repl_open_cmd = view.split(15),
		-- 	},
		--
		-- 	keymaps = {
		-- 		toggle_repl = '<space>rt',
		-- 		restart_repl = '<space>rr',
		-- 		send_motion = '<space>sc',
		-- 		visual_send = '<space>sc',
		-- 		send_file = '<space>sf',
		-- 		send_line = '<space>sl',
		-- 		send_paragraph = '<space>sp',
		-- 		send_until_cursor = '<space>su',
		-- 		send_mark = '<space>sm',
		-- 		send_code_block = '<space>sb',
		-- 		send_code_block_and_move = '<space>sn',
		-- 		mark_motion = '<space>mc',
		-- 		mark_visual = '<space>mc',
		-- 		remove_mark = '<space>md',
		-- 		cr = '<space>s<cr>',
		-- 		interrupt = '<space>s<space>',
		-- 		exit = '<space>sq',
		-- 		clear = '<space>cl',
		-- 	},
		--
		-- 	highlight = {
		-- 		italic = true,
		-- 	},
		--
		-- 	ignore_blank_lines = true,
		-- })
	end,
})
