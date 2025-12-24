local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
-- Also remember to use this command in neovim if nothing happend
-- :EditQuery highlights soluna
-- if that fails you need to:
--
-- mkdir -p ~/.config/nvim/queries/soluna
-- ln -s ~/projects/soluna/queries/highlights.scm ~/.config/nvim/queries/soluna/highlights.scm
--
-- parser_config.soluna = {
--   install_info = {
--     url = "~/projects/tree-sitter-soluna",
--     files = { "src/parser.c" },
--     branch = "main",
--   },
--   filetype = "luna",
-- }

