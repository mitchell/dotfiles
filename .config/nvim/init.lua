-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Set leader key before lazy setup
vim.g.mapleader = ","

-- Plugin specifications
require("lazy").setup({
	install = { colorscheme = { "kanagawa" } },
	spec = {
		-- UI and appearance
		{
			"rebelot/kanagawa.nvim",
			lazy = false,
			priority = 1000,
			opts = {
				transparent = not vim.g.neovide,
			},
			init = function()
				vim.cmd([[colorscheme kanagawa]])
			end,
		},
		{
			"akinsho/bufferline.nvim",
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
		"edkolev/tmuxline.vim",

		-- Editor enhancements
		"w0rp/ale",
		"tpope/vim-eunuch",
		"tpope/vim-surround",
		-- { "airblade/vim-gitgutter", lazy = false },
		{ "echasnovski/mini.diff", version = false, opts = {} },
		{
			"reedes/vim-pencil",
			cmd = { "HardPencil", "SoftPencil" },
		},
		{
			"tpope/vim-fugitive",
			cmd = { "G", "Git" },
			ft = "gitcommit",
		},
		{
			"folke/zen-mode.nvim",
			opts = {
				window = {
					backdrop = 0.95,
				},
				plugins = {
					twilight = { enabled = false },
				},
			},
		},
		{ "folke/twilight.nvim", opts = {} },

		-- Completion and LSP
		{
			"saghen/blink.cmp",
			dependencies = { "rafamadriz/friendly-snippets" },
			version = "1.*",
			---@module 'blink.cmp'
			---@type blink.cmp.Config
			opts = {},
			opts_extend = { "sources.default" },
		},
		{
			"neovim/nvim-lspconfig",
			dependencies = { "saghen/blink.cmp" },
		},
		{
			"pmizio/typescript-tools.nvim",
			dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		},

		-- Navigation and search
		{
			"nvim-neo-tree/neo-tree.nvim",
			branch = "v3.x",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"nvim-tree/nvim-web-devicons",
				"MunifTanjim/nui.nvim",
			},
			lazy = false, -- neo-tree will lazily load itself
			---@module "neo-tree"
			---@type neotree.Config?
			opts = {},
		},
		{
			"nvim-telescope/telescope.nvim",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"nvim-tree/nvim-web-devicons",
			},
			opts = {},
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

		-- Treesitter
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
			config = function(plugin, opts)
				require("nvim-treesitter.configs").setup(opts)
			end,
		},

		-- CodeCompanion
		{
			"olimorris/codecompanion.nvim",
			dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter", "echasnovski/mini.diff" },
			opts = {
				display = { diff = { provider = "mini_diff" }, chat = { show_settings = true } },
				strategies = {
					chat = { adapter = "gemini_deep" },
					inline = { adapter = "gemini" },
					cmd = { adapter = "gemini" },
				},
				adapters = {
					anthropic = function()
						return require("codecompanion.adapters").extend("anthropic", {
							schema = {
								model = { default = "claude-3-7-sonnet-20250219" },
								extended_thinking = { default = false },
							},
						})
					end,
					gemini_deep = function()
						return require("codecompanion.adapters").extend("gemini", {
							schema = {
								model = { default = "gemini-2.5-pro-preview-03-25" },
							},
						})
					end,
					ollama = function()
						return require("codecompanion.adapters").extend("ollama", {
							env = {
								url = "http://scimitar.lan:11434",
							},
							schema = {
								model = { default = "deepseek-r1:7b" },
								num_ctx = { default = 8192 },
							},
						})
					end,
				},
			},
		},
	},
})

-- General settings
vim.opt.guifont = "JetBrainsMono Nerd Font:h13"

-- LSP Mappings
local opts = { silent = true }
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { silent = true, buffer = bufnr }
	vim.keymap.set("n", "<leader>h", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set("n", "<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set("n", "<leader>m", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<leader>F", function()
		vim.lsp.buf.format({ async = true })
	end, bufopts)
end

-- LSP Setup
local lspconfig = require("lspconfig")
local capabilities = require("blink.cmp").get_lsp_capabilities()

local lsp_flags = {
	-- This is the default in Nvim 0.7+
	debounce_text_changes = 150,
}

-- Unused for now
local vue_plugin_location = vim.fn.expand("$HOME/.bun/install/global/node_modules/@vue/language-server")

require("typescript-tools").setup({
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
	filetypes = {
		"typescript",
		"javascript",
		"javascriptreact",
		"typescriptreact",
		"vue",
	},
	settings = {
		tsserver_plugins = {
			"@vue/typescript-plugin",
		},
	},
})

local servers = { "volar", "elixirls", "gopls", "pylsp" }
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		flags = lsp_flags,
		capabilities = capabilities,
	})
end

-- Source config.vim
vim.cmd("source ~/.config/nvim/config.vim")
