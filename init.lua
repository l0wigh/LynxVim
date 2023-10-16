-- Base settings for Neovim
vim.cmd [[
nnoremap j h
nnoremap k j
nnoremap l k
nnoremap m l
nnoremap ù 0
inoremap jk <Esc>
vnoremap j h
vnoremap k j
vnoremap l k
vnoremap m l
vnoremap ù 0
set noshowmode
set nowrap
set tabstop=4
set shiftwidth=4
set softtabstop=4
set noexpandtab
set number
set relativenumber
set nohlsearch
set incsearch
set scrolloff=8
set noswapfile
set nobackup
set undofile
set undodir=~/.config/nvim/undodir
set list
set listchars=tab:\|\ 
" set timeoutlen=100
set noerrorbells
" set cursorline
set laststatus=3
]]

-- Install Lazy.nvim if not already done
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- Themes
	{
		"EdenEast/nightfox.nvim",
		-- config = function() vim.cmd("colorscheme dayfox") end
	},
	{
		"felipeagc/fleet-theme-nvim",
		config = function() vim.cmd("colorscheme fleet") end
	},

	-- Telescope
	{
		'nvim-telescope/telescope.nvim', branch = '0.1.x',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},

	-- LSP / Treesitter
	"nvim-treesitter/nvim-treesitter",
	{
		"williamboman/mason.nvim",
		dependencies = { "neovim/nvim-lspconfig", "williamboman/mason-lspconfig.nvim" },
		config = function() require("mason").setup() end
	},

	-- ddc for autocompletion
	"vim-denops/denops.vim",
	"Shougo/ddc.vim",
	"Shougo/ddc-nvim-lsp",
	"Shougo/ddc-matcher_head",
	"Shougo/ddc-sorter_rank",
	"Shougo/pum.vim",
	"Shougo/ddc-ui-pum",
	"matsui54/denops-popup-preview.vim",
	"matsui54/denops-signature_help",

	-- Autopairs
	"windwp/nvim-autopairs",
})

-- Better (useless) Mason icons
require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗"
		}
	}
})

-- Maybe useless
require("mason-lspconfig").setup()
require("mason-lspconfig").setup_handlers {
	function (server_name)
		local lsp_options = {}
		require("lspconfig")[server_name].setup ( lsp_options )
	end,
}

-- Loading nvim-autopairs
require("nvim-autopairs").setup()

-- Configuration of ddc.vim
vim.cmd [[ 
  call ddc#custom#patch_global('sourceOptions', {
        \ '_': {
        \   'matchers': ['matcher_head'],
        \   'sorters': ['sorter_rank']},
        \ })

  call ddc#custom#patch_global('sources', ['nvim-lsp'])
  call ddc#custom#patch_global('sourceOptions', {
        \ 'nvim-lsp': {
        \   'mark': 'lsp',
        \   'forceCompletionPattern': '\.\w*|:\w*|->\w*' },
        \ })
  
  " call popup_preview#enable()
  imap <silent><expr> <TAB> pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' : '<TAB>'
  imap <silent><expr> <S-TAB> pum#visible() ? '<Cmd>call pum#map#insert_relative(-1)<CR>' : '<S-TAB>'
  imap <silent><expr> <CR> pum#visible() ? '<Cmd>call pum#map#confirm()<CR>' : '<CR>'
  imap <silent><expr> <Esc> pum#visible() ? '<Cmd>call pum#map#cancel()<CR>' : '<Esc>'
  inoremap <PageDown> <Cmd>call pum#map#insert_relative_page(+1)<CR>
  inoremap <PageUp>   <Cmd>call pum#map#insert_relative_page(-1)<CR>
  call ddc#custom#patch_global('ui', 'pum')
  call ddc#enable()
  call ddc#enable_cmdline_completion()
]]

-- Loading signature help and lsp-doc
vim.cmd [[
	call signature_help#enable()
	call popup_preview#enable()
]]

-- Custom bindings based on LionVim whichkeys setup
vim.cmd [[
	nnoremap <space>bb <cmd>Telescope buffers<CR>
	nnoremap <space>ptl <cmd>Telescope live_grep<CR>
	nnoremap <space>e <cmd>Telescope find_files<CR>
	nnoremap <space>C <cmd>e ~/.config/nvim/init.lua<CR>
]]
