local map = vim.keymap.set

require("mini.files").setup({
	mappings = {
    close       = 'q',
    go_in       = 'm',
    go_in_plus  = 'M',
    go_out      = 'j',
    go_out_plus = 'J',
    mark_goto   = "'",
    mark_set    = 'h',
    reset       = 'S',
    reveal_cwd  = '@',
    show_help   = 'g?',
    synchronize = 's',
    trim_left   = '<',
    trim_right  = '>',
  },
})

map("n", "<leader>e", "<CMD>lua MiniFiles.open()<CR>")
