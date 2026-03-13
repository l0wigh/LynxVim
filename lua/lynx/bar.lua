-- LynxLine 0.2.0 (Heavily inspired by Nothing design)
-- Insert or not status
-- Filename that becomes red when modified
-- Position in file represented by dots
-- Current Function / Active signature in insert mode / Pinned text for easy access
--
-- LSP errors, warning or LYNXVIM branding
-- LSP server name
-- Vibe meter (do you type fast or not)
-- Square that indicate macro recording status (red = recording)
-- /!\ Many parts of this bar are vibe-coded. Nonetheless, the code is reviewed and tested.

local M = {}
local lsp_cache = {}
local sig_cache = {}
local strokes = 0
local vibe_history = {"_", "_", "_", "_", "_", "_", "_", "_", "_"}

local function setup_highlights()
	local hl_err = vim.api.nvim_get_hl(0, { name = "DiagnosticError" })
	local hl_warn = vim.api.nvim_get_hl(0, { name = "DiagnosticWarn" })
	local hl_msg = vim.api.nvim_get_hl(0, { name = "Normal" })

	local error_color = hl_err.fg or "#FF0000"
	local warn_color = hl_warn.fg or "#FFA500"
	local fg_color = hl_msg.fg or "#FFFFFF"
	local muted_color = "#444444"

	vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE", fg = fg_color })
	vim.api.nvim_set_hl(0, "LynxMain", { fg = fg_color, bg = "NONE", bold = true })
	vim.api.nvim_set_hl(0, "LynxMuted", { fg = muted_color, bg = "NONE" })
	vim.api.nvim_set_hl(0, "LynxLspErr", { fg = error_color, bg = "NONE", bold = true })
	vim.api.nvim_set_hl(0, "LynxLspWarn", { fg = warn_color, bg = "NONE" })
end

local function find_deepest_symbol(syms, line, depth)
	if not syms or depth > 5 then return nil end
	local best = nil
	for _, sym in ipairs(syms) do
		local range = sym.range or (sym.location and sym.location.range)
		if range then
			local s = range.start.line + 1
			local e = range["end"].line + 1
			if line >= s and line <= e then
				if vim.tbl_contains({ 6, 12, 9, 11, 23 }, sym.kind) then
					best = sym.name
				end
				local child = find_deepest_symbol(sym.children, line, depth + 1)
				if child then best = child end
			end
		end
	end
	return best
end

local function refresh_lsp_cache(bufnr)
	if #vim.lsp.get_clients({ bufnr = bufnr }) == 0 then return end
	local params = { textDocument = vim.lsp.util.make_text_document_params(bufnr) }
	vim.lsp.buf_request(bufnr, "textDocument/documentSymbol", params, function(err, result)
		if err or not result then return end
		lsp_cache[bufnr] = { symbols = result }
	end)
end

local function refresh_signature_cache(bufnr)
	local clients = vim.lsp.get_clients({ bufnr = bufnr })
	if #clients == 0 then return end

	local client = nil
	for _, c in ipairs(clients) do
		if c.server_capabilities.signatureHelpProvider then
			client = c
			break
		end
	end
	if not client then return end

	local params = vim.lsp.util.make_position_params(0, client.offset_encoding)
	vim.lsp.buf_request(bufnr, "textDocument/signatureHelp", params, function(err, result)
		if err or not result or not result.signatures or #result.signatures == 0 then
			sig_cache[bufnr] = nil
			return
		end
		local sig = result.signatures[(result.activeSignature or 0) + 1]
		if not sig then sig_cache[bufnr] = nil; return end

		local label = sig.label
		local active_param = result.activeParameter or sig.activeParameter or 0
		local highlighted = label

		if sig.parameters and sig.parameters[active_param + 1] then
			local p = sig.parameters[active_param + 1]
			if type(p.label) == "table" then
				local s, e = p.label[1], p.label[2]
				highlighted = label:sub(1, s)
					.. "\1" .. label:sub(s + 1, e) .. "\2"
					.. label:sub(e + 1)
			elseif type(p.label) == "string" then
				highlighted = label:gsub(vim.pesc(p.label), "\1" .. p.label .. "\2", 1)
			end
		end

		sig_cache[bufnr] = highlighted
	end)
