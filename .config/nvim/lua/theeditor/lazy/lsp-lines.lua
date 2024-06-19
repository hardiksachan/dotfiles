return {
	"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
	config = function()
		local lsp_lines = require("lsp_lines")

		vim.diagnostic.config({
			underline = true,
			virtual_text = false,
			float = {
				show_header = true,
				source = "if_many",
				border = "rounded",
			},
		})

		vim.keymap.set("n", "<leader>l", lsp_lines.toggle, {})

		lsp_lines.setup()
	end,
}
