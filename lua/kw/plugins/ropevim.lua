return {
    "python-rope/ropevim",
    ft = "python",
    build = "pip install rope ropevim pynvim",
    config = function()
        vim.g.ropevim_enable_shortcuts = 0
        -- Rope refactoring keymaps
        vim.keymap.set('n', '<leader>rm', ':RopeExtractMethod<CR>', { desc = "Rope: Extract method" })
        vim.keymap.set('n', '<leader>rv', ':RopeExtractVariable<CR>', { desc = "Rope: Extract variable" })
        vim.keymap.set('n', '<leader>ri', ':RopeInline<CR>', { desc = "Rope: Inline" })
        vim.keymap.set('n', '<leader>rM', ':RopeMove<CR>', { desc = "Rope: Move" })
        vim.keymap.set('n', '<leader>rs', ':RopeRestructure<CR>', { desc = "Rope: Restructure" })
        vim.keymap.set('n', '<leader>ro', ':RopeOrganizeImports<CR>', { desc = "Rope: Organize imports" })
        vim.keymap.set('n', '<leader>rg', ':RopeGenerateFunction<CR>', { desc = "Rope: Generate function" })
        vim.keymap.set('n', '<leader>rc', ':RopeChangeSignature<CR>', { desc = "Rope: Change signature" })
        vim.keymap.set('n', '<leader>ru', ':RopeUndo<CR>', { desc = "Rope: Undo refactoring" })
        vim.keymap.set('n', '<leader>rr', ':RopeRedo<CR>', { desc = "Rope: Redo refactoring" })
    end,
}
