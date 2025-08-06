-- Performance optimizations
vim.loader.enable() -- Enable byte-compilation for faster loading

require("theeditor.startup") -- Startup profiling
require("theeditor.set")
require("theeditor.remap")
require("theeditor.lazy_init")

local augroup = vim.api.nvim_create_augroup
local theeditorGroup = augroup("theeditor", {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})

function R(name)
	require("plenary.reload").reload_module(name)
end

vim.filetype.add({
	extension = {
		templ = "templ",
	},
})

autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 40,
		})
	end,
})

autocmd({ "BufWritePre" }, {
	group = theeditorGroup,
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

-- Function to open files in a split layout and create them if they don't exist
function OpenFilesInLayout()
	-- Define file names
	local files = { "solution.cpp", "input.txt", "output.txt" }

	-- Create files if they don't exist
	for _, file in ipairs(files) do
		if vim.fn.filereadable(file) == 0 then
			vim.cmd("edit " .. file)
			vim.cmd("w") -- Write to create the file
		end
	end

	-- Copilot removed from configuration

	-- Open solution.cpp in the left split taking 70% of the width
	vim.cmd("e output.txt")
	vim.cmd("vsp solution.cpp")
	vim.cmd("wincmd l")
	vim.cmd("sp input.txt")
	vim.cmd("wincmd h")
	vim.cmd("vertical resize 100")
end

-- Create a command to call the function
vim.api.nvim_create_user_command("CPLayout", OpenFilesInLayout, {})