end

local pinned_text = ""
local function get_lsp_context()
	local bufnr = vim.api.nvim_get_current_buf()
	local mode = vim.api.nvim_get_mode().mode

	if string.len(pinned_text) ~= 0 then
		return " %#LynxMuted#<%#LynxLspErr# %#LynxMain#" .. pinned_text .. "%#LynxMuted#>"
	end

	if mode == "i" or mode == "ic" then
		local sig = sig_cache[bufnr]
		if sig then
			local before_paren = sig:match("^([^(]*)%(") or ""
			local params_str   = sig:match("%((.-)%)") or ""
			local after_paren  = sig:match("%)(.*)$") or ""

			local colored_params = params_str:gsub("\1(.-)%\2", "%%#LynxLspErr#%1%%#LynxMuted#")

			local arrow, ret = after_paren:match("^(%s*%->%s*)(.*)")
			if arrow then
				return " %#LynxMuted#<%#LynxMain#" .. before_paren
					.. "%#LynxMuted#(" .. colored_params .. "%#LynxMuted#)"
					.. "%#LynxMuted#" .. arrow .. "%#LynxMain#" .. ret .. "%#LynxMuted#>"
			else
				return " %#LynxMuted#<%#LynxMain#" .. before_paren
					.. "%#LynxMuted#(" .. colored_params .. "%#LynxMuted#)"
					.. "%#LynxMain#" .. after_paren .. "%#LynxMuted#>"
			end
		end
	end

	local cache = lsp_cache[bufnr]
	if not cache or not cache.symbols then return "" end

	local line = vim.api.nvim_win_get_cursor(0)[1]
	local function_name = find_deepest_symbol(cache.symbols, line, 0)

	if function_name then
		return "%#LynxMuted# <%#LynxMain#" .. function_name .. "%#LynxMuted#>"
	end
	return ""
end

local function get_diag()
	local errs = #vim.diagnostic.get(0, { severity = 1 })
	local warns = #vim.diagnostic.get(0, { severity = 2 })
	if errs == 0 and warns == 0 then return "%#LynxMuted#LYNXVIM " end

	local res = ""
	if warns > 0 then res = res .. "%#LynxLspWarn#○ " .. warns .. " " end
	if errs > 0 then res = res .. "%#LynxLspErr#● " .. errs .. " " end
	return res
end

local function get_macro_recording()
	local recording_register = vim.fn.reg_recording()
	if recording_register == "" then return "%#LynxMain#■ " end
	return "%#LynxLspErr#■ "
end

local lsp_state = {}
local function get_lsp_pulse()
	local bufnr = vim.api.nvim_get_current_buf()
	local s = lsp_state[bufnr]

	if not s then
		local clients = vim.lsp.get_clients({ bufnr = bufnr })
		if #clients == 0 then return "" end
		lsp_state[bufnr] = {
			phase = "boot",
			name  = clients[1].name,
			typed = 0,
		}
		s = lsp_state[bufnr]
	end

	if s.phase == "ready" then
		return "%#LynxMuted#[%#LynxMain#" .. s.name .. "%#LynxMuted#] "
	end
	if s.typed < #s.name then
		s.typed = s.typed + 1
		local partial = s.name:sub(1, s.typed)
		return "%#LynxMuted#[%#LynxMain#" .. partial .. "%#LynxMuted#] "
	end

	s.phase = "ready"
	return "%#LynxMuted#[%#LynxMain#" .. s.name .. "%#LynxMuted#] "
end

