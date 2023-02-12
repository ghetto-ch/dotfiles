require('null-ls').setup({
	sources = {
		require('null-ls').builtins.formatting.stylua,
		-- require('null-ls').builtins.formatting.astyle,
		require('null-ls').builtins.formatting.goimports,
		require('null-ls').builtins.formatting.shfmt,
		require('null-ls').builtins.formatting.black,
	},

	on_attach = function(client)
		if client.server_capabilities.document_formatting then
			vim.cmd('autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()')
		end
	end,
})
