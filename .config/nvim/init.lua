vim.loader.enable()
require('vim._core.ui2').enable({})

vim.g.mapleader = ' '

-- Arch puts system-wide Vim plugins (black.vim, fzf.vim, ...) on the rtp
vim.opt.runtimepath:remove('/usr/share/vim/vimfiles')
vim.opt.runtimepath:remove('/usr/share/vim/vimfiles/after')

-- Disable unused providers and default runtime plugins
vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_gzip = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_remote_plugins = 1
vim.g.loaded_netrwPlugin = 1

-- Neovim clashes with fish...
vim.o.shell = '/bin/bash'

-- Hooks for plugins
local hooks = function(ev)
	local name, kind = ev.data.spec.name, ev.data.kind

	-- Setup telescope-fzf-native
	if
		name == 'telescope-fzf-native.nvim'
		and (kind == 'update' or kind == 'install')
	then
		vim.system({ 'make' }, { cwd = ev.data.path }):wait()
	end

	--
end

vim.api.nvim_create_autocmd('PackChanged', {
	callback = hooks,
})

local plugins = {
	'https://github.com/rebelot/kanagawa.nvim',
	'https://github.com/nvim-lua/plenary.nvim',
	'https://github.com/mrjones2014/smart-splits.nvim',
	'https://github.com/nvim-tree/nvim-web-devicons',
	'https://github.com/nvim-lualine/lualine.nvim',
	'https://github.com/stevearc/oil.nvim',
	'https://github.com/neovim/nvim-lspconfig',
	'https://github.com/folke/lazydev.nvim',
	'https://github.com/nickjvandyke/opencode.nvim',
	'https://github.com/OXY2DEV/markview.nvim',
	'https://github.com/ghetto-ch/tunnell.nvim',
	-- '~/Develop/neovim/tunnell.nvim',
}
vim.pack.add(plugins)

local lazy_plugins = {
	'https://github.com/nvim-telescope/telescope.nvim',
	'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
	'https://github.com/romus204/tree-sitter-manager.nvim',
	'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
	'https://github.com/folke/flash.nvim',
	'https://github.com/cosmicbuffalo/eyeliner.nvim',
	'https://github.com/kylechui/nvim-surround',
	'https://github.com/windwp/nvim-autopairs',
	'https://github.com/stevearc/conform.nvim',
	'https://github.com/shellRaining/hlchunk.nvim',
	{
		src = 'https://github.com/saghen/blink.cmp',
		version = vim.version.range('^1.0.0'),
	},
	'https://github.com/zbirenbaum/copilot.lua',
	'https://codeberg.org/mfussenegger/nvim-dap.git',
	'https://github.com/igorlfs/nvim-dap-view',
	'https://github.com/mfussenegger/nvim-dap-python',
	'https://github.com/leoluz/nvim-dap-go',
	'https://github.com/mfussenegger/nvim-lint',
}
vim.pack.add(lazy_plugins, { load = function() end })
