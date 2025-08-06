function ColorMyPencils(color)
	color = color or "catppuccin-macchiato"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "none" })
end

return {
	-- Primary colorscheme (load immediately)
	{
		"rose-pine/neovim",
		name = "rose-pine",
		priority = 1000,
		config = function()
			require("rose-pine").setup({
				disable_background = true,
				styles = {
					italic = false,
				},
			})

			vim.cmd("colorscheme rose-pine")
			ColorMyPencils()
		end,
	},
	
	-- Alternative colorschemes (load on demand)
	{
		"catppuccin/nvim",
		name = "catppuccin",
		cmd = "Catppuccin",
		config = function()
			require("catppuccin").setup({
				integrations = {
					cmp = true,
					gitsigns = true,
					treesitter = true,
				},
			})
		end,
	},
	{
		"folke/tokyonight.nvim",
		cmd = "TokyoNight",
		config = function()
			require("tokyonight").setup({
				style = "storm",
				transparent = true,
				terminal_colors = true,
				styles = {
					comments = { italic = false },
					keywords = { italic = false },
					sidebars = "dark",
					floats = "dark",
				},
			})
		end,
	},
	{
		"AlexvZyl/nordic.nvim",
		cmd = "Nordic",
		config = function()
			require("nordic").load()
		end,
	},
}
