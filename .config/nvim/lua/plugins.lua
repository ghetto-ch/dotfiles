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
use {'nvim-lua/plenary.nvim'}

use {'nvim-telescope/telescope.nvim',
	opt = true,
	cmd = {'Telescope', 'Teledot', 'Televim'},
	requires = {'nvim-lua/plenary.nvim'},
	config = function ()
		require('tele')
	end
}

use {'christoomey/vim-tmux-navigator'}

use {'moll/vim-bbye'}

use {'norcalli/nvim-colorizer.lua',
	opt = true,
	event = {'BufReadPre', 'BufRead', 'BufNew'},
	config = function()
		require('colorizer').setup()
	end,
}

use {'unblevable/quick-scope',
	config = function ()
		vim.g.qs_highlight_on_keys = {'f', 'F', 't', 'T'}
	end
}

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
	opt = true,
	event = {'BufReadPost'},
	config = function()
		require('nvim-autopairs').setup({
			map_cr = true, --  map <CR> on insert mode
			map_complete = true, -- it will auto insert `(` after select function or method item
			auto_select = false -- automatically select the first item
		})
	end
}

use {'jpalardy/vim-slime',
	config = function ()
		vim.g.slime_target = 'tmux'
		vim.g.slime_default_config = {socket_name = 'default', target_pane = '{last}'}
		vim.g.slime_dont_ask_default = true
		vim.g.slime_no_mappings = true
		vim.api.nvim_set_keymap("x", "gs", "<Plug>SlimeRegionSend", { noremap = false, })
		vim.api.nvim_set_keymap("n", "gss", "<Plug>SlimeLineSend", { noremap = false, })
		vim.api.nvim_set_keymap("n", "gs", "<Plug>SlimeMotionSend", { noremap = false, })
	end
}

use {'lewis6991/gitsigns.nvim',
	opt = true,
	event = {'BufReadPost'},
	requires = {'nvim-lua/plenary.nvim'},
	config = function()
		require('gitsigns').setup({
			signs = {
				add = { hl = 'GitGutterAdd', text = '+' },
				change = { hl = 'GitGutterChange', text = '~' },
				delete = { hl = 'GitGutterDelete', text = '_' },
				topdelete = { hl = 'GitGutterDelete', text = '‾' },
				changedelete = { hl = 'GitGutterChange', text = '~' },
			},
		})
	end,
}

use {'sindrets/diffview.nvim'}

-- Debug with gdb etc...
use {'sakhnik/nvim-gdb', run = ':!./install.sh'}

-- Text objects
use {'kana/vim-textobj-entire',
	requires = {'kana/vim-textobj-user'}
}

use {'wellle/targets.vim'}

use {'nvim-treesitter/nvim-treesitter-textobjects',
	opt = true,
	after = 'nvim-treesitter',
	branch = '0.5-compat',
}

use {'RRethy/nvim-treesitter-textsubjects',
	opt = true,
	after = 'nvim-treesitter'
}

-- Completion and snippets
use {'neovim/nvim-lspconfig',
	opt = true,
	after = 'nvim-cmp',
	config = function ()
		require('lsp')
	end
}

use {'hrsh7th/nvim-cmp',
	opt = true,
	event = {'BufReadPre', 'BufRead', 'BufNew'},
	requires = {
		'saadparwaiz1/cmp_luasnip',
		'hrsh7th/cmp-path',
		'hrsh7th/cmp-nvim-lsp',
		'hrsh7th/cmp-nvim-lua',
	},
	config = function ()
		require('nvim-cmp')
	end
}

use {'L3MON4D3/LuaSnip',
	requires = {'rafamadriz/friendly-snippets'}
}

use {'nvim-treesitter/nvim-treesitter',
	opt = true,
	event = {'BufRead', 'BufNew'},
	branch = '0.5-compat',
	run = ':TSUpdate',
	config = function ()
		require('treesitter')
	end,
}

end)

-- -- Fuzzy find files
local map = vim.api.nvim_set_keymap
map("n", "<leader>f", ":Telescope find_files<CR>", { noremap = true, })
map("n", "<leader>o", ":Telescope oldfiles<CR>", { noremap = true, })
map("n", "<leader>gf", ":Telescope git_files<CR>", { noremap = true, })
map("n", "<leader>df", ':Teledot<CR>', { noremap = true, })
map("n", "<leader>nf", ':Televim<CR>', { noremap = true, })

-- grep
map("n", "<leader>gs", ":Telescope grep_string<CR>", { noremap = true, })
map("n", "<leader>gl", ":Telescope live_grep<CR>", { noremap = true, })

-- The rest
map("n", "\"", ":Telescope registers<CR>", { noremap = true, })
map("i", "<c-r>", "<Cmd>Telescope registers<CR>", { noremap = true, })
map("n", "<leader>b", ":Telescope builtin<CR>", { noremap = true, })
map("n", "<c-_>", ":Telescope current_buffer_fuzzy_find<CR>", { noremap = true, })
