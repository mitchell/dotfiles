-- lua/plugins/lsp_completion.lua

return {
	{
		"saghen/blink.cmp",
		dependencies = { "rafamadriz/friendly-snippets" },
		version = "1.*",
		opts = {},
		opts_extend = { "sources.default" },
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "saghen/blink.cmp" },
		config = function()
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

			local capabilities = require("blink.cmp").get_lsp_capabilities()
			local lsp_flags = { debounce_text_changes = 150 }
			local vue_plugin_location = vim.fn.expand("$HOME/.bun/install/global/node_modules/@vue/typescript-plugin")

			vim.lsp.config("ts_ls", {
				on_attach = on_attach,
				capabilities = capabilities,
				flags = lsp_flags,
				filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "vue" },
				init_options = {
					plugins = {
						{
							name = "@vue/typescript-plugin",
							location = vue_plugin_location,
							languages = { "javascript", "typescript", "vue" },
						},
					},
				},
			})

			vim.lsp.enable("ts_ls")

			require("lspconfig").volar.setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})

			local servers = { "elixirls", "gopls", "pylsp", "svelte" }
			for _, server_name in ipairs(servers) do
				vim.lsp.config(server_name, {
					on_attach = on_attach,
					capabilities = capabilities,
					flags = lsp_flags,
				})
				vim.lsp.enable(server_name)
			end
		end,
	},
}
