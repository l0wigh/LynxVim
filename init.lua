-- Base settings for Neovim
vim.cmd [[
nnoremap j h
nnoremap k j
nnoremap l k
nnoremap m l
nnoremap ù 0
nnoremap <C-w>j <C-w>h
nnoremap <C-w>k <C-w>j
nnoremap <C-w>l <C-w>k
nnoremap <C-w>m <C-w>l
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
" set listchars=tab:\|\ 
set listchars=tab:\ \ 
set noerrorbells
set laststatus=3
set signcolumn=no
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
		"felipeagc/fleet-theme-nvim",
		-- config = function() vim.cmd("colorscheme fleet") end
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		-- config = function() vim.cmd("colorscheme catppuccin-mocha") end
	},
	{
		"rebelot/kanagawa.nvim",
		config = function() vim.cmd("colorscheme kanagawa") end
	},

	-- Easy transparent background
	"xiyaowong/transparent.nvim",

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

	-- Autocompletion (nvim-cmp)
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"L3MON4D3/LuaSnip",
	"saadparwaiz1/cmp_luasnip",

	{
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy",
	},

	-- Autopairs
	"windwp/nvim-autopairs",

	-- Easy Comment
	{
		"terrortylor/nvim-comment",
		config = function() require("nvim_comment").setup({ comment_empty = false }) end
	},
})

require("lsp_signature").setup({
	hint_enable = false,
	noice = true,
	floating_window = true,
	handler_opts = {
		border = "none"   -- double, rounded, single, shadow, none, or a table of borders
	},
})

-- Better (useless) Mason icons
require("mason").setup({ ui = { icons = { package_installed = "✓", package_pending = "➜", package_uninstalled = "✗" } } })
require("mason-lspconfig").setup()
require("mason-lspconfig").setup_handlers {
	function (server_name)
		local lsp_options = {}
		require("lspconfig")[server_name].setup ( lsp_options )
	end,
}

-- Configuration of nvim-cmp
local cmp = require("cmp")
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp_window = require "cmp.utils.window"
require("luasnip").setup()

cmp.setup({
	window = {
		documentation = {
			winhighlight = "Normal:Pmenu",
		},
	},
    snippet = {
      expand = function(args)
		  require('luasnip').lsp_expand(args.body)
      end,
    },
	mapping = cmp.mapping.preset.insert({
		["<Tab>"] = cmp.mapping.select_next_item(),
		["<S-Tab>"] = cmp.mapping.select_prev_item(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<Esc>"] = cmp.mapping.abort(),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp", max_item_count = 5 },
		{ name = "luasnip", max_item_count = 3 },
		{ name = "buffer", max_item_count = 3 },
		{ name = "path", max_item_count = 3 },
	}),
	experimental = {
		ghost_text = true
	}
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
	sources = cmp.config.sources({
		{ name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
	}, {
		{ name = 'buffer' },
	})
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer', max_item_count = 10 }
	}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path', max_item_count = 10 }
	}, {
		{ name = 'cmdline', max_item_count = 10 }
	})
})

require("nvim-autopairs").setup()
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))

local luasnip = require('luasnip')
luasnip.config.set_config {
	history = true,
	updateevents = "TextChanged,TextChangedI"
}
require("luasnip/loaders/from_vscode").lazy_load()

function Lynx_newfile()
	local file = vim.fn.input("New file: ", "", "file")
	if string.len(file) ~= 0 then
		vim.cmd("e " .. file)
	else
		vim.cmd("enew")
	end
end

-- Custom bindings based on LionVim whichkeys setup
vim.cmd [[
	nnoremap <space>bb <cmd>Telescope buffers<CR>
	nnoremap <space>ptl <cmd>Telescope live_grep<CR>
	nnoremap <space>e <cmd>Telescope find_files<CR>

	nnoremap <space>C <cmd>e ~/.config/nvim/init.lua<CR>
	nnoremap <space>bc <cmd>bdelete<CR>

	nnoremap <space>/ <cmd>CommentToggle<CR>
	vnoremap <space>/ <cmd>norm gc<CR>

	nnoremap <space>lh <cmd>lua vim.lsp.buf.hover()<CR>
	nnoremap <space>lc <cmd>lua vim.lsp.buf.code_action()<CR>
	nnoremap <space>lR <cmd>lua vim.lsp.buf.references()<CR>
	nnoremap <space>lD <cmd>lua vim.lsp.buf.definition()<CR>
	nnoremap <space>lr <cmd>lua vim.lsp.buf.rename()<CR>
	nnoremap <space>ln <cmd>lua vim.diagnostic.goto_next()<CR>
	nnoremap <space>lp <cmd>lua vim.diagnostic.goto_prev()<CR>
	nnoremap <space>ld <cmd>lua vim.diagnostic.open_float()<CR>
	nnoremap <space>lS <cmd>Telescope lsp_workspace_symbols<CR>
	nnoremap <space>ls <cmd>Telescope lsp_document_symbols<CR>
	nnoremap <space>fn <cmd>lua Lynx_newfile()<CR>
]]

-- LynxLine Alpha 1
local function lynxline_fileandline()
	local name = vim.fn.expand "%:t"
	local line_number = ""
	if vim.bo.filetype == "alpha" then
		line_number = ""
	else
		line_number = ":%l"
	end
	return name
end

local function lynxline_lsp()
	local count = {}
	local levels = { errors = "Error", warnings = "Warn", info = "Info", hints = "Hint" }
	for k, level in pairs(levels) do
		count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
	end
	local errors = ""
	local warnings = ""
	local hints = ""
	local info = ""
	if count["errors"] ~= 0 then errors = "%#DiagnosticError# " .. count["errors"] .. " " end
	if count["warnings"] ~= 0 then warnings = "%#DiagnosticWarn# " .. count["warnings"] .. " " end
	if count["hints"] ~= 0 then hints = "%#DiagnosticHint# " .. count["hints"] .. " " end
	if count["info"] ~= 0 then info = "%#DiagnosticInfo# " .. count["info"] .. " " end
	return errors .. warnings .. hints .. info .. "%#Statusline#"
end

local function filetype()
  return string.format("%s", vim.bo.filetype):upper()
end

Statusline = {}
Statusline.active = function()
	return table.concat {
		"%#Statusline#",
		" LynxVim",
		"  ",
		lynxline_fileandline(),
		"  ",
		filetype(),
		"  ",
		lynxline_lsp(),
	}
end
Statusline.inactive = function() return " %F" end
Statusline.short = function() return " LynxVim" end

vim.api.nvim_exec([[
  augroup Statusline
  au!
  au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline.active()
  au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.inactive()
  au WinEnter,BufEnter,FileType NvimTree setlocal statusline=%!v:lua.Statusline.short()
  augroup END
]], false)
