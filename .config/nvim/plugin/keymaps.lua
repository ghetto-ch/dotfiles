local map = vim.keymap.set

local opts = { noremap = true, silent = true }

-- Package manager
map('n', '<leader>U', vim.pack.update, opts)
-- Delete all unused packages
map('n', '<leader>D', function()
	local to_del = vim.iter(vim.pack.get())
	to_del:filter(function(x)
		return not x.active
	end)
	to_del:map(function(x)
		return x.spec.name
	end)
	vim.pack.del(to_del:totable())
end, opts)

-- Buffers
-- map('n', '<A-d>', ':bdelete<CR>', opts)
vim.keymap.set('n', '<A-d>', function()
	local bufnr = vim.api.nvim_get_current_buf()

	-- Sostituisce il comando se il buffer ha modifiche non salvate
	if vim.api.nvim_get_option_value('modified', { buf = bufnr }) then
		vim.api.nvim_echo(
			{ { 'Errore: Il buffer ha modifiche non salvate!', 'ErrorMsg' } },
			false,
			{}
		)
		return
	end

	-- Trova tutte le finestre che mostrano questo buffer
	local windows = vim.fn.win_findbuf(bufnr)

	-- Trova un buffer alternativo valido da mostrare
	local alt_buf = vim.fn.bufnr('#')
	if alt_buf == -1 or alt_buf == bufnr or vim.fn.buflisted(alt_buf) == 0 then
		alt_buf = vim.fn.bufnr('$')
		while alt_buf > 0 do
			if alt_buf ~= bufnr and vim.fn.buflisted(alt_buf) == 1 then
				break
			end
			alt_buf = alt_buf - 1
		end
	end

	-- Se non ci sono altri buffer validi, ne crea uno vuoto
	if alt_buf <= 0 then
		alt_buf = vim.api.nvim_create_buf(true, false)
	end

	-- Sposta ogni finestra su quel buffer alternativo
	for _, win in ipairs(windows) do
		vim.api.nvim_win_set_buf(win, alt_buf)
	end

	-- Infine, elimina il buffer originale in sicurezza
	if vim.api.nvim_buf_is_valid(bufnr) then
		vim.cmd('bdelete ' .. bufnr)
	end
end, { desc = 'Elimina buffer preservando il layout' })

-- Add semicolon at the end of the line
map('n', '<leader>;', ':normal! mqA;<Esc>`q', opts)
-- Add comma at the end of the line
map('n', '<leader>,', ':normal! mqA,<Esc>`q', opts)
-- Change directory to the active buffer path
map('n', '<leader>cd', ':cd %:h<CR>:pwd<CR>', opts)

-- Move lines
map('n', '<A-j>', ':m .+1<CR>==', opts)
map('n', '<A-k>', ':m .-2<CR>==', opts)
map('i', '<A-j>', '<Esc>:m .+1<CR>==gi', opts)
map('i', '<A-k>', '<Esc>:m .-2<CR>==gi', opts)
map('x', '<A-j>', ":m '>+1<CR>gv=gv", opts)
map('x', '<A-k>', ":m '<-2<CR>gv=gv", opts)

-- Textobject to select the entire buffer
map('x', 'ae', ':normal! ggVG<CR>', opts)
map('o', 'ae', ':normal! ggVG<CR>', opts)

-- Search
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Replace selected text pressing C-r, use very nomagic
map('x', '<C-r>', '"hy:%s/\\V<C-r>h')

-- Snippets
map({ 'i', 's' }, '<C-l>', function()
	if vim.snippet.active({ direction = 1 }) then
		return '<cmd>lua vim.snippet.jump(1)<cr>'
	else
		return '<C-l>'
	end
end, { expr = true })

map({ 'i', 's' }, '<C-h>', function()
	if vim.snippet.active({ direction = -1 }) then
		return '<cmd>lua vim.snippet.jump(-1)<cr>'
	else
		return '<C-h>'
	end
end, { expr = true })

map('t', '<Esc>', [[<C-\><C-n>]])

-- Show diagnostics popup
-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)

-- -- Show diagnostics on jump
-- vim.keymap.set('n', ']d', function()
-- 	vim.diagnostic.jump({ count = 1, float = true })
-- end)
-- vim.keymap.set('n', '[d', function()
-- 	vim.diagnostic.jump({ count = -1, float = true })
-- end)
