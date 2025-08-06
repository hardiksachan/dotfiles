vim.g.mapleader = " "

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.inccommand = "split"

-- best search settings
vim.opt.smartcase = true
vim.opt.ignorecase = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

-- Performance optimizations
vim.opt.lazyredraw = true -- Don't redraw while executing macros
vim.opt.hidden = true -- Allow switching buffers without saving
vim.opt.backup = false -- Don't create backup files
vim.opt.swapfile = false -- Don't create swap files
vim.opt.writebackup = false -- Don't create write backup files

-- vim.opt.conceallevel = 1

-- Folding configuration
vim.opt.foldenable = true
vim.opt.foldcolumn = "1"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.fillchars = "eob: ,fold: ,foldopen:,foldsep:│,foldclose:"
