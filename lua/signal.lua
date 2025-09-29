vim.api.nvim_create_autocmd("Signal", {
  pattern = "SIGUSR1",
  group = vim.api.nvim_create_augroup("toggle_bg_on_SIGUSR1", {}),
  callback = function()
	  vim.cmd("so ~/.config/nvim/lua/theme.lua")
	  vim.cmd("so ~/.config/nvim/lua/theme.lua")
	  vim.cmd("so ~/.config/nvim/lua/theme.lua")
  end,
  nested = true, -- allow this autocmd to trigger `OptionSet background` event
})
