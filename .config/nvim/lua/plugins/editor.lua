-- lua/plugins/editor.lua

return {
	"tpope/vim-fugitive",
	"tpope/vim-eunuch",
	"tpope/vim-surround",
	{
		"w0rp/ale",
		event = "VeryLazy",
		keys = {
			{ "<leader>f", "<cmd>ALEFix<cr>", desc = "ALE Fix", silent = true },
			{ "<leader>a", "<cmd>ALEToggle<cr>", desc = "ALE Toggle", silent = true },
		},
		config = function()
			vim.g.ale_linters_explicit = 1
			vim.g.ale_completion_enabled = 0 -- Using blink.cmp for completion

			vim.g.ale_linters = {
				javascript = { "eslint", "stylelint", "biome" },
				typescript = { "eslint", "stylelint", "biome" },
				javascriptreact = { "eslint", "stylelint", "biome" },
				typescriptreact = { "eslint", "stylelint", "biome" },
				svelte = { "eslint" },
				go = { "golint", "go vet" },
				vue = { "eslint", "stylelint", "biome" },
				make = { "checkmake" },
				proto = { "protoc-gen-lint" },
				dockerfile = { "hadolint" },
				dart = { "dartanalyzer" },
				fish = { "fish" },
				vim = { "vint" },
				elixir = { "credo" },
				cs = { "OmniSharp" },
				terraform = { "tflint" },
				ruby = { "rubocop" },
				css = { "stylelint", "biome" },
				sh = { "shellcheck" },
				python = { "pylint" },
			}

			vim.g.ale_fixers = {
				go = { "goimports", "remove_trailing_lines", "trim_whitespace" },
				graphql = { "prettier" },
				javascript = { "prettier", "biome" },
				typescript = { "prettier", "biome" },
				javascriptreact = { "prettier", "biome" },
				typescriptreact = { "prettier", "biome" },
				svelte = { "prettier" },
				vue = { "prettier", "biome" },
				css = { "prettier", "biome" },
				yaml = { "prettier", "biome" },
				json = { "prettier", "biome" },
				dart = { "dartfmt" },
				html = { "prettier", "biome" },
				markdown = { "prettier", "biome" },
				make = { "remove_trailing_lines", "trim_whitespace" },
				elixir = { "mix_format" },
				terraform = { "terraform" },
				ruby = { "rubocop" },
				python = { "black" },
				lua = { "stylua" },
			}
		end,
	},
	{
		"echasnovski/mini.diff",
		version = false,
		lazy = false,
		opts = {},
		keys = {
			{
				"<leader>i",
				function()
					require("mini.diff").toggle_overlay()
				end,
				desc = "Mini.diff overlay",
				silent = true,
			},
		},
	},
	{
		"reedes/vim-pencil",
		cmd = { "HardPencil", "SoftPencil" },
		config = function()
			vim.g["pencil#map#suspend_af"] = "K"
		end,
	},
	{
		"folke/zen-mode.nvim",
		opts = {
			window = { backdrop = 0.95 },
			plugins = { twilight = { enabled = false } },
		},
		keys = {
			{ "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode", silent = true },
		},
	},
	{
		"folke/twilight.nvim",
		opts = {},
		keys = {
			{ "<leader>l", "<cmd>Twilight<cr>", desc = "Twilight", silent = true },
		},
	},
}
