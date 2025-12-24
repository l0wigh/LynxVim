vim.o.showmode = false
vim.o.laststatus = 3
vim.o.cursorline = true
vim.o.wrap = false
vim.o.scrolloff = 8
vim.o.termguicolors = true
vim.o.signcolumn = "no"

-- Line number
vim.o.number = true
vim.o.relativenumber = true

-- Tabs > Spaces
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = false

-- /search
vim.o.hlsearch = false
vim.o.incsearch = true

-- s/swapfile/undofile
vim.o.swapfile = false
vim.o.backup = false
vim.o.undofile = true
vim.cmd [[ set undodir=~/.cache/nvim_undodir ]]

-- Fancy symbol for tabs charaters !
vim.o.list = true
vim.cmd [[ set listchars=tab:\▏\ ]]
-- vim.cmd [[ set listchars=tab:\ \ ]]

vim.cmd [[
augroup MakeCommand
	autocmd!
	autocmd FileType c      setlocal makeprg=make
	autocmd FileType rust   setlocal makeprg=cargo\ build
	autocmd FileType v      setlocal makeprg=v\ .
	autocmd FileType ocaml  setlocal makeprg=dune\ build
augroup END
]]

vim.cmd [[
	autocmd BufNewFile,BufRead *.s,*.S,*.asm :set filetype=nasm
]]

	-- autocmd BufNewFile,BufRead *.luna :set filetype=none

-- This comes from NVChad, it avoid issues with default zig support
-- local autocmd = vim.api.nvim_create_autocmd
-- -- user event that loads after UIEnter + only if file buf is there
-- autocmd({ "UIEnter", "BufReadPost", "BufNewFile" }, {
--   group = vim.api.nvim_create_augroup("NvFilePost", { clear = true }),
--   callback = function(args)
--     local file = vim.api.nvim_buf_get_name(args.buf)
--     local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })

--     if not vim.g.ui_entered and args.event == "UIEnter" then
--       vim.g.ui_entered = true
--     end

--     if file ~= "" and buftype ~= "nofile" and vim.g.ui_entered then
--       vim.api.nvim_exec_autocmds("User", { pattern = "FilePost", modeline = false })
--       vim.api.nvim_del_augroup_by_name "NvFilePost"

--       vim.schedule(function()
--         vim.api.nvim_exec_autocmds("FileType", {})

--         if vim.g.editorconfig then
--           require("editorconfig").config(args.buf)
--         end
--       end)
--     end
--   end,
-- })
