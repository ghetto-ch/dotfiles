local map = vim.api.nvim_set_keymap

local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
	vim.cmd 'packadd packer.nvim'
end

vim.api.nvim_exec(
	[[
		augroup Packer
		autocmd!
		autocmd BufWritePost plugins.lua PackerCompile
		augroup end
	]],
	false
)

require('packer').startup(function(use)
use {'wbthomason/packer.nvim'}

-- Common use
use {'nvim-telescope/telescope.nvim',
	requires = {'nvim-lua/plenary.nvim'}
}
use {'christoomey/vim-tmux-navigator'}
use {'moll/vim-bbye'}
use {'norcalli/nvim-colorizer.lua',
	config = function() require'colorizer'.setup() end
}
use {'unblevable/quick-scope'}
use {'ghetto-ch/vim-noh'}
use {'dhruvasagar/vim-table-mode'}

-- General for programming
use {'tpope/vim-surround',
	requires = {'tpope/vim-repeat'}
}
use {'tpope/vim-commentary',
	requires = {'tpope/vim-repeat'}
}
use {'windwp/nvim-autopairs',
	config = function() require('nvim-autopairs').setup{} end
}
use {'jpalardy/vim-slime'}
use {'lewis6991/gitsigns.nvim',
	requires = {'nvim-lua/plenary.nvim'},
	config = function() require('gitsigns').setup() end
}

-- Debug with gdb etc...
use {'sakhnik/nvim-gdb', run = ':!./install.sh'}

-- Text objects
use {'kana/vim-textobj-entire',
	requires = {'kana/vim-textobj-user'}
}
use {'wellle/targets.vim'}
use {'nvim-treesitter/nvim-treesitter-textobjects'}
use {'RRethy/nvim-treesitter-textsubjects'}

-- Completion and snippets
use {'neovim/nvim-lspconfig'}
use {'hrsh7th/nvim-cmp',
	requires = {
		'hrsh7th/vim-vsnip',
		'hrsh7th/cmp-vsnip',
		'hrsh7th/cmp-path',
		'hrsh7th/cmp-nvim-lsp',
		'hrsh7th/cmp-nvim-lua',
	}
}
use {'hrsh7th/vim-vsnip',
	requires = {
		'hrsh7th/vim-vsnip-integ',
		'rafamadriz/friendly-snippets'
	}
}
use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}

-- neovim related
use {'thugcee/nvim-map-to-lua'}

end)

-- LSP and completion #######################################
local lsp_config = require("lspconfig")

-- Enable snippets completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local general_on_attach = function()
	-- lsp_completion.on_attach(client)
	map("n", "gd", "<cmd>lua vim.lsp.buf.declaration()<CR>",
	{ silent = true, noremap = true, })
	map("n", "<c-D>", "<cmd>lua vim.lsp.buf.definition()<CR>",
		{ silent = true, noremap = true, })
	map("n", "gD", "<cmd>lua vim.lsp.buf.implementation()<CR>",
	{ silent = true, noremap = true, })
	map("n", "<c-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>",
	{ silent = true, noremap = true, })
	map("n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>",
	{ silent = true, noremap = true, })
	map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>",
	{ silent = true, noremap = true, })
	map("n", "g0", "<cmd>lua vim.lsp.buf.document_symbol()<CR>",
	{ silent = true, noremap = true, })
	map("n", "gW", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>",
	{ silent = true, noremap = true, })
	map("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<CR>",
	{ silent = true, noremap = true, })
	map("n", "<leader>dn", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
	{ noremap = true, })
	map("n", "<leader>dp", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>",
	{ noremap = true, })

end

-- Setup basic lsp servers
local servers = {
	"vimls",
	"bashls",
	"clangd",
	"gopls",
}

for _, server in ipairs(servers) do
	lsp_config[server].setup {
		-- Add capabilities
		capabilities = capabilities,
		on_attach = general_on_attach
	}
end

-- Lua lsp
local sumneko_root_path = '/usr/share/lua-language-server'
local sumneko_binary = '/usr/bin/lua-language-server'

-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

require('lspconfig').sumneko_lua.setup {
	cmd = { sumneko_binary, '-E', sumneko_root_path .. '/main.lua' },
	on_attach = general_on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = 'LuaJIT',
				-- Setup your lua path
				path = runtime_path,
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { 'vim' },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file('', true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
}

-- customize diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
vim.lsp.diagnostic.on_publish_diagnostics, {
	underline = true,
	virtual_text = {
		spacing = 1,
		prefix = '',
	},
}
)

-- nvim-cmp
local cmp = require'cmp'
cmp.setup({
	completion = {
		keyword_length = 3,
	},
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	mapping = {
		['<CR>'] = cmp.mapping.confirm({ select = true }),
		['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' })
	},
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'nvim_lua' },
		{ name = 'vsnip' },
		{ name = 'path' },
	}
})

-- nvim-treesitter ###########################################
require'nvim-treesitter.configs'.setup {
	ensure_installed = {"c", "lua", "vim", "bash", "go"},
	highlight = {
		enable = true,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "gnn",
			node_incremental = "grn",
			scope_incremental = "grc",
			node_decremental = "grm",
		},
	},
	indent = {
		enable = false
	},
	textobjects = {
		select = {
			enable = true,
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			},
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = "@class.outer",
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer",
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
			},
		},
	},
	textsubjects = {
		enable = true,
		keymaps = {
			['.'] = 'textsubjects-smart',
			[';'] = 'textsubjects-container-outer',
		}
	},
}

-- autopairs #################################################
require("nvim-autopairs.completion.cmp").setup({
  map_cr = true, --  map <CR> on insert mode
  map_complete = true, -- it will auto insert `(` after select function or method item
  auto_select = false -- automatically select the first item
})

-- quick-scope ###############################################
vim.g.qs_highlight_on_keys = {'f', 'F', 't', 'T'}

-- Telescope #################################################
local actions = require('telescope.actions')
require("telescope").setup {
	defaults = {
		mappings = {
			i = {
				["<esc>"] = actions.close
			},
		}
	}
}

-- Fuzzy find files
map("n", "<leader>f", ":Telescope find_files<CR>", { noremap = true, })
map("n", "<leader>o", ":Telescope oldfiles<CR>", { noremap = true, })
map("n", "<leader>gf", ":Telescope git_files<CR>", { noremap = true, })

-- grep
map("n", "<leader>gs", ":Telescope grep_string<CR>", { noremap = true, })
map("n", "<leader>gl", ":Telescope live_grep<CR>", { noremap = true, })

-- The rest
map("n", "\"", ":Telescope registers<CR>", { noremap = true, })
map("n", "<leader>b", ":Telescope builtin<CR>", { noremap = true, })
