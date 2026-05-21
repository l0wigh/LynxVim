vim.cmd("set background=dark")
vim.cmd.colorscheme("sakura")
if vim.g.goneovim then
else
	if vim.g.neovide then
	else
		vim.cmd.hi("Normal guibg=NONE")
	end
end
