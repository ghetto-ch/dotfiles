vim.api.nvim_create_autocmd({ 'BufRead', 'BufNew' }, {
	once = true,
	callback = function()
		-- Setup
		local dap = require('dap')
		local dv = require('dap-view')

		require('dap-view').setup({
			auto_toggle = true,
			winbar = {
				show = true,
				default_section = 'scopes',
				controls = {
					enabled = true,
				},
			},

			windows = {
				size = 0.3,
				terminal = {
					size = 0.3,
					position = 'below',
				},
			},

			-- Virtual text inline (richiede Neovim 0.12+)
			virtual_text = {
				enabled = true,
				position = 'inline', -- "inline" | "eol" | "eol_right_align"
				format = function(variable, _, _)
					return ' ' .. variable.value
				end,
			},

			hover = { border = 'rounded' },
			help = { border = 'rounded' },
		})

		-- stylua: ignore start
		vim.api.nvim_set_hl(0, 'DapBrk',  { fg = '#e06c75' })
		vim.api.nvim_set_hl(0, 'DapCond', { fg = '#e5c07b' })
		vim.api.nvim_set_hl(0, 'DapRej',  { fg = '#61afef' })
		vim.api.nvim_set_hl(0, 'DapLog',  { fg = '#61afef' })
		vim.api.nvim_set_hl(0, 'DapStop', { fg = '#98c379',
		                                    bg = '#2d3a2d' })

		vim.fn.sign_define('DapBreakpoint',          { text = '●', texthl = 'DapBrk'  })
		vim.fn.sign_define('DapBreakpointCondition', { text = '◆', texthl = 'DapCond' })
		vim.fn.sign_define('DapBreakpointRejected',  { text = '○', texthl = 'DapRej'  })
		vim.fn.sign_define('DapLogPoint',            { text = '󰆍', texthl = 'DapLog'  })
		vim.fn.sign_define('DapStopped',             { text = '▶', texthl = 'DapStop',
		                                                           linehl = 'DapStop' })

		vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { noremap = true })
		vim.keymap.set('n', '<leader>dc', dap.continue,          { noremap = true })
		vim.keymap.set('n', '<leader>do', dap.step_over,         { noremap = true })
		vim.keymap.set('n', '<leader>di', dap.step_into,         { noremap = true })
		vim.keymap.set('n', '<leader>dt', dap.terminate,         { noremap = true })
		vim.keymap.set('n', '<leader>dv', dv.toggle,             { noremap = true })
		-- stylua: ignore stop

		-- ############################################################################
		-- C, C++
		-- ############################################################################
		dap.adapters.gdb = {
			type = 'executable',
			command = 'gdb',
			args = { '--interpreter=dap', '--eval-command', 'set print pretty on' },
		}

		dap.configurations.c = {
			{
				name = 'Launch',
				type = 'gdb',
				request = 'launch',
				program = function()
					return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
				end,
				args = {}, -- provide arguments if needed
				cwd = '${workspaceFolder}',
				stopAtBeginningOfMainSubprogram = false,
			},
			{
				name = 'Select and attach to process',
				type = 'gdb',
				request = 'attach',
				program = function()
					return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
				end,
				pid = function()
					local name = vim.fn.input('Executable name (filter): ')
					return require('dap.utils').pick_process({ filter = name })
				end,
				cwd = '${workspaceFolder}',
			},
			{
				name = 'Attach to gdbserver :1234',
				type = 'gdb',
				request = 'attach',
				target = 'localhost:1234',
				program = function()
					return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
				end,
				cwd = '${workspaceFolder}',
			},
		}
		dap.configurations.cpp = dap.configurations.c
		dap.configurations.rust = dap.configurations.c

		-- ############################################################################
		-- Python
		-- ############################################################################
		require('dap-python').setup('uv')

		-- ############################################################################
		-- GO
		-- ############################################################################
		require('dap-go').setup()
	end,
})
