vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
	once = true,
	callback = function()
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
				'haskell',
				'just',
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
		require('nvim-treesitter-textobjects').setup({
			select = {
				lookahead = true,
				selection_modes = {
					['@parameter.outer'] = 'v', -- charwise
					['@function.outer'] = 'V', -- linewise
					['@class.outer'] = 'V', -- blockwise
				},
				include_surrounding_whitespace = false,
			},
			move = {
				set_jumps = true,
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
		vim.keymap.set({ 'x', 'o' }, 'ia', function()
			require('nvim-treesitter-textobjects.select').select_textobject(
				'@parameter.inner',
				'textobjects'
			)
		end)
		vim.keymap.set({ 'x', 'o' }, 'aa', function()
			require('nvim-treesitter-textobjects.select').select_textobject(
				'@parameter.outer',
				'textobjects'
			)
		end)

		-- Swap objects
		vim.keymap.set({ 'n' }, 'cxa', function()
			require('nvim-treesitter-textobjects.swap').swap_next(
				'@parameter.inner',
				'textobjects'
			)
		end)
		vim.keymap.set({ 'n' }, 'cxA', function()
			require('nvim-treesitter-textobjects.swap').swap_previous(
				'@parameter.inner',
				'textobjects'
			)
		end)

		-- Jumps
		vim.keymap.set({ 'n', 'x', 'o' }, ']f', function()
			require('nvim-treesitter-textobjects.move').goto_next_start(
				{ '@class.outer', '@function.outer' },
				'textobjects'
			)
		end)
		vim.keymap.set({ 'n', 'x', 'o' }, '[f', function()
			require('nvim-treesitter-textobjects.move').goto_previous_start(
				{ '@class.outer', '@function.outer' },
				'textobjects'
			)
		end)
		vim.keymap.set({ 'n', 'x', 'o' }, ']]', function()
			require('nvim-treesitter-textobjects.move').goto_next(
				{ '@block.outer', '@call.outer' },
				'textobjects'
			)
		end)
		vim.keymap.set({ 'n', 'x', 'o' }, '[[', function()
			require('nvim-treesitter-textobjects.move').goto_previous(
				{ '@block.outer', '@call.outer' },
				'textobjects'
			)
		end)
		vim.keymap.set({ 'n', 'x', 'o' }, '<M-]>', function()
			require('nvim-treesitter-textobjects.move').goto_next_start(
				{ '@block.outer', '@call.outer' },
				'textobjects'
			)
		end)
		vim.keymap.set({ 'n', 'x', 'o' }, '<M-[>', function()
			require('nvim-treesitter-textobjects.move').goto_previous_start(
				{ '@block.outer', '@call.outer' },
				'textobjects'
			)
		end)
	end,
})

-- Nodes
-- @assignment.inner
-- @assignment.lhs
-- @assignment.outer
-- @assignment.rhs
-- @attribute.inner
-- @attribute.outer
-- @block.inner
-- @block.outer
-- @call.inner
-- @call.outer
-- @class.inner
-- @class.outer
-- @comment.inner
-- @comment.outer
-- @conditional.inner
-- @conditional.outer
-- @function.inner
-- @function.outer
-- @loop.inner
-- @loop.outer
-- @number.inner
-- @parameter.inner
-- @parameter.outer
-- @regex.inner
-- @regex.outer
-- @return.inner
-- @return.outer
-- @scopename.inner
-- @statement.outer

-- For LaTeX frames
-- @frame.inner
-- @frame.outer
