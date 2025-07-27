return {
	"hedyhli/outline.nvim",
	lazy = true,
	cmd = { "Outline", "OutlineOpen" },
	keys = { -- Example mapping to toggle outline
		{ "<leader>ot", "<cmd>Outline<cr>", desc = "Toggle outline" },
	},
    config = function()
        local outline = require("outline")

        outline.setup()
    end,
}
