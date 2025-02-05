-- LynxLine 0.1.0

local function lynxline_fileandline()
	local name = vim.fn.expand "%:t"
	local is_saved = ""
	if vim.bo.modified then
		is_saved = "+"
	end
	return is_saved .. name
end

local function lynxline_filetype()
	return string.format("%s", vim.bo.filetype):upper()
end

local function lynxline_lsp()
	local count = {}
	local levels = { errors = "Error", warnings = "Warn", info = "Info", hints = "Hint" }
	for k, level in pairs(levels) do
		count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
	end
	local errors = ""
	local warnings = ""
	local hints = ""
	local info = ""
	if count["errors"] ~= 0 then errors = "%#DiagnosticError# " .. count["errors"] .. " " end
	if count["warnings"] ~= 0 then warnings = "%#DiagnosticWarn# " .. count["warnings"] .. " " end
	if count["hints"] ~= 0 then hints = "%#DiagnosticHint# " .. count["hints"] .. " " end
	if count["info"] ~= 0 then info = "%#DiagnosticInfo# " .. count["info"] .. " " end
	return errors .. warnings .. hints .. info .. "%#Statusline#"
end

Statusline = {}
Statusline.active = function()
	return table.concat {
		"%#Statusline#",
		" LynxVim",
		"  ",
		lynxline_fileandline(),
		"  ",
		lynxline_filetype(),
		" ",
		lynxline_lsp(),
	}
end
Statusline.inactive = function() return " %F" end
Statusline.short = function() return " LynxVim" end

vim.api.nvim_exec([[
augroup Statusline
au!
au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline.active()
au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.inactive()
au WinEnter,BufEnter,FileType NvimTree setlocal statusline=%!v:lua.Statusline.short()
augroup END
]], false)
