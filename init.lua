vim.g.mapleader = " "

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
	local repo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ import = "plugins" }
})

require("signal")
require("mappings")
require("options")
require("theme")
require("lynx")
require("manual_lsp")
require("manual_treesitter")
