return {
	"kevinhwang91/nvim-ufo",
	event = "BufReadPost",
	dependencies = {
		"kevinhwang91/promise-async",
		"nvim-treesitter/nvim-treesitter",
	},
	init = function()
		vim.o.foldenable = true
		vim.o.foldcolumn = "0"
		vim.o.foldlevel = 99
		vim.o.foldlevelstart = 99
		vim.o.fillchars = "eob: ,fold: ,foldopen:,foldsep:│,foldclose:"
	end,
	config = function()
		local ufo = require("ufo")

		ufo.setup({
			provider_selector = function(bufnr, filetype, buftype)
				return { "lsp", "indent" }
			end,
		})

		vim.keymap.set("n", "zR", ufo.openAllFolds, { desc = "Open all folds" })
		vim.keymap.set("n", "ZM", ufo.closeAllFolds, { desc = "Close all folds" })
		vim.keymap.set("n", "zK", function()
			local winid = ufo.peekFoldedLinesUnderCursor()
			if not winid then
				vim.lsp.buf.hover()
			end
		end, { desc = "Peek Fold" })
	end,
}
