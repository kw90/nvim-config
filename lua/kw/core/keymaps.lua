-- Set space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = ";"

local keymap = vim.keymap -- for conciseness

-- Set system clipboard
vim.opt.clipboard = "unnamed,unnamedplus"

-- General keymaps --
-- clear search highlights
keymap.set("n", "<leader>nh", "<cmd>nohl<cr>", { desc = "Clear search highlights" })

-- yank to system clipboard using leader key
keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })

-- Move up and down by visual (wrapped) lines
keymap.set("n", "j", "gj", { noremap = true, silent = true })
keymap.set("n", "k", "gk", { noremap = true, silent = true })

-- Toggle wrap mode
local function toggle_wrap_mode()
	local window_options = vim.wo -- for conciseness

	-- Toggle options
	window_options.wrap = not window_options.wrap
	window_options.linebreak = not window_options.linebreak
	window_options.cursorline = not window_options.cursorline

	print("Toggled wrap", window_options.wrap)
end
keymap.set("n", "<leader>w", toggle_wrap_mode, { desc = "Toggle wrap" })

-- Buffer management
keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
keymap.set("n", "<C-x>", "<cmd>BufDel<cr>", { desc = "Close Buffer" })
keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete Buffer" })

-- Visuals when scrolling and moving things around
keymap.set("v", "K", ":m '<-2<CR>gv=gv")
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("n", "J", "mzJ`z")
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

-- Avoid overwriting yank
keymap.set("x", "p", "P")
-- Remap <leader>p to the original p (paste from the clipboard) in visual mode
keymap.set("x", "<leader>p", "p")

-- Replace
keymap.set("n", "<C-s>", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Plugins keymaps --
vim.keymap.set("n", "<leader>ca", function()
	require("tiny-code-action").code_action()
end, { noremap = true, silent = true })
