function lynx_compilefix()
	print("Compiling...")
	vim.cmd(":silent w");
	vim.cmd(":silent make");
	local quickfix_list = vim.fn.getqflist()
	if #quickfix_list == 0 then
		vim.cmd("cclose");
		print("Nothing to fix")
	else
		vim.cmd("copen");
	end
end

function lynx_setcustomcommand()
	local bufnr = vim.api.nvim_win_get_buf(vim.fn.win_getid())
	local default_makeprg = vim.api.nvim_buf_get_option(bufnr, "makeprg")
	local command = vim.fn.input("Compile Command: ", default_makeprg, "command")

	if string.len(command) ~= 0 then
		vim.api.nvim_buf_set_option(bufnr, "makeprg", command)
		vim.print("\nNew compile command set");
	else
		vim.print("\nNo command given")
	end
end
