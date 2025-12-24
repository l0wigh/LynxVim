vim.cmd("set background=dark")
vim.cmd.colorscheme("rose-pine")
if vim.g.goneovim then
else
	vim.cmd.hi("Normal guibg=NONE")
end
