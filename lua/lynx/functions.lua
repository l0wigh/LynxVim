function lynx_compilefix()
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
	local command = vim.fn.input("Compile Command: ", "", "command")
	local bufnr = vim.api.nvim_win_get_buf(vim.fn.win_getid())

	if string.len(command) ~= 0 then
		local type = vim.bo.filetype
		vim.api.nvim_buf_set_option(bufnr, "makeprg", command)
		vim.print("\nNew compile command set");
	else
		vim.print("\nNo command given")
	end
end
