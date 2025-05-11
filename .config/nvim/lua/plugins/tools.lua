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
			display = { diff = { provider = "mini_diff" }, chat = { show_settings = true } },
			strategies = {
				chat = { adapter = "gemini_deep" },
				inline = { adapter = "openai" },
				cmd = { adapter = "openai_mini" },
			},
			adapters = {
				anthro = function()
					return require("codecompanion.adapters").extend("anthropic", {
						schema = {
							model = { default = "claude-3-7-sonnet-20250219" },
							extended_thinking = { default = false },
						},
					})
				end,
				anthro_deep = function()
					return require("codecompanion.adapters").extend("anthropic", {
						schema = {
							model = { default = "claude-3-7-sonnet-20250219" },
						},
					})
				end,
				gemini = function()
					return require("codecompanion.adapters").extend("gemini", {
						schema = {
							model = { default = "gemini-2.5-flash-preview-04-17" },
						},
					})
				end,
				gemini_deep = function()
					return require("codecompanion.adapters").extend("gemini", {
						schema = {
							model = { default = "gemini-2.5-pro-preview-05-06" },
						},
					})
				end,
				openai_mini = function()
					return require("codecompanion.adapters").extend("openai", {
						schema = {
							model = { default = "gpt-4.1-mini" },
						},
					})
				end,
				openai_deep = function()
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
			{ "<leader>c", "<cmd>CodeCompanionChat<cr>", desc = "CodeCompanion Chat", silent = true },
		},
	},
}
