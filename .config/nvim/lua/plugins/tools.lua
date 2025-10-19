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
			rules = {
				opts = {
					chat = {
						enabled = false,
					},
				},
			},
			interactions = {
				chat = {
					adapter = { name = "opencode", model = "llama.cpp/qwen3.5-35b-a3b-dev" },
					opts = {
						-- system_prompt = "",
					},
					tools = {
						opts = {
							system_prompt = {
								enabled = true, -- Enable the tools system prompt?
								replace_main_system_prompt = true, -- Replace the main system prompt with the tools system prompt?
							},
						},
					},
				},
				inline = {
					adapter = { name = "llama.cpp", model = "qwen3.5-35b-a3b-dev" },
				},
				cmd = {
					adapter = { name = "llama.cpp", model = "qwen3.5-35b-a3b-dev" },
				},
				cli = {
					agent = "opencode",
					agents = {
						opencode = {
							cmd = "opencode",
							args = {},
							description = "OpenCode CLI",
						},
					},
					opts = {
						auto_insert = true, -- Enter insert mode when focusing the CLI terminal
						reload = true, -- Reload buffers when an agent modifies files on disk
					},
				},
			},
			adapters = {
				http = {
					["llama.cpp"] = function()
						return require("codecompanion.adapters").extend("openai_compatible", {
							schema = {
								model = {
									default = "qwen3.5-35b-a3b-dev",
								},
							},
							env = {
								url = "http://127.0.0.1:8080", -- replace with your llama.cpp instance
								api_key = "TERM",
								chat_url = "/v1/chat/completions",
							},
							handlers = {
								parse_message_meta = function(self, data)
									local extra = data.extra
									if extra and extra.reasoning_content then
										data.output.reasoning = { content = extra.reasoning_content }
										if data.output.content == "" then
											data.output.content = nil
										end
									end
									return data
								end,
							},
						})
					end,
				},
			},
		},
		keys = {
			{ "<leader>cc", "<cmd>CodeCompanionChat<cr>", desc = "CodeCompanion Chat", silent = true },
			{
				"<leader>ca",
				"<cmd>CodeCompanionChat Add<cr>",
				mode = { "v" },
				desc = "CodeCompanion Chat Add",
				silent = true,
			},
			{ "<leader>cp", "<cmd>CodeCompanionActions<cr>", desc = "CodeCompanion Actions", silent = true },
			{
				"<leader>cl",
				"<cmd>CodeCompanionCLI<cr>",
				mode = { "n", "v" },
				desc = "CodeCompanion CLI",
				silent = true,
			},
			{ "<leader>ck", "<cmd>CodeCompanionCLI Ask<cr>", mode = { "n", "v" }, desc = "CodeCompanion CLI Ask" },
			{ "<leader>ci", ":CodeCompanion<space>", mode = { "n", "v" }, desc = "CodeCompanion Inline" },
		},
	},
}
