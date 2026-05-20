vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
	once = true,
	callback = function()
		-- Setup
		local dap = require('dap')
		local dv = require('dap-view')

		require('dap-view').setup({
			auto_toggle = true,
			winbar = {
				show = true,
				sections = {
					'watches',
					'scopes',
					'exceptions',
					'breakpoints',
					'threads',
					'repl',
					-- 'console',
				},
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
		local hl = vim.api.nvim_set_hl
		hl(0, 'DapBrk',  { fg = '#e06c75' })
		hl(0, 'DapCond', { fg = '#e5c07b' })
		hl(0, 'DapRej',  { fg = '#61afef' })
		hl(0, 'DapLog',  { fg = '#61afef' })
		hl(0, 'DapStop', { fg = '#98c379', bg = '#2d3a2d' })

		local sign = vim.fn.sign_define
		sign('DapBreakpoint',          { text = '●', texthl = 'DapBrk'  })
		sign('DapBreakpointCondition', { text = '◆', texthl = 'DapCond' })
		sign('DapBreakpointRejected',  { text = '○', texthl = 'DapRej'  })
		sign('DapLogPoint',            { text = '󰆍', texthl = 'DapLog'  })
		sign('DapStopped',             { text = '▶', texthl = 'DapStop',
		                                             linehl = 'DapStop' })

		local map = vim.keymap.set
		map('n', '<leader>db', dap.toggle_breakpoint, { noremap = true })
		map('n', '<leader>dc', dap.continue,          { noremap = true })
		map('n', '<leader>do', dap.step_over,         { noremap = true })
		map('n', '<leader>di', dap.step_into,         { noremap = true })
		map('n', '<leader>dt', dap.terminate,         { noremap = true })
		map('n', '<leader>dv', dv.toggle,             { noremap = true })
		map('n', '<leader>dw', dv.add_expr,           { noremap = true })
		-- stylua: ignore stop
		map('n', '<leader>ds', function()
			dap.set_breakpoint(vim.fn.input('Condition: '))
		end,
		{ noremap = true })

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
