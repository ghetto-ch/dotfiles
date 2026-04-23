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
map("n", "<A-d>", ":bdelete<CR>", opts)

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
