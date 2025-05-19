-- lua/plugins/tools.lua

return {
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"echasnovski/mini.diff",
		},
		opts = {
			display = {
				diff = { provider = "mini_diff" },
				chat = {
					show_settings = false,
					window = { position = "right", opts = { number = false } },
				},
			},
			strategies = {
				chat = { adapter = "gemini" },
				inline = { adapter = "openai_mini" },
				cmd = { adapter = "openai_mini" },
			},
			adapters = {
				anthropic = function()
					return require("codecompanion.adapters").extend("anthropic", {
						schema = {
							max_tokens = { default = 20000 },
						},
					})
				end,
				gemini = function()
					return require("codecompanion.adapters").extend("gemini", {
						schema = {
							model = { default = "gemini-2.5-pro-preview-05-06" },
						},
					})
				end,
				openai = function()
					return require("codecompanion.adapters").extend("openai", {
						schema = {
							model = { default = "o4-mini-2025-04-16" },
							reasoning_effort = { default = "high" },
						},
					})
				end,
				openai_mini = function()
					return require("codecompanion.adapters").extend("openai", {
						schema = {
							model = { default = "gpt-4.1-mini" },
							temperature = { default = 0 },
						},
					})
				end,
			},
		},
		keys = {
			{ "<leader>cc", "<cmd>CodeCompanionChat<cr>", desc = "CodeCompanion Chat", silent = true },
			{
				"<leader>cf",
				"<cmd>CodeCompanionChat openai_mini<cr>",
				desc = "CodeCompanion Chat (Fast)",
				silent = true,
			},
			{ "<leader>ca", "<cmd>CodeCompanionActions<cr>", desc = "CodeCompanion Actions", silent = true },
			{ "<leader>ci", ":CodeCompanion<space>", mode = { "n", "v" }, desc = "CodeCompanion Inline" },
		},
	},
}
