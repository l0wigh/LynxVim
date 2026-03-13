local map = vim.keymap.set

-- Normal mode bindings
map({"n", "v", "x"}, "j", "h")
map({"n", "v", "x"}, "k", "j")
map({"n", "v", "x"}, "l", "k")
map({"n", "v", "x"}, "m", "l")
map({"n", "v", "x"}, "ù", "0")
map({"n", "v", "x"}, "<space>y", "\"+y")

map("n", "<C-w>j", "<C-w>h")
map("n", "<C-w>k", "<C-w>j")
map("n", "<C-w>l", "<C-w>k")
map("n", "<C-w>m", "<C-w>l")

map("n", "<leader>bc", "<cmd>bdelete<CR>")
map("n", "<leader>C", "<cmd>e ~/.config/nvim<CR>")
map("n", "<leader>t", "<cmd>vsplit<CR><cmd>term<CR>")
map("n", "<leader>T", "<cmd>split<CR><cmd>term<CR>")

-- Insert mode bindings
map("i", "jk", "<Esc>")
