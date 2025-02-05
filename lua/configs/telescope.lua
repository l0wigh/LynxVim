local map = vim.keymap.set

map("n", "<leader>bb", "<cmd>Telescope buffers<CR>")
map("n", "<leader>ptl", "<cmd>Telescope live_grep<CR>")
map("n", "<leader>e", "<cmd>Telescope find_files<CR>")
map("n", "<leader>lS", "<cmd>Telescope lsp_workspace_symbols<CR>")
map("n", "<leader>ls", "<cmd>Telescope lsp_document_symbols<CR>")
