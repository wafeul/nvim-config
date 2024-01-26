return {
	{
		"nvimtools/none-ls.nvim",
		lazy = false,
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.beautysh,
					null_ls.builtins.diagnostics.php,
					null_ls.builtins.formatting.phpcsfixer,
					null_ls.builtins.diagnostics.eslint_d,
					null_ls.builtins.formatting.prettier,
				},
			})
			vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
		end,
	},

	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
		config = function()
			require("mason-null-ls").setup({
				ensure_installed = {
					"beautysh",
					"stylua",
					"phpcbf",
					"phpcsfixer",
                    "eslint_d",
                    "prettier",
					"php",
				},
				handlers = {},
			})
		end,
	},
}
