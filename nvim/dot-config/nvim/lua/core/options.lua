-- lua/core/options.lua

vim.opt.guifont = "JetBrainsMono Nerd Font:h13"
vim.opt.colorcolumn = "100"
vim.opt.cursorline = true
vim.opt.showmatch = true
vim.opt.number = true
vim.opt.showmode = false
vim.opt.background = "dark"
vim.opt.wrap = false
vim.opt.cmdheight = 1
vim.opt.shortmess:append("c")
vim.opt.termguicolors = true
vim.opt.mouse = "a"
vim.opt.mousemodel = "extend"
vim.opt.tabstop = 2
vim.opt.shiftwidth = 0
vim.opt.expandtab = true
vim.opt.textwidth = 100
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

if vim.g.neovide then
	vim.g.neovide_scale_factor = 0.75
	vim.g.neovide_transparency = 0.7
	vim.g.neovide_cursor_vfx_mode = "sonicboom"
end
