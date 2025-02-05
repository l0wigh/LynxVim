local map = vim.keymap.set

require("toggleterm").setup()

function _G.set_terminal_keymaps()
	local opts = {buffer = 0}
	map('t', '<esc>', [[<C-\><C-n>]], opts)
	map('t', 'jk', [[<C-\><C-n>]], opts)
end
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

map("n", "<leader>:", "<cmd>ToggleTerm size=10 dir=./ direction=float<CR>")
