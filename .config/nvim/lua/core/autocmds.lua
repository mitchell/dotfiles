-- lua/core/autocmds.lua

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Fish filetype settings
augroup("FishSettings", { clear = true })
autocmd("FileType", {
	pattern = "fish",
	command = "setlocal tabstop=4",
	group = "FishSettings",
})

-- Terminal settings
augroup("TerminalSettings", { clear = true })
autocmd("TermOpen", {
	pattern = "*",
	command = "setlocal nonumber norelativenumber",
	group = "TerminalSettings",
})
