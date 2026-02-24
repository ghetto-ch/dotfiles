return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{
			"folke/lazydev.nvim",
			ft = "lua", -- only load on lua files
			opts = {
				library = {
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		},
		{ -- optional completion source for require statements and module annotations
			"hrsh7th/nvim-cmp",
			opts = function(_, opts)
				opts.sources = opts.sources or {}
				table.insert(opts.sources, {
					name = "lazydev",
					group_index = 0, -- set group index to 0 to skip loading LuaLS completions
				})
			end,
		},
		"hrsh7th/cmp-nvim-lsp",
	},

	config = function()
		-- local lspconfig = require('lspconfig')
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local map = vim.keymap.set

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }

				map("n", "grd", require("telescope.builtin").lsp_definitions, opts)
				map("n", "grr", require("telescope.builtin").lsp_references, opts)
				map("n", "grD", vim.lsp.buf.declaration, opts)
			end,
		})

		local capabilities = cmp_nvim_lsp.default_capabilities()

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
			"pyright",
			"fish_lsp",
			"bashls",
			"zls",
			"zk",
		}

		for _, server in ipairs(servers) do
			vim.lsp.config(server, {
				capabilities = capabilities,
			})
			vim.lsp.enable(server)
		end
	end,
}
