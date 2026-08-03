--#############################################################################
-- Opencode
--#############################################################################

vim.keymap.set({ 'n', 'x' }, '<leader>oa', function()
	require('opencode').ask('@this: ')
end, { desc = 'Ask opencode…' })
vim.keymap.set({ 'n', 'x' }, '<leader>ox', function()
	require('opencode').select()
end, { desc = 'Execute opencode action…' })
vim.keymap.set({ 'n' }, '<leader>ot', function()
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

local function toggleCopilotLsp()
	if vim.lsp.is_enabled('copilot') then
		for _, client in ipairs(vim.lsp.get_clients({ name = 'copilot' })) do
			client:stop()
		end
		vim.lsp.inline_completion.enable(false)
	else
		vim.lsp.enable('copilot')
		vim.lsp.inline_completion.enable(true)
	end
end
-- Map a key combination to toggle Copilot auto_trigger
vim.keymap.set('n', '<leader>ct', function()
	toggleCopilotLsp()
end)

vim.keymap.set('i', '<c-f>', vim.lsp.inline_completion.get)
