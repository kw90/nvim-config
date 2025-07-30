return {
    "zbirenbaum/copilot-cmp",
    dependencies = {
        "zbirenbaum/copilot.lua",
    },
    config = function()
        require("copilot").setup({
            suggestion = {
                enabled = false,         -- Disable the suggestion popup
            },
            panel = {
                enabled = false,         -- Disable the panel
            },
        })
        require("copilot_cmp").setup()
    end,
}
