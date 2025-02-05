require("lsp_signature").setup({
	hint_enable = false,
	noice = false,
	floating_window = true,
	handler_opts = {
		border = {
			{"╭", "NormalFloat"}, {"─", "NormalFloat"}, {"╮", "NormalFloat"}, {"│", "NormalFloat"},
			{"╯", "NormalFloat"}, {"─", "NormalFloat"}, {"╰", "NormalFloat"}, {"│", "NormalFloat"}
		}   -- double, rounded, single, shadow, none, or a table of borders
	},
})
