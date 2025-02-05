local map = vim.keymap.set

-- Normal mode bindings
map("n", "j", "h")
map("n", "k", "j")
map("n", "l", "k")
map("n", "m", "l")
map("n", "ù", "0")

map("n", "<C-w>j", "<C-w>h")
map("n", "<C-w>k", "<C-w>j")
map("n", "<C-w>l", "<C-w>k")
map("n", "<C-w>m", "<C-w>l")

map("n", "<leader>bc", "<cmd>bdelete<CR>")
map("n", "<leader>C", "<cmd>e ~/.config/nvim<CR>")

-- Visual mode bindings
map("v", "j", "h")
map("v", "k", "j")
map("v", "l", "k")
map("v", "m", "l")
map("v", "ù", "0")

-- Insert mode bindings
map("i", "jk", "<Esc>")
