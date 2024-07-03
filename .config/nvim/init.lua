local plug = vim.fn["plug#"]
vim.call("plug#begin")

-- Contains lots of sensible configurations, which I have in turn omitted from here
plug("tpope/vim-sensible")

plug("w0rp/ale")
plug("tpope/vim-eunuch")
plug("tpope/vim-surround")
plug("tpope/vim-endwise")
plug("edkolev/tmuxline.vim")
plug("airblade/vim-gitgutter")
plug("reedes/vim-pencil", { ["on"] = { "HardPencil", "SoftPencil" } })
plug("tpope/vim-fugitive", { ["on"] = { "G", "Git" }, ["for"] = "gitcommit" })

plug("MunifTanjim/nui.nvim")
plug("rcarriga/nvim-notify")
plug("nvim-lua/plenary.nvim")
plug("nvim-tree/nvim-web-devicons")

plug("ms-jpq/coq_nvim")
plug("folke/noice.nvim")
plug("ggandor/leap.nvim")
plug("folke/zen-mode.nvim")
plug("folke/twilight.nvim")
plug("neovim/nvim-lspconfig")
plug("rebelot/kanagawa.nvim")
plug("nvim-lualine/lualine.nvim")
plug("nvim-neo-tree/neo-tree.nvim")
plug("pmizio/typescript-tools.nvim")
plug("simrat39/symbols-outline.nvim")
plug("nvim-telescope/telescope.nvim")
plug("nvim-telescope/telescope-fzf-native.nvim", { ["do"] = "make" })
plug("nvim-treesitter/nvim-treesitter", { ["do"] = ":TSUpdate" })
plug("nvim-treesitter/nvim-treesitter-context")

vim.call("plug#end")

vim.opt.guifont = { "JetBrainsMono Nerd Font", "h13" }

vim.g.coq_settings = { auto_start = true }

require("kanagawa").setup({
	transparent = true,
})

require("lualine").setup()

require("zen-mode").setup({
	window = {
		backdrop = 1,
	},
})
require("symbols-outline").setup({
	autofold_depth = 2,
})
require("leap").create_default_mappings()

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
		"fish",
		"typescript",
		"javascript",
		"go",
		"elixir",
		"vue",
		"regex",
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

-- LSP Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
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
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
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
