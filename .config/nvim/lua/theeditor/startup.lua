-- Startup profiling and performance monitoring
local start_time = vim.loop.hrtime()

-- Function to log startup time
local function log_startup_time()
	local end_time = vim.loop.hrtime()
	local startup_time = (end_time - start_time) / 1000000 -- Convert to milliseconds
	vim.notify(string.format("Neovim started in %.2f ms", startup_time), vim.log.levels.INFO)
end

-- Log startup time after everything is loaded
vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		vim.schedule(log_startup_time)
	end,
})

-- Performance monitoring commands
vim.api.nvim_create_user_command("ProfileStart", function()
	vim.cmd("profile start profile.log")
	vim.cmd("profile func *")
	vim.cmd("profile file *")
	vim.notify("Profiling started. Use :ProfileStop to stop.", vim.log.levels.INFO)
end, {})

vim.api.nvim_create_user_command("ProfileStop", function()
	vim.cmd("profile pause")
	vim.notify("Profiling stopped. Check profile.log for results.", vim.log.levels.INFO)
end, {})

-- Memory usage command
vim.api.nvim_create_user_command("MemoryUsage", function()
	local mem_usage = vim.loop.resource_usage()
	local mem_mb = mem_usage.memory_kb / 1024
	vim.notify(string.format("Memory usage: %.2f MB", mem_mb), vim.log.levels.INFO)
end, {}) 