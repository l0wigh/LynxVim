return {
	-- Required by some plugins
	{"nvim-lua/plenary.nvim"},

	-- Themes
	{
		"luisiacc/gruvbox-baby",
		"edeneast/nightfox.nvim",
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
}
