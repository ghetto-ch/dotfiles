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
use {'nvim-lua/completion-nvim'}
use {'tjdevries/nlua.nvim'}
use {'hrsh7th/vim-vsnip'}
use {'hrsh7th/vim-vsnip-integ'}
use {'rafamadriz/friendly-snippets'}
use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
use {'thugcee/nvim-map-to-lua'}

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
	-- "cssls",
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

vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.declaration()<CR>", { silent = true, noremap = true, })
vim.api.nvim_set_keymap("n", "<c-]>", "<cmd>lua vim.lsp.buf.definition()<CR>", { silent = true, noremap = true, })
vim.api.nvim_set_keymap("n", "K", ":call <SID>show_documentation()<CR>", { silent = true, noremap = true, })
vim.api.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.implementation()<CR>", { silent = true, noremap = true, })
vim.api.nvim_set_keymap("n", "<c-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { silent = true, noremap = true, })
vim.api.nvim_set_keymap("n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", { silent = true, noremap = true, })
vim.api.nvim_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", { silent = true, noremap = true, })
vim.api.nvim_set_keymap("n", "g0", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", { silent = true, noremap = true, })
vim.api.nvim_set_keymap("n", "gW", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", { silent = true, noremap = true, })
vim.api.nvim_set_keymap("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<CR>", { silent = true, noremap = true, })
vim.api.nvim_set_keymap("n", "<leader>dn", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", { noremap = true, })
vim.api.nvim_set_keymap("n", "<leader>dp", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", { noremap = true, })

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

-- autopairs #################################################
local remap = vim.api.nvim_set_keymap
local npairs = require('nvim-autopairs')

-- skip it, if you use another global object
_G.MUtils= {}

vim.g.completion_confirm_key = ""

MUtils.completion_confirm=function()
  if vim.fn.pumvisible() ~= 0  then
    if vim.fn.complete_info()["selected"] ~= -1 then
      require'completion'.confirmCompletion()
      return npairs.esc("<c-y>")
    else
      vim.api.nvim_select_popupmenu_item(0 , false , false ,{})
      require'completion'.confirmCompletion()
      return npairs.esc("<c-n><c-y>")
    end
  else
    return npairs.autopairs_cr()
  end
end

remap('i' , '<CR>','v:lua.MUtils.completion_confirm()', {expr = true , noremap = true})

-- vim-vsnip #################################################
vim.api.nvim_set_keymap("i", "<c-j>", "vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<Tab>'", { expr = true, })
vim.api.nvim_set_keymap("s", "<c-j>", "vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<Tab>'", { expr = true, })
vim.api.nvim_set_keymap("i", "<c-l>", "vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'", { expr = true, })
vim.api.nvim_set_keymap("s", "<c-l>", "vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'", { expr = true, })

-- FZF #######################################################
vim.g.fzf_preview_window = {'right:50%:nohidden', 'ctrl-/'}

-- quick-scope ###############################################
vim.g.qs_highlight_on_keys = {'f', 'F', 't', 'T'}

