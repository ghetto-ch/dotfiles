vim.opt.termguicolors = true
vim.opt.background = 'dark'
vim.cmd('colorscheme base16-ghetto')
vim.opt.wrap = false

require('packer').startup(function(use)
use 'wbthomason/packer.nvim'

use {'junegunn/fzf.vim',
	requires = {'junegunn/fzf'}
}
use {'christoomey/vim-tmux-navigator'}
use {'moll/vim-bbye'}
use {'norcalli/nvim-colorizer.lua',
	config = function() require'colorizer'.setup() end
}
use {'unblevable/quick-scope'}
use {'ghetto-ch/vim-noh'}
use {'dhruvasagar/vim-table-mode'}
use {'winston0410/range-highlight.nvim',
	requires = {'winston0410/cmd-parser.nvim'},
	config = function() require'range-highlight'.setup{} end
}
use {'tversteeg/registers.nvim'}

-- General for programming
use {'tpope/vim-surround',
	requires = {'tpope/vim-repeat'}
}
use {'tpope/vim-commentary',
	requires = {'tpope/vim-repeat'}
}
use {'tpope/vim-endwise'}
use {'rstacruz/vim-closer'}
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
use {'nvim-lua/completion-nvim'}
use {'tjdevries/nlua.nvim'}
use {'hrsh7th/vim-vsnip'}
use {'hrsh7th/vim-vsnip-integ'}
use {'rafamadriz/friendly-snippets'}
use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}

end)

-- LSP and completion #######################################
local lsp_config = require("lspconfig")
local lsp_completion = require("completion")

-- Enable snippets completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local general_on_attach = function(client)
	lsp_completion.on_attach(client)
end

-- Setup basic lsp servers
local servers = { 
	"vimls",
	"bashls",
	"clangd",
	"gopls",
	"pylsp",
	"cssls",
	"html",
	"tsserver" 
}

for _, server in ipairs(servers) do
	lsp_config[server].setup {
		-- Add capabilities
		capabilities = capabilities,
		on_attach = general_on_attach
	}
end

require('nlua.lsp.nvim').setup(require('lspconfig'), {
  on_attach = general_on_attach
  }
)

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

-- nvim-treesitter ###########################################
require'nvim-treesitter.configs'.setup {
	ensure_installed = "all",
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
}

-- treesitter text objects ###################################
require'nvim-treesitter.configs'.setup {
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
	}

-- treesitter text objects ###################################
require'nvim-treesitter.configs'.setup {
    textsubjects = {
        enable = true,
        keymaps = {
            ['.'] = 'textsubjects-smart',
            [';'] = 'textsubjects-container-outer',
        }
    },
}
