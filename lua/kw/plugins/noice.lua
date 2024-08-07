return {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    },
    config = function()
        require("noice").setup({
            require("notify").setup({
                -- other stuff
                background_colour = "#378a34",
            }),
            lsp = {
                hover = {
                    enabled = false, -- Disable Noice's custom hover handler
                },
            },
        })
    end,
}
