return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"sindrets/diffview.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	cmd = "Neogit",
	keys = {
		{ "<leader>gg", "<cmd>Neogit<cr>", desc = "Neogit" },
	},
	config = function()
		require("neogit").setup({
			disable_signs = false,
			disable_hint = false,
			disable_context_highlighting = false,
			disable_commit_confirmation = false,
			auto_refresh = true,
			disable_builtin_notifications = false,
			use_magit_keybindings = false,
			commit_popup = {
				kind = "split",
			},
			popup = {
				kind = "split",
			},
			signs = {
				-- { CLOSED, OPENED }
				section = { ">", "v" },
				item = { ">", "v" },
				hunk = { "", "" },
			},
			integrations = {
				diffview = true,
			},
			-- Setting any section to `false` will make the section not render at all
			sections = {
				untracked = {
					folded = false,
				},
				unstaged = {
					folded = false,
				},
				staged = {
					folded = false,
				},
				stashes = {
					folded = true,
				},
				unpulled = {
					folded = true,
				},
				unmerged = {
					folded = false,
				},
				recent = {
					folded = true,
				},
			},
			-- override/add mappings
			mappings = {
				-- modify status buffer mappings
				status = {
					-- Adds a mapping with "B" as key that does the "BranchPopup" command
					["B"] = "BranchPopup",
					-- Removes the default mapping of "s"
					["s"] = "",
				},
			},
		})
	end,
} 