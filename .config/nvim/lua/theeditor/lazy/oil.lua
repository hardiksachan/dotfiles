return {
	"stevearc/oil.nvim",
	cmd = "Oil",
	keys = { { "-", "<cmd>Oil<cr>", desc = "Oil" } },
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("oil").setup({
			columns = { "icon" },
			delete_to_trash = true,
			skip_confirm_for_simple_edits = true,
			keymaps = {
				["<C-h>"] = false,
				["<M-h>"] = "actions.select_split",
			},
			view_options = {
				show_hidden = true,
				natural_order = true,
			},
		})


	end,
}
