--#############################################################################
-- Opencode
--#############################################################################

vim.keymap.set({ 'n', 'x' }, '<leader>oa', function()
	require('opencode').ask('@this: ', { submit = true })
end, { desc = 'Ask opencode…' })
vim.keymap.set({ 'n', 'x' }, '<leader>ox', function()
	require('opencode').select()
end, { desc = 'Execute opencode action…' })
vim.keymap.set({ 'n', 't' }, '<leader>ot', function()
	require('opencode').toggle()
end, { desc = 'Toggle opencode' })

vim.keymap.set({ 'n', 'x' }, 'go', function()
	return require('opencode').operator('@this ')
end, { desc = 'Add range to opencode', expr = true })
vim.keymap.set('n', 'goo', function()
	return require('opencode').operator('@this ') .. '_'
end, { desc = 'Add line to opencode', expr = true })

vim.keymap.set('n', '<S-C-u>', function()
	require('opencode').command('session.half.page.up')
end, { desc = 'Scroll opencode up' })
vim.keymap.set('n', '<S-C-d>', function()
	require('opencode').command('session.half.page.down')
end, { desc = 'Scroll opencode down' })

--#############################################################################
-- Copilot
--#############################################################################

-- Wrap setup in an autocmd because the copilot server takes long to startup.
-- Not ideal because :Copilot will not be available before.
vim.api.nvim_create_autocmd('InsertEnter', {
	once = true,
	callback = function()
		require('copilot').setup({
			panel = {
				enabled = true,
				auto_refresh = false,
				-- TODO find good keymaps
				keymap = {
					jump_prev = '[[',
					jump_next = ']]',
					accept = '<CR>',
					refresh = 'gr',
					open = '<M-CR>',
				},
				layout = {
					position = 'right', -- | top | left | right | bottom |
					ratio = 0.4,
				},
			},
			suggestion = {
				enabled = true,
				auto_trigger = false,
				hide_during_completion = true,
				debounce = 15,
				trigger_on_accept = true,
				-- TODO find good keymaps
				keymap = {
					accept = '<M-y>',
					accept_word = false,
					accept_line = false,
					next = '<M-n>',
					prev = '<M-p>',
					dismiss = '',
					toggle_auto_trigger = false,
				},
			},
		})

		-- Map a key combination to toggle Copilot auto_trigger
		vim.keymap.set('n', '<leader>ct', function()
			require('copilot.suggestion').toggle_auto_trigger()
		end, { desc = 'Toggle Copilot' })

		-- Map a key combination to toggle Copilot panel
		vim.keymap.set('n', '<leader>cp', function()
			require('copilot.panel').toggle()
		end, { desc = 'Toggle Copilot' })
	end,
})
