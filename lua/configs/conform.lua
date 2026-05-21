local map = vim.keymap.set

vim.g.disable_autoformat = true

require("conform").setup({
	formatters_by_ft = {
		markdown = { "prettier" },
	},
	format_on_save = function()
		if vim.g.disable_autoformat then
			return
		end
		return { timeout_ms = 500, lsp_format = "fallback" }
	end,
})

map({ "n", "v" }, "<leader>F", function()
	if vim.g.disable_autoformat ~= true then
		vim.g.disable_autoformat = true
		print("Autoformat disabled")
	else
		vim.g.disable_autoformat = false
		print("Autoformat enabled")
	end
end)
