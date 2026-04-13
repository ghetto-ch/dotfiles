vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		local opts = { buffer = ev.buf, silent = true }

		vim.keymap.set("n", "grd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "grr", require("telescope.builtin").lsp_references, opts)
		vim.keymap.set("n", "grD", vim.lsp.buf.declaration, opts)
	end,
})

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			completion = {
				callSnippet = "Replace",
			},
			diagnostics = {
				disable = { "missing-fields" },
			},
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		},
	},
})
vim.lsp.enable("lua_ls")

-- Setup basic lsp servers
local servers = {
	"clangd",
	"ty",
	"gopls",
	"bashls",
}

for _, server in ipairs(servers) do
	vim.lsp.config(server, {
		-- capabilities = capabilities,
	})
	vim.lsp.enable(server)
end
