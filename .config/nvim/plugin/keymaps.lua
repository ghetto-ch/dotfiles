local map = vim.keymap.set

local opts = { noremap = true, silent = true }

-- Package manager
map("n", "<leader>U", vim.pack.update, opts)
-- Delete all unused packages
map("n", "<leader>D", function()
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
vim.keymap.set("n", "<A-d>", function()
	local bufnr = vim.api.nvim_get_current_buf()

	-- Find all windows showing this buffer
	local windows = vim.fn.win_findbuf(bufnr)

	-- Search for alternative buffer
	local alt_buf = vim.fn.bufnr("#")
	if alt_buf == -1 or alt_buf == bufnr or vim.fn.buflisted(alt_buf) == 0 then
		alt_buf = vim.fn.bufnr("$")
		while alt_buf > 0 do
			if alt_buf ~= bufnr and vim.fn.buflisted(alt_buf) == 1 then
				break
			end
			alt_buf = alt_buf - 1
		end
	end

	-- If no alternative buffer is available create an empty one
	if alt_buf <= 0 then
		alt_buf = vim.api.nvim_create_buf(true, false)
	end

	-- Move all windows to alternate buffer
	for _, win in ipairs(windows) do
		vim.api.nvim_win_set_buf(win, alt_buf)
	end

	-- Delete the buffer
	if vim.api.nvim_buf_is_valid(bufnr) then
		vim.cmd("bdelete " .. bufnr)
	end
end, { desc = "Delete buffer but keep layout" })

-- Add semicolon at the end of the line
map("n", "<leader>;", ":normal! mqA;<Esc>`q", opts)
-- Add comma at the end of the line
map("n", "<leader>,", ":normal! mqA,<Esc>`q", opts)
-- Change directory to the active buffer path
map("n", "<leader>cd", ":cd %:h<CR>:pwd<CR>", opts)

-- Move lines
map("n", "<A-j>", ":m .+1<CR>==", opts)
map("n", "<A-k>", ":m .-2<CR>==", opts)
map("i", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
map("i", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)
map("x", "<A-j>", ":m '>+1<CR>gv=gv", opts)
map("x", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- Textobject to select the entire buffer
map("x", "ae", ":normal! ggVG<CR>", opts)
map("o", "ae", ":normal! ggVG<CR>", opts)

-- Search
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Replace selected text pressing C-r, use very nomagic
map("x", "<C-r>", '"hy:%s/\\V<C-r>h')

-- Snippets
map({ "i", "s" }, "<C-l>", function()
	if vim.snippet.active({ direction = 1 }) then
		return "<cmd>lua vim.snippet.jump(1)<cr>"
	else
		return "<C-l>"
	end
end, { expr = true })

map({ "i", "s" }, "<C-h>", function()
	if vim.snippet.active({ direction = -1 }) then
		return "<cmd>lua vim.snippet.jump(-1)<cr>"
	else
		return "<C-h>"
	end
end, { expr = true })

map("t", "<Esc>", [[<C-\><C-n>]])

-- Experimental, exchange words
-- TODO: solve bugs when at the end of the line
map("n", "cxw", "dawwP")
map("n", "cxW", "daWWP")
map("n", "cxb", "dawbP")
map("n", "cxB", "daWBP")
