local map = vim.keymap.set

require("nvim_comment").setup({
	comment_empty = false
})

map("n", "<leader>/", "<cmd>CommentToggle<CR>")
map("v", "<leader>/", "<cmd>norm gc<CR>")
