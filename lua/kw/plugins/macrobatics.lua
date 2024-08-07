return {
    "svermeulen/vim-macrobatics",
    dependencies = {
        "kana/vim-repeat",
    },
    config = function()
        -- Default configurations for vim-macrobatics
        vim.api.nvim_set_keymap("n", "<leader>mq", "<plug>(Mac_Play)", { desc = "Play Macro" })
        vim.api.nvim_set_keymap("n", "<leader>mgq", "<plug>(Mac_RecordNew)", { desc = "Record New Macro" })

        vim.api.nvim_set_keymap(
            "n",
            "<leader>mh",
            ":DisplayMacroHistory<CR>",
            { noremap = true, silent = true, desc = "Display Macro History" }
        )

        vim.api.nvim_set_keymap("n", "[m", "<plug>(Mac_RotateBack)", { desc = "Rotate Macro Back" })
        vim.api.nvim_set_keymap("n", "]m", "<plug>(Mac_RotateForward)", { desc = "Rotate Macro Forward" })

        vim.api.nvim_set_keymap("n", "<leader>ma", "<plug>(Mac_Append)", { desc = "Append to Macro" })
        vim.api.nvim_set_keymap("n", "<leader>mp", "<plug>(Mac_Prepend)", { desc = "Prepend to Macro" })

        vim.api.nvim_set_keymap("n", "<leader>mng", "<plug>(Mac_NameCurrentMacro)", { desc = "Name Current Macro" })
        vim.api.nvim_set_keymap(
            "n",
            "<leader>mnf",
            "<plug>(Mac_NameCurrentMacroForFileType)",
            { desc = "Name Current Macro for File Type" }
        )
        vim.api.nvim_set_keymap(
            "n",
            "<leader>mns",
            "<plug>(Mac_NameCurrentMacroForCurrentSession)",
            { desc = "Name Current Macro for Session" }
        )

        vim.api.nvim_set_keymap(
            "n",
            "<leader>mo",
            "<plug>(Mac_SearchForNamedMacroAndOverwrite)",
            { desc = "Overwrite Named Macro" }
        )
        vim.api.nvim_set_keymap(
            "n",
            "<leader>mr",
            "<plug>(Mac_SearchForNamedMacroAndRename)",
            { desc = "Rename Named Macro" }
        )
        vim.api.nvim_set_keymap(
            "n",
            "<leader>md",
            "<plug>(Mac_SearchForNamedMacroAndDelete)",
            { desc = "Delete Named Macro" }
        )
        vim.api.nvim_set_keymap(
            "n",
            "<leader>me",
            "<plug>(Mac_SearchForNamedMacroAndPlay)",
            { desc = "Play Named Macro" }
        )
        vim.api.nvim_set_keymap(
            "n",
            "<leader>ms",
            "<plug>(Mac_SearchForNamedMacroAndSelect)",
            { desc = "Select Named Macro" }
        )
    end,
}
