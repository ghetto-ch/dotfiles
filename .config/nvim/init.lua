vim.loader.enable()
require("vim._core.ui2").enable({})

vim.g.mapleader = " "

local hooks = function(ev)
	local name, kind = ev.data.spec.name, ev.data.kind

	-- Setup telescope-fzf-native
	if name == "telescope-fzf-native.nvim" and (kind == "update" or kind == "install") then
		vim.system({ "make" }, { cwd = ev.data.path }):wait()
	end

	--
end

vim.api.nvim_create_autocmd("PackChanged", {
	callback = hooks,
})

local plugins = {
	"https://github.com/rebelot/kanagawa.nvim",
	"https://github.com/christoomey/vim-tmux-navigator",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/nvim-lualine/lualine.nvim",
	"https://github.com/nvim-telescope/telescope.nvim",
	"https://github.com/nvim-telescope/telescope-fzf-native.nvim",
	"https://github.com/romus204/tree-sitter-manager.nvim",
	"https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/folke/flash.nvim",
	"https://github.com/cosmicbuffalo/eyeliner.nvim",
	"https://github.com/kylechui/nvim-surround",
	"https://github.com/windwp/nvim-autopairs",
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/shellRaining/hlchunk.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/folke/lazydev.nvim",
	{
		src = "https://github.com/saghen/blink.cmp",
		version = vim.version.range("^1.0.0"),
	},
	"https://github.com/nickjvandyke/opencode.nvim",
	"https://codeberg.org/mfussenegger/nvim-dap.git",
	"https://github.com/igorlfs/nvim-dap-view",
	"https://github.com/mfussenegger/nvim-dap-python",
	"https://github.com/leoluz/nvim-dap-go",
}
vim.pack.add(plugins)
