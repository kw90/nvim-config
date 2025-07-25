return {
    "stevearc/dressing.nvim",
    opts = {
        input = {
            insert_only = false,
        },
        mappings = {
            i = {
                ["<C-k>"] = "HistoryPrev",
                ["<C-j>"] = "HistoryNext",
            }
        }
    }
}
