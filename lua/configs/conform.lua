local map = vim.keymap.set

require("conform").setup({
	formatters_by_ft = {
		markdown = { "prettier" },
	}
})

map({"n", "v"}, "<leader>F", function()
	require("conform").format({
		lsp_fallback = true,
		async = false,
		timeout_ms = 500,
	})
end)
