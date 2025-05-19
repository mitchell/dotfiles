-- lua/plugins/navigation.lua

return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		lazy = false,
		opts = {},
		keys = {
			{
				"<leader>nn",
				"<cmd>Neotree left reveal_force_cwd<cr>",
				desc = "Neo-tree Toggle Sidebar",
				silent = true,
			},
			{
				"<leader>nf",
				"<cmd>Neotree float reveal_force_cwd<cr>",
				desc = "Neo-tree Float",
				silent = true,
			},
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {},
		keys = {
			{ "<leader>t", "<cmd>Telescope<cr>", desc = "Telescope", silent = true },
			{ "<leader>p", "<cmd>Telescope git_files<cr>", desc = "Telescope Git Files", silent = true },
			{ "<C-p>", "<cmd>Telescope find_files<cr>", desc = "Telescope Find Files", silent = true },
			{ "<leader>s", "<cmd>Telescope treesitter<cr>", desc = "Telescope Treesitter", silent = true },
			{ "<leader>gs", "<cmd>Telescope grep_string<cr>", desc = "Telescope Grep String", silent = true },
			{ "<leader>gl", "<cmd>Telescope live_grep<cr>", desc = "Telescope Grep String", silent = true },
			{ "<leader>gg", "<cmd>Telescope lsp_definitions<cr>", desc = "LSP Definitions", silent = true },
			{ "<leader>gr", "<cmd>Telescope lsp_references<cr>", desc = "LSP References", silent = true },
			{ "<leader>gi", "<cmd>Telescope lsp_implementations<cr>", desc = "LSP Implementations", silent = true },
			{
				"<leader>gd",
				"<cmd>Telescope lsp_type_definitions<cr>",
				desc = "LSP Type Definitions",
				silent = true,
			},
		},
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("telescope").load_extension("fzf")
		end,
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
			},
			{
				"<c-s>",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Toggle Flash Search",
			},
		},
	},
}
