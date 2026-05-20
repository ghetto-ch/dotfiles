-- Install parsers and queries
require('tree-sitter-manager').setup({
	ensure_installed = {
		'python',
		'bash',
		'go',
		'fish',
		'nix',
		'yaml',
		'toml',
		'kdl',
		'json',
	},

	languages = {
		asciidoc = {
			install_info = {
				url = 'https://github.com/cathaysia/tree-sitter-asciidoc',
				location = 'tree-sitter-asciidoc',
				queries = 'queries/asciidoc/',
				use_repo_queries = false,
			},
		},

		asciidoc_inline = {
			install_info = {
				url = 'https://github.com/cathaysia/tree-sitter-asciidoc',
				location = 'tree-sitter-asciidoc_inline',
				queries = 'queries/asciidoc_inline/',
				use_repo_queries = false,
			},
		},
	},
})

-- Treestitter textobjects
vim.g.no_plugin_maps = true
require('nvim-treesitter-textobjects').setup({
	select = {
		lookahead = true,
		selection_modes = {
			['@parameter.outer'] = 'v', -- charwise
			['@function.outer'] = 'V', -- linewise
			['@class.outer'] = '<c-v>', -- blockwise
		},
		include_surrounding_whitespace = false,
	},
})

vim.keymap.set({ 'x', 'o' }, 'af', function()
	require('nvim-treesitter-textobjects.select').select_textobject(
		'@function.outer',
		'textobjects'
	)
end)
vim.keymap.set({ 'x', 'o' }, 'if', function()
	require('nvim-treesitter-textobjects.select').select_textobject(
		'@function.inner',
		'textobjects'
	)
end)
vim.keymap.set({ 'x', 'o' }, 'ac', function()
	require('nvim-treesitter-textobjects.select').select_textobject(
		'@class.outer',
		'textobjects'
	)
end)
vim.keymap.set({ 'x', 'o' }, 'ic', function()
	require('nvim-treesitter-textobjects.select').select_textobject(
		'@class.inner',
		'textobjects'
	)
end)
vim.keymap.set({ 'x', 'o' }, 'as', function()
	require('nvim-treesitter-textobjects.select').select_textobject(
		'@local.scope',
		'locals'
	)
end)
