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
		"edkolev/tmuxline.vim",

		-- Editor enhancements
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
					go = { "golint", "go vet" },
					vue = { "eslint", "stylelint" },
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
					css = { "stylelint" },
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
					vue = { "prettier" },
					css = { "prettier" },
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
		"tpope/vim-eunuch",
		"tpope/vim-surround",
		-- { "airblade/vim-gitgutter", lazy = false },
		{ "echasnovski/mini.diff", version = false, opts = {} },
		{
			"reedes/vim-pencil",
			cmd = { "HardPencil", "SoftPencil" },
			config = function()
				vim.g["pencil#map#suspend_af"] = "K" -- Use bracket notation for '#'
			end,
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
			keys = {
				{
					"<leader>nn",
					"<cmd>Neotree toggle git_status<cr>",
					desc = "Neo-tree Toggle Git Status",
					silent = true,
				},
				{
					"<leader>np",
					"<cmd>Neotree float reveal_force_cwd<cr>",
					desc = "Neo-tree Float Reveal CWD",
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
				-- Note: 's' is used by flash.nvim, this mapping shadows the default 's' jump.
				-- You might want to change this leader mapping if you use flash jump often.
				{ "<leader>s", "<cmd>Telescope treesitter<cr>", desc = "Telescope Treesitter", silent = true },
				{ "<leader>ga", "<cmd>Telescope grep_string<cr>", desc = "Telescope Grep String", silent = true },
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
					inline = { adapter = "gemini_deep" },
					cmd = { adapter = "gemini_deep" },
				},
				adapters = {
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
			keys = {
				{ "<leader>c", "<cmd>CodeCompanionChat<cr>", desc = "CodeCompanion Chat", silent = true },
			},
		},
	},
})

-- General settings
vim.opt.guifont = "JetBrainsMono Nerd Font:h13"
vim.opt.colorcolumn = "100"
vim.opt.cursorline = true
vim.opt.showmatch = true
vim.opt.number = true
vim.opt.showmode = false
vim.o.background = "dark"
vim.opt.wrap = false
vim.opt.cmdheight = 1
vim.opt.shortmess:append("c")
vim.o.termguicolors = true
vim.opt.foldenable = false
vim.opt.mouse = "a"
vim.opt.mousemodel = "extend"
vim.opt.tabstop = 2
vim.opt.shiftwidth = 0
vim.opt.expandtab = true
vim.opt.textwidth = 100
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Key Mappings
local map = vim.keymap.set
local map_opts_silent = { noremap = true, silent = true }

-- General Mappings
map("i", "jj", "<Esc>", { noremap = true, silent = true, desc = "Escape Insert Mode" })
map("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true, desc = "Escape Terminal Mode" })
map("v", "//", function()
	local sel = vim.fn.getreg('"')
	local pattern = vim.fn.escape(sel, "/\\")
	vim.fn.setreg("/", "\\V" .. pattern)
	vim.cmd("normal! gN")
	vim.opt.hlsearch = true
end, { noremap = true, silent = true, desc = "Search for Visual Selection" })

-- Neovide GUI Settings
if vim.g.neovide then
	vim.g.neovide_scale_factor = 0.75
	vim.g.neovide_transparency = 0.7
	vim.g.neovide_cursor_vfx_mode = "sonicboom"
end

-- Autocommands
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Fish filetype settings
augroup("FishSettings", { clear = true })
autocmd("FileType", {
	pattern = "fish",
	command = "setlocal tabstop=4",
	group = "FishSettings",
})

-- Terminal settings
augroup("TerminalSettings", { clear = true })
autocmd("TermOpen", {
	pattern = "*",
	command = "setlocal nonumber norelativenumber",
	group = "TerminalSettings",
})

-- LSP Mappings
local opts = { silent = true }
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

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

local lsp_flags = { debounce_text_changes = 150 }

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
	settings = { tsserver_plugins = { "@vue/typescript-plugin" } },
})

local servers = { "volar", "elixirls", "gopls", "pylsp" }
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		flags = lsp_flags,
		capabilities = capabilities,
	})
end
