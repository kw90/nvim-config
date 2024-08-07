return {
    "mrjones2014/smart-splits.nvim",
    config = function()
        -- Smart Splits
        local smart_splits = require("smart-splits")
        local keymap = vim.keymap

        smart_splits.setup({
            ignored_buftypes = { "terminal", "quickfix", "nofile", "prompt", "help" },
            ignored_filetypes = { "NvimTree" },
        })

        keymap.set("n", "<A-h>", smart_splits.resize_left)
        keymap.set("n", "<A-j>", smart_splits.resize_down)
        keymap.set("n", "<A-k>", smart_splits.resize_up)
        keymap.set("n", "<A-l>", smart_splits.resize_right)

        -- moving between splits
        keymap.set("n", "<C-h>", smart_splits.move_cursor_left, {noremap = true, silent = true})
        keymap.set("n", "<C-j>", smart_splits.move_cursor_down, {noremap = true, silent = true})
        keymap.set("n", "<C-k>", smart_splits.move_cursor_up, {noremap = true, silent = true})
        keymap.set("n", "<C-l>", smart_splits.move_cursor_right, {noremap = true, silent = true})
        keymap.set("n", "<C-;>", smart_splits.move_cursor_previous, {noremap = true, silent = true})

        -- swapping buffers between windows
        keymap.set("n", "<leader><leader>h", smart_splits.swap_buf_left)
        keymap.set("n", "<leader><leader>j", smart_splits.swap_buf_down)
        keymap.set("n", "<leader><leader>k", smart_splits.swap_buf_up)
        keymap.set("n", "<leader><leader>l", smart_splits.swap_buf_right)
    end,
}
