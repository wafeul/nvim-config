return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				-- null_ls.builtins.formatting.easy_codings_tandard,
				-- null_ls.builtins.diagnostics.easy_coding_standard,
			},
		})
		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
