-- lua/core/keymaps.lua

local map = vim.keymap.set
local map_opts_silent = { noremap = true, silent = true }

-- General Mappings
map("i", "jj", "<Esc>", { noremap = true, silent = true, desc = "Escape Insert Mode" })
map("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true, desc = "Escape Terminal Mode" })
map("v", "//", function()
	vim.cmd("normal! y")
	local sel = vim.fn.getreg('"')
	local pattern = vim.fn.escape(sel, "/\\")
	vim.fn.setreg("/", "\\V" .. pattern)
	vim.cmd("normal! n")
end, { noremap = true, silent = true, desc = "Search for Visual Selection" })

-- LSP Diagnostic Mappings
local diag_opts = { silent = true }
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, diag_opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, diag_opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, diag_opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, diag_opts)
