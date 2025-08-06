vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- copy current file to system clipboard
vim.keymap.set("n", "<C-a>", [[:%y+<CR>]])

-- moving around in splits
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>")

-- control size of splits
vim.keymap.set("n", "<M-->", "<c-w>5<")
vim.keymap.set("n", "<M-=>", "<c-w>5>")
vim.keymap.set("n", "<M-t>", "<c-w>+")
vim.keymap.set("n", "<M-s>", "<c-w>-")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- tab stuff
vim.keymap.set("n", "<leader>to", "<cmd>tabnew<CR>") --open new tab
vim.keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>") --close current tab
vim.keymap.set("n", "<leader>tn", "<cmd>tabn<CR>") --go to next
vim.keymap.set("n", "<leader>tp", "<cmd>tabp<CR>") --go to pre
vim.keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>") --open current tab in new tab

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<leader>f", function()
	vim.lsp.buf.format({ async = true }) -- Ensures formatting is done asynchronously
end, { noremap = true, silent = true })

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>ee", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>")

-- Competetive Programming
vim.keymap.set(
	"n",
	"<leader>gcp",
	"<ESC> :w<CR>:!clang++ -fsanitize=address -std=c++17 -Wall -Wextra -Wshadow -DONPC -O2 % -o %<.out && ./%<.out < input.txt > output.txt<CR>"
)

vim.keymap.set(
	"n",
	"<leader>cp",
	"<ESC> :w<CR>:!clang++ -fsanitize=address -std=c++17 -Wall -Wextra -Wshadow -DONPC -O2 % -o %<.out && ./%<.out <CR>"
)

-- Folding keymaps
vim.keymap.set("n", "zR", ":set foldlevel=99<CR>", { desc = "Open all folds" })
vim.keymap.set("n", "zM", ":set foldlevel=0<CR>", { desc = "Close all folds" })
vim.keymap.set("n", "zr", ":set foldlevel+=1<CR>", { desc = "Open one more fold level" })
vim.keymap.set("n", "zm", ":set foldlevel-=1<CR>", { desc = "Close one more fold level" })
vim.keymap.set("n", "zo", "za", { desc = "Toggle fold under cursor" })
vim.keymap.set("n", "zO", "zA", { desc = "Toggle fold under cursor recursively" })

-- Copilot keymaps for better integration
vim.keymap.set("i", "<Tab>", function()
	if require("copilot.suggestion").is_visible() then
		require("copilot.suggestion").accept()
	else
		vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, true, true), "")
	end
end, { desc = "Accept Copilot suggestion or insert tab" })

vim.keymap.set("i", "<S-Tab>", function()
	if require("copilot.suggestion").is_visible() then
		require("copilot.suggestion").dismiss()
	else
		vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<S-Tab>", true, true, true), "")
	end
end, { desc = "Dismiss Copilot suggestion or insert shift-tab" })

-- Copilot panel commands
vim.keymap.set("n", "<leader>cp", "<cmd>Copilot panel<CR>", { desc = "Open Copilot panel" })
vim.keymap.set("n", "<leader>cs", "<cmd>Copilot status<CR>", { desc = "Show Copilot status" })
