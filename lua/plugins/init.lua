return {
	-- Soluna (DEV)
	{
		dir = "~/projects/soluna.nvim",
		config = function ()
			require("soluna").setup({
				linter_delay = 0,
				eval_disabled_at_start = true,
				lint_on_save = true,
				lint_on_change = false,
				evaluation_style = "ghost",
				evaluation_buffer_height = 10,
			})
			require("configs.soluna")
		end
	},
	
	-- {
	-- 	"L0Wigh/soluna.nvim",
	-- 	config = function()
	-- 		require("soluna").setup({
	-- 			linter_delay = 100,
	-- 			lint_on_save = true,
	-- 			lint_on_change = false,
	-- 		})
	-- 		require("configs.soluna")
	-- 	end
	-- },
	
	-- Manual Soluna Tree-sitter
	{
		"https://github.com/L0Wigh/tree-sitter-soluna",
		config = function ()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "soluna",
				callback = function()
					local install_path = vim.fn.stdpath("data") .. "/tree-sitter-soluna" 
					if vim.fn.isdirectory(install_path) == 1 then
						vim.opt_local.runtimepath:append(install_path)
					end
				end,
			})
			require("nvim-treesitter.parsers").get_parser_configs().soluna = {
				install_info = {
					url = "https://github.com/L0Wigh/tree-sitter-soluna",
					files = { "src/parser.c" },
					branch = "master"
				},
				filetype = "soluna"
			}

			vim.filetype.add({
				extension = {
					luna = "soluna",
				},
			})
		end
	},

	-- Soluna specific
	{
		"gpanders/nvim-parinfer",
		ft = {"clojure", "lisp", "racket", "scheme", "fennel", "soluna"},
		config = function ()
			vim.g.parinfer_filetypes = {"clojure", "lisp", "racket", "scheme", "fennel", "soluna"}
			vim.g.parinfer_no_maps = 0
			vim.cmd [[
				iunmap <Tab>
				iunmap <S-Tab>
			]]
		end
	},

	-- Required by some plugins
	{"nvim-lua/plenary.nvim"},

	-- Themes
	{
		"folke/tokyonight.nvim",
		"Mofiqul/vscode.nvim",
		"nyoom-engineering/oxocarbon.nvim",
		"savq/melange-nvim",
		"oahlen/iceberg.nvim",
		"luisiacc/gruvbox-baby",
		"edeneast/nightfox.nvim",
		"maxmx03/solarized.nvim",
		"sainnhe/everforest",
		{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
		"sainnhe/edge",
		{ "rose-pine/neovim", name = "rose-pine" },
		"LunarVim/templeos.nvim",
		{
			"L0Wigh/zenith.nvim",
			dependencies = "rktjmp/lush.nvim"
		},
		{
			"L0Wigh/vanessa.nvim",
			dependencies = "rktjmp/lush.nvim"
		},
	},

	-- Find anything anywhere
	{
		"nvim-telescope/telescope.nvim",
		config = function()
			require("configs.telescope")
		end
	},

	-- LSP / Colors / Server Manager
	{"neovim/nvim-lspconfig"},
	{"williamboman/mason-lspconfig.nvim"},
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("configs.treesitter")
		end
	},
	{
		"williamboman/mason.nvim",
		config = function()
			require("configs.mason")
		end
	},

	-- Autocompletion
	{"windwp/nvim-autopairs"},
	{"hrsh7th/cmp-nvim-lsp"},
	{"hrsh7th/cmp-buffer"},
	{"hrsh7th/cmp-path"},
	{"hrsh7th/cmp-cmdline"},
	{"saadparwaiz1/cmp_luasnip"},
	{
		"L3MON4D3/LuaSnip",
		dependencies = "rafamadriz/friendly-snippets",
		opts = { history = true, updateevents = "TextChanged,TextChangedI" },
		config = function(_, opts)
			require("luasnip").config.set_config(opts)
			require("configs.luasnip")
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		config = function()
			require("configs.cmp")
		end
	},

	-- Commenting
	{
		"terrortylor/nvim-comment",
		config = function ()
			require("configs.comment")
		end
	},

	-- LSP Signature
	{
		"ray-x/lsp_signature.nvim",
		config = function ()
			require("configs.signature")
		end
	},

	-- Better Terminal
	{
		"akinsho/toggleterm.nvim", version = "*",
		config = function ()
			require("configs.toggleterm")
		end
	},

	-- Arturo support
	{
		"xigoi/vim-arturo"
	},
}