vim.on_key(function() strokes = strokes + 1 end)
local function get_vibe()
	local current_vibe = "_"

	if strokes > 12 then
		current_vibe = "█"
	elseif strokes > 6 then
		current_vibe = "▆"
	elseif strokes > 3 then
		current_vibe = "▄"
	elseif strokes > 1 then
		current_vibe = "▂"
	else
		current_vibe = "_"
	end

	table.insert(vibe_history, 1, current_vibe)
	table.remove(vibe_history, 10)
	local function reversedTable(t)
		local result = {}
		for i = #t, 1, -1 do
			result[#result + 1] = t[i]
		end
		return result
	end
	local result = reversedTable(vibe_history)

	return "%#LynxMuted#" .. table.concat(result) .. " "
end

local function get_visual_scroll()
	local curr = vim.api.nvim_win_get_cursor(0)[1]
	local total = vim.api.nvim_buf_line_count(0)
	local index = math.min(5, math.ceil((curr / total) * 5))

	local positions = { "%#LynxMuted#○", "%#LynxMuted#○", "%#LynxMuted#○", "%#LynxMuted#○", "%#LynxMuted#○" }
	positions[index] = "%#LynxMain#●"

	return " " .. table.concat(positions, "")
end

Statusline = {}
Statusline.active = function()
	local mode = vim.api.nvim_get_mode().mode
	local glyph = (mode == 'i') and "●" or "○"
	local modified = (vim.bo.modified) and "%#LynxLspErr#" or "%#LynxMain#"

	return table.concat {
		-- Left
		"%#LynxMain# ", glyph,
		"%#LynxMuted#", " [", modified, "%t", "%#LynxMuted#", "]",
		get_visual_scroll(),
		get_lsp_context(),

		"%=",

		-- Right
		get_diag(),
		get_lsp_pulse(),
		get_vibe(),
		get_macro_recording(),
	}
end

setup_highlights()
vim.opt.laststatus = 3
vim.opt.statusline = "%!v:lua.Statusline.active()"

local group = vim.api.nvim_create_augroup("LynxLine", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
	group = group,
	callback = function(ev)
		vim.defer_fn(function()
			if vim.api.nvim_buf_is_valid(ev.buf) then refresh_lsp_cache(ev.buf) end
		end, 100)
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = group,
	callback = function(ev)
		lsp_state[ev.buf] = nil
		vim.defer_fn(function()
			if vim.api.nvim_buf_is_valid(ev.buf) then
				refresh_lsp_cache(ev.buf)
			end
		end, 100)
	end,
})

vim.api.nvim_create_autocmd("CursorMoved", {
	group = group,
	callback = function() vim.cmd("redrawstatus") end,
})

vim.api.nvim_create_autocmd({"CursorMovedI", "InsertEnter"}, {
	group = group,
	callback = function(ev)
		refresh_signature_cache(ev.buf)
		vim.cmd("redrawstatus")
	end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
	group = group,
	callback = function(ev)
		sig_cache[ev.buf] = nil
		vim.cmd("redrawstatus")
	end,
})

vim.api.nvim_create_autocmd("ColorScheme", { callback = setup_highlights })

if _G.lynx_timer then
	_G.lynx_timer:stop()
	_G.lynx_timer:close()
end

_G.lynx_timer = vim.loop.new_timer()
_G.lynx_timer:start(0, 100, vim.schedule_wrap(function()
	if strokes > 0 then
		strokes = math.floor(strokes * 0.7)
	end
	vim.cmd("redrawstatus")
end))

vim.opt.shortmess:append("q")

function lynxline_pin_text()
	local selected_text = function()
	  local mode = vim.api.nvim_get_mode().mode
	  local opts = {}
	  if mode == "v" or mode == "V" or mode == "\22" then opts.type = mode end
	  return vim.fn.getregion(vim.fn.getpos "v", vim.fn.getpos ".", opts)
	end
	pinned_text = table.concat(selected_text())
end

function lynxline_set_pin(text)
	pinned_text = text
end

function lynxline_clear_pin()
	pinned_text = ""
end

return M
