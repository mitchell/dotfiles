-- lua/plugins/treesitter.lua

return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		lazy = false,
		init = function()
			local langs = {
				"c",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"markdown",
				"markdown_inline",
				"regex",
				"bash",
				"fish",
				"typescript",
				"javascript",
				"tsx",
				"svelte",
				"go",
				"elixir",
				"vue",
				"hcl",
				"terraform",
				"yaml",
				"json",
			}
			require("nvim-treesitter").install(langs)

			vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
			vim.opt.foldmethod = "expr"
			vim.opt.foldenable = false

			table.insert(langs, "javascriptreact")
			table.insert(langs, "typescriptreact")
			vim.api.nvim_create_autocmd("FileType", {
				pattern = langs,
				callback = function()
					vim.treesitter.start()
				end,
			})
		end,
	},
}
