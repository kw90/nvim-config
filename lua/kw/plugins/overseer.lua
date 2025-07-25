return {
    "stevearc/overseer.nvim",
    dependencies = {
        "akinsho/toggleterm.nvim", -- optional, for terminal strategy
    },
    config = function()
        local overseer = require("overseer")

        -- Setup overseer
        overseer.setup({
            templates = { "builtin", "vscode" },
            strategy = {
                "toggleterm",
                direction = "horizontal",
                auto_scroll = true,
                quit_on_exit = "success"
            },
            component_aliases = {
                default = {
                    { "display_duration", detail_level = 2 },
                    "on_output_summarize",
                    "on_exit_set_status",
                    "on_complete_notify",
                    "on_complete_dispose",
                },
            },
        })

        -- Keymaps
        vim.keymap.set("n", "<leader>oo", overseer.toggle, { desc = "Toggle Overseer" })
        vim.keymap.set("n", "<leader>or", "<cmd>OverseerRun<cr>", { desc = "Run Task" })
        vim.keymap.set("n", "<leader>oa", "<cmd>OverseerTaskAction<cr>", { desc = "Task Action" })
        vim.keymap.set("n", "<leader>ol", "<cmd>OverseerLoadBundle<cr>", { desc = "Load Bundle" })
        vim.keymap.set("n", "<leader>os", "<cmd>OverseerSaveBundle<cr>", { desc = "Save Bundle" })
        vim.keymap.set("n", "<leader>oq", "<cmd>OverseerQuickAction<cr>", { desc = "Quick Action" })
        vim.keymap.set("n", "<leader>oi", "<cmd>OverseerInfo<cr>", { desc = "Overseer Info" })
    end,
}
