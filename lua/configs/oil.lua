local map = vim.keymap.set

require("oil").setup({
	default_file_explorer = true,
	float = {
		border = "rounded",
		win_options = {
			winblend = 0,
			winhl = "NormalFloat:Normal,FloatBorder:Normal",
		},
	},
})

map("n", "<leader>e", "<CMD>Oil<CR>")
