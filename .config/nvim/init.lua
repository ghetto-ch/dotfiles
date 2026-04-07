vim.loader.enable()
require("vim._core.ui2").enable({})

vim.g.mapleader = " "

local hooks = function(ev)
	local name, kind = ev.data.spec.name, ev.data.kind
	if name == "nvim-treesitter" and kind == "update" then
		if not ev.data.active then
			vim.cmd.packadd("nvim-treesitter")
		end
		vim.cmd("TSUpdate")
	end
	if name == "telescope-fzf-native.nvim" and (kind == "update" or kind == "install") then
		vim.system({ "make" }, { cwd = ev.data.path }):wait()
	end
end

vim.api.nvim_create_autocmd("PackChanged", {
	callback = hooks,
})

local plugins = {
	-- Load at startup
	"https://github.com/rebelot/kanagawa.nvim",
	"https://github.com/christoomey/vim-tmux-navigator",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/nvim-lualine/lualine.nvim",
	"https://github.com/nvim-telescope/telescope.nvim",
	"https://github.com/nvim-telescope/telescope-fzf-native.nvim",
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
	"https://github.com/stevearc/oil.nvim",
	-- TODO Load at BufNew, BufReadPre
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/folke/lazydev.nvim",
	"https://github.com/folke/flash.nvim",
	"https://github.com/cosmicbuffalo/eyeliner.nvim",
	"https://github.com/kylechui/nvim-surround",
	"https://github.com/shellRaining/hlchunk.nvim",
	"https://github.com/stevearc/conform.nvim",
	{
		src = "https://www.github.com/olimorris/codecompanion.nvim",
		version = vim.version.range("^19.0.0"),
	},
	-- TODO Load at InsertEnter
	"https://github.com/windwp/nvim-autopairs",
	{
		src = "https://github.com/saghen/blink.cmp",
		version = vim.version.range("^1.0.0"),
	},
}
vim.pack.add(plugins)
