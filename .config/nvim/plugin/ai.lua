vim.g.opeocode_opts = {
	server = {
		url = "http://localhost", -- o 'http://127.0.0.1'
		port = 4096, -- deve corrispondere alla porta scelta sopra
		timeout = 10,
	},
	opencode_executable = "opencode", -- assicurati che sia nel tuo PATH
}

vim.keymap.set({ "n", "x" }, "<leader>ca", function()
	require("opencode").ask("@this: ", { submit = true })
end, { desc = "Ask opencode…" })
vim.keymap.set({ "n", "x" }, "<leader>cx", function()
	require("opencode").select()
end, { desc = "Execute opencode action…" })
vim.keymap.set({ "n", "t" }, "<leader>ct", function()
	require("opencode").toggle()
end, { desc = "Toggle opencode" })

vim.keymap.set({ "n", "x" }, "go", function()
	return require("opencode").operator("@this ")
end, { desc = "Add range to opencode", expr = true })
vim.keymap.set("n", "goo", function()
	return require("opencode").operator("@this ") .. "_"
end, { desc = "Add line to opencode", expr = true })

vim.keymap.set("n", "<S-C-u>", function()
	require("opencode").command("session.half.page.up")
end, { desc = "Scroll opencode up" })
vim.keymap.set("n", "<S-C-d>", function()
	require("opencode").command("session.half.page.down")
end, { desc = "Scroll opencode down" })
