-- TODO: Change to the new way of doing this
-- require("lspconfig").zls.setup{}
-- require("lspconfig").gleam.setup{}

vim.lsp.enable({"zls", "gleam", "ocamllsp"})
