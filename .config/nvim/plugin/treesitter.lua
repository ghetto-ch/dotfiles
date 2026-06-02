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
		'asciidoc',
		'asciidoc_inline',
		'rust',
		-- 'haskell',
	},

	languages = {
		asciidoc = {
			install_info = {
				branch = 'master',
				location = 'tree-sitter-asciidoc',
				queries = 'queries/',
				use_repo_queries = true,
				-- requires = { 'asciidoc_inline' },
				url = 'https://github.com/cathaysia/tree-sitter-asciidoc',
			},
		},

		asciidoc_inline = {
			install_info = {
				branch = 'master',
				location = 'tree-sitter-asciidoc_inline',
				queries = 'queries/',
				use_repo_queries = true,
				url = 'https://github.com/cathaysia/tree-sitter-asciidoc',
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
