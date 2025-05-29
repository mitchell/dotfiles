-- lua/plugins/tools.lua

local function create_adapter(adapter_type, name, opts)
	return require("codecompanion.adapters").extend(adapter_type, {
		name = name,
		schema = opts.schema or {},
		env = opts.env or {},
		parameters = opts.parameters or {},
	})
end

local adapter_configs = {
	ollama = {
		type = "ollama",
		env = { url = "http://192.168.1.165:11434" },
		parameters = { sync = true },
		schema = { num_ctx = { default = 40960 } },
	},
	gemini_pro = {
		type = "gemini",
		schema = { model = { default = "gemini-2.5-pro-preview-05-06" } },
	},
	gemini_none = {
		type = "gemini",
		schema = {
			model = { default = "gemini-2.5-flash-preview-05-20" },
			reasoning_effort = { default = "none" },
			temperature = { default = 0 },
		},
	},
	gemini_high = {
		type = "gemini",
		schema = {
			model = { default = "gemini-2.5-flash-preview-05-20" },
			reasoning_effort = { default = "high" },
		},
	},
	openai_high = {
		type = "openai",
		schema = {
			model = { default = "o4-mini-2025-04-16" },
			reasoning_effort = { default = "high" },
		},
	},
}

-- Dynamically generate adapter functions
local adapters = {}
for name, config in pairs(adapter_configs) do
	adapters[name] = function()
		return create_adapter(config.type, name, config)
	end
end

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
			adapters = adapters,
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
