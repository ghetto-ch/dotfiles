local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({
		'git',
		'clone',
		'https://github.com/wbthomason/packer.nvim',
		install_path,
	})
	vim.cmd('packadd packer.nvim')
end

vim.cmd([[
	augroup packer_user_config
		autocmd!
		autocmd BufWritePost plugins.lua source <afile> | PackerCompile
	augroup end
]])

require('packer').startup({
	function(use)
		use({ 'wbthomason/packer.nvim' })

		-- Common use
		use({ 'nvim-lua/plenary.nvim' })

		use({ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' })
		use({
			'nvim-telescope/telescope.nvim',
			opt = true,
			cmd = { 'Telescope', 'Teledot', 'Televim' },
			requires = {
				{ 'nvim-lua/plenary.nvim' },
			},
			config = function()
				require('tele')
			end,
		})

		use({ 'kyazdani42/nvim-web-devicons' })

		use({ 'christoomey/vim-tmux-navigator' })

		use({ 'famiu/bufdelete.nvim', opt = true, event = { 'BufReadPost' } })

		use({
			'norcalli/nvim-colorizer.lua',
			opt = true,
			event = { 'BufReadPre', 'BufRead', 'BufNew' },
			config = function()
				require('colorizer').setup()
			end,
		})

		use({
			'unblevable/quick-scope',
			config = function()
				vim.g.qs_highlight_on_keys = { 'f', 'F', 't', 'T' }
			end,
		})

		use({ 'ghetto-ch/vim-noh', opt = true, event = { 'BufReadPost' } })

		-- General for programming
		use({
			'tpope/vim-surround',
			opt = true,
			event = { 'BufReadPost' },
			requires = { 'tpope/vim-repeat' },
		})

		use({
			'tpope/vim-commentary',
			opt = true,
			event = { 'BufReadPost' },
			requires = { 'tpope/vim-repeat' },
		})

		use({
			'windwp/nvim-autopairs',
			opt = true,
			after = 'nvim-cmp',
			config = function()
				require('autopairs')
			end,
		})

		use({
			'jpalardy/vim-slime',
			opt = true,
			event = { 'BufReadPost' },
			config = function()
				require('slime')
			end,
		})

		use({
			'lewis6991/gitsigns.nvim',
			opt = true,
			event = { 'BufReadPost' },
			requires = { 'nvim-lua/plenary.nvim' },
			config = function()
				require('signs')
			end,
		})

		-- Text objects
		use({ 'wellle/targets.vim', opt = true, event = { 'BufReadPost' } })

		use({
			'nvim-treesitter/nvim-treesitter',
			opt = true,
			event = { 'BufRead', 'BufNew' },
			branch = '0.5-compat',
			run = ':TSUpdate',
			requires = { 'nvim-treesitter/playground', opt = true },
			config = function()
				require('treesitter')
			end,
		})

		use({
			'nvim-treesitter/nvim-treesitter-textobjects',
			opt = true,
			after = 'nvim-treesitter',
			branch = '0.5-compat',
		})

		use({
			'RRethy/nvim-treesitter-textsubjects',
			opt = true,
			after = 'nvim-treesitter',
		})

		-- Completion and snippets
		use({
			'neovim/nvim-lspconfig',
			opt = true,
			after = 'nvim-cmp',
			config = function()
				require('lsp')
			end,
		})

		use({ 'onsails/lspkind-nvim' })

		use({
			'RRethy/vim-illuminate',
			opt = true,
			event = { 'BufReadPost' },
			config = function()
				vim.g.Illuminate_delay = 500
			end,
		})

		use({
			'hrsh7th/nvim-cmp',
			opt = true,
			event = { 'BufReadPre', 'BufRead', 'BufNew' },
			requires = {
				'saadparwaiz1/cmp_luasnip',
				'hrsh7th/cmp-path',
				'hrsh7th/cmp-nvim-lsp',
				'hrsh7th/cmp-nvim-lua',
			},
			config = function()
				require('nvim-cmp')
			end,
		})

		use({
			'L3MON4D3/LuaSnip',
			opt = true,
			after = 'nvim-cmp',
			config = function()
				require('snip')
			end,
		})
	end,
})
