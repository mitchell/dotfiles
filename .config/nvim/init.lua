local plug = vim.fn["plug#"]
vim.call("plug#begin")

plug("w0rp/ale")
plug("tpope/vim-eunuch")
plug("tpope/vim-surround")
plug("edkolev/tmuxline.vim")
plug("airblade/vim-gitgutter")
plug("reedes/vim-pencil", { ["on"] = { "HardPencil", "SoftPencil" } })
plug("tpope/vim-fugitive", { ["on"] = { "G", "Git" }, ["for"] = "gitcommit" })

plug("MunifTanjim/nui.nvim")
plug("rcarriga/nvim-notify")
plug("nvim-lua/plenary.nvim")
plug("nvim-tree/nvim-web-devicons")

plug("ms-jpq/coq_nvim", { ["branch"] = "coq" })
plug("ms-jpq/coq.artifacts", { ["branch"] = "artifacts" })
plug("folke/noice.nvim")
plug("folke/flash.nvim")
plug("folke/zen-mode.nvim")
plug("folke/twilight.nvim")
plug("neovim/nvim-lspconfig")
plug("rebelot/kanagawa.nvim")
plug("akinsho/bufferline.nvim")
plug("nvim-lualine/lualine.nvim")
plug("nvim-neo-tree/neo-tree.nvim")
plug("pmizio/typescript-tools.nvim")
plug("simrat39/symbols-outline.nvim")
plug("nvim-telescope/telescope.nvim")
plug("nvim-telescope/telescope-fzf-native.nvim", { ["do"] = "make" })
plug("nvim-treesitter/nvim-treesitter", { ["do"] = ":TSUpdate" })
plug("nvim-treesitter/nvim-treesitter-context")

vim.call("plug#end")

vim.opt.guifont = "JetBrainsMono Nerd Font:h13"

vim.g.coq_settings = { auto_start = true }

require("neo-tree").setup()

require("kanagawa").setup({
	transparent = not vim.g.neovide,
})

require("bufferline").setup({
	options = {
		separator_style = "slope",
		offsets = {
			{
				filetype = "neo-tree",
				text = "explorer",
				highlight = "Directory",
				separator = true, -- use a "true" to enable the default, or set your own character
			},
		},
	},
})

require("lualine").setup({
	extensions = {
		"neo-tree",
		"symbols-outline",
	},
})

require("zen-mode").setup({
	window = {
		backdrop = 0.95,
	},
	plugins = {
		twilight = { enabled = false }, -- enable to start Twilight when zen mode opens
	},
})
require("symbols-outline").setup({
	autofold_depth = 2,
})

require("notify").setup({
	background_colour = "#000000",
})

require("telescope").setup()
require("telescope").load_extension("fzf")

require("noice").setup({
	lsp = {
		-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true,
		},
	},
	presets = {
		bottom_search = true, -- use a classic bottom cmdline for search
		command_palette = true, -- position the cmdline and popupmenu together
		long_message_to_split = true, -- long messages will be sent to a split
	},
	views = {
		notify = {
			replace = true,
			merge = true,
		},
	},
})

require("nvim-treesitter.configs").setup({
	-- A list of parser names, or "all" (the four listed parsers should always be installed)
	ensure_installed = {
		"c",
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
		"hcl",
		"terraform",
	},

	-- Automatically install missing parsers when entering buffer
	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	auto_install = false,

	highlight = {
		enable = true,
		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},

	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "gnn", -- set to `false` to disable one of the mappings
			node_incremental = "grn",
			scope_incremental = "grc",
			node_decremental = "grm",
		},
	},

	indent = {
		enable = true,
	},
})

-- Map Leader
vim.g.mapleader = ","

-- Flash config
local flash = require("flash")
flash.setup()
vim.keymap.set({ "n", "x", "o" }, "s", flash.jump, { desc = "Flash" })
vim.keymap.set({ "n", "x", "o" }, "S", flash.treesitter, { desc = "Flash Treesitter" })
vim.keymap.set("o", "r", flash.remote, { desc = "Remote Flash" })
vim.keymap.set({ "o", "x" }, "R", flash.treesitter_search, { desc = "Treesitter Search" })
vim.keymap.set("c", "<c-s>", flash.toggle, { desc = "Toggle Flash Search" })

-- LSP Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
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

local lspconfig = require("lspconfig")
local coq = require("coq")

local lsp_flags = {
	-- This is the default in Nvim 0.7+
	debounce_text_changes = 150,
}

-- Unused for now
local vue_plugin_location = vim.fn.expand("$HOME/.bun/install/global/node_modules/@vue/language-server")

require("typescript-tools").setup(coq.lsp_ensure_capabilities({
	on_attach = on_attach,
	flags = lsp_flags,
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
}))

local servers = { "volar", "elixirls", "gopls", "pylsp" }
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup(coq.lsp_ensure_capabilities({
		on_attach = on_attach,
		flags = lsp_flags,
	}))
end

vim.cmd("source ~/.config/nvim/config.vim")
