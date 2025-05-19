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
				chat = { adapter = "gemini_high" },
				inline = { adapter = "gemini_none" },
				cmd = { adapter = "gemini_none" },
			},
			adapters = {
				anthropic = function()
					return require("codecompanion.adapters").extend("anthropic", {
						schema = {
							model = { default = "claude-3-7-sonnet-20250219" },
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
				gemini_none = function()
					return require("codecompanion.adapters").extend("gemini", {
						schema = {
							model = { default = "gemini-2.5-flash-preview-04-17" },
							reasoning_effort = { default = "none" },
						},
					})
				end,
				gemini_high = function()
					return require("codecompanion.adapters").extend("gemini", {
						schema = {
							model = { default = "gemini-2.5-flash-preview-04-17" },
							reasoning_effort = { default = "high" },
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
			},
		},
		keys = {
			{ "<leader>cc", "<cmd>CodeCompanionChat<cr>", desc = "CodeCompanion Chat", silent = true },
			{
				"<leader>cf",
				"<cmd>CodeCompanionChat gemini_none<cr>",
				desc = "CodeCompanion Chat (Fast)",
				silent = true,
			},
			{ "<leader>ca", "<cmd>CodeCompanionActions<cr>", desc = "CodeCompanion Actions", silent = true },
			{ "<leader>ci", ":CodeCompanion<space>", mode = { "n", "v" }, desc = "CodeCompanion Inline" },
		},
	},
}
