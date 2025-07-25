return {
    "python-rope/ropevim",
    ft = "python",
    config = function()
        -- Rope refactoring keymaps
        vim.keymap.set('n', '<leader>rm', ':RopeExtractMethod<CR>', { desc = "Rope: Extract method" })
        vim.keymap.set('n', '<leader>rv', ':RopeExtractVariable<CR>', { desc = "Rope: Extract variable" })
        vim.keymap.set('n', '<leader>ri', ':RopeInline<CR>', { desc = "Rope: Inline" })
        vim.keymap.set('n', '<leader>rM', ':RopeMove<CR>', { desc = "Rope: Move" })
        vim.keymap.set('n', '<leader>rR', ':RopeRename<CR>', { desc = "Rope: Rename" })
        vim.keymap.set('n', '<leader>rs', ':RopeRestructure<CR>', { desc = "Rope: Restructure" })
    end,
}

