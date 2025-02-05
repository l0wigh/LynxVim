local map = vim.keymap.set

require("lynx.functions")
require("lynx.bar")

map("n", "<leader>mm", "<cmd>lua lynx_compilefix()<CR>")
map("n", "<leader>ms", "<cmd>lua lynx_setcustomcommand()<CR>")
map("n", "<leader>mc", "<cmd>cclose<CR>")
