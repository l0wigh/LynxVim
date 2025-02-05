local map = vim.keymap.set

require("mason").setup({ ui = { icons = { package_installed = "✓", package_pending = "➜", package_uninstalled = "✗" } } })
require("mason-lspconfig").setup()
require("mason-lspconfig").setup_handlers {
	function (server_name)
		local lsp_options = {}
		require("lspconfig")[server_name].setup ( lsp_options )
	end,
}

map("n", "<leader>lh", "<cmd>lua vim.lsp.buf.hover()<CR>")
map("n", "<leader>lc", "<cmd>lua vim.lsp.buf.code_action()<CR>")
map("n", "<leader>lR", "<cmd>lua vim.lsp.buf.references()<CR>")
map("n", "<leader>lD", "<cmd>lua vim.lsp.buf.definition()<CR>")
map("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>")
map("n", "<leader>ln", "<cmd>lua vim.diagnostic.goto_next()<CR>")
map("n", "<leader>lp", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
map("n", "<leader>ld", "<cmd>lua vim.diagnostic.open_float()<CR>")
