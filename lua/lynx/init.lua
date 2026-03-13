local map = vim.keymap.set

require("lynx.functions")
require("lynx.bar")

map("n", "<leader>mm", "<cmd>lua lynx_compilefix()<CR>")
map("n", "<leader>ms", "<cmd>lua lynx_setcustomcommand()<CR>")
map("n", "<leader>mc", "<cmd>cclose<CR>")
map("v", "<leader>sp", "<cmd>lua lynxline_pin_text()<CR><Esc>")
map("n", "<leader>sc", "<cmd>lua lynxline_clear_pin()<CR>")
