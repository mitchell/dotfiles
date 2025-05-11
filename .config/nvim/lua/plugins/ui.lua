-- lua/plugins/ui.lua

return {
	"edkolev/tmuxline.vim",
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		opts = { transparent = not vim.g.neovide },
		init = function()
			vim.cmd([[colorscheme kanagawa]])
		end,
	},
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		version = "*",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				separator_style = "slope",
				offsets = {
					{
						filetype = "neo-tree",
						text = "explorer",
						highlight = "Directory",
						separator = true,
					},
				},
			},
		},
		keys = {
			{ "<leader>j", "<cmd>BufferLinePick<cr>", desc = "BufferLinePick", silent = true },
			{ "<leader>J", "<cmd>BufferLinePickClose<cr>", desc = "BufferLinePickClose", silent = true },
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			extensions = {
				"neo-tree",
				"symbols-outline",
			},
		},
	},
	{
		"rcarriga/nvim-notify",
		opts = {
			background_colour = "#000000",
		},
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
			},
			views = {
				notify = {
					replace = true,
					merge = true,
				},
			},
		},
	},
	{
		"OXY2DEV/markview.nvim",
		lazy = false,
		dependencies = { "saghen/blink.cmp" },
		opts = {
			preview = {
				icon_provider = "devicons",
				filetypes = { "markdown", "codecompanion" },
				ignore_buftypes = {},
			},
		},
	},
}
