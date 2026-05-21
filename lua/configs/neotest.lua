local map = vim.keymap.set

require('neotest').setup {
    adapters = {
      require('rustaceanvim.neotest')
    },
}

map("n", "<leader>tr", "<CMD>Neotest run<CR>")
map("n", "<leader>ts", "<CMD>Neotest summary<CR>")
map("n", "<leader>to", "<CMD>Neotest output<CR>")
