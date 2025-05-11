-- lua/plugins/treesitter.lua

return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				"c",
				"cpp",
				"lua",
				"vim",
				"regex",
				"bash",
				"fish",
				"typescript",
				"javascript",
				"tsx",
				"go",
				"elixir",
				"vue",
				"groovy",
				"java",
				"objc",
				"swift",
				"hcl",
				"terraform",
				"yaml",
				"json",
				"markdown",
				"markdown_inline",
			},
			auto_install = false,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "gnn",
					node_incremental = "grn",
					scope_incremental = "grc",
					node_decremental = "grm",
				},
			},
			indent = {
				enable = true,
			},
		},
		init = function()
			vim.opt.foldmethod = "expr"
			vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
			vim.opt.foldenable = false
		end,
		config = function(plugin, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
}
