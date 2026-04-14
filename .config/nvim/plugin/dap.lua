local dap = require("dap")
local dv = require("dap-view")

vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { noremap = true })
vim.keymap.set("n", "<leader>dc", dap.continue, { noremap = true })
vim.keymap.set("n", "<leader>do", dap.step_over, { noremap = true })
vim.keymap.set("n", "<leader>di", dap.step_into, { noremap = true })
vim.keymap.set("n", "<leader>dt", dap.terminate, { noremap = true })
vim.keymap.set("n", "<leader>dv", dv.toggle, { noremap = true })

-- C, C++
dap.adapters.gdb = {
	type = "executable",
	command = "gdb",
	args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
}

dap.configurations.c = {
	{
		name = "Launch",
		type = "gdb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		args = {}, -- provide arguments if needed
		cwd = "${workspaceFolder}",
		stopAtBeginningOfMainSubprogram = false,
	},
	{
		name = "Select and attach to process",
		type = "gdb",
		request = "attach",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		pid = function()
			local name = vim.fn.input("Executable name (filter): ")
			return require("dap.utils").pick_process({ filter = name })
		end,
		cwd = "${workspaceFolder}",
	},
	{
		name = "Attach to gdbserver :1234",
		type = "gdb",
		request = "attach",
		target = "localhost:1234",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
	},
}
dap.configurations.cpp = dap.configurations.c
dap.configurations.rust = dap.configurations.c

-- Python
require("dap-python").setup("uv")

-- GO
require("dap-go").setup()
