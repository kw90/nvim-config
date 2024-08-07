return {
	{
        "tpope/vim-fugitive"
    },
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			local gitsigns = require("gitsigns")
			gitsigns.setup()

			vim.keymap.set("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", { desc = "Git preview hunk" })
			vim.keymap.set(
				"n",
				"<leader>gbb",
				"<cmd>Gitsigns toggle_current_line_blame<cr>",
				{ desc = "Git blame toggle " }
			)
		end,
	},
}
