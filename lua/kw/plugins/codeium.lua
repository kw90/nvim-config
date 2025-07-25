return {
	"Exafunction/windsurf.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"hrsh7th/nvim-cmp",
	},
	config = function()
		require("codeium").setup({
			enable_chat = true,
		})
		vim.api.nvim_set_keymap("n", "<leader>cw", "<cmd>Codeium Chat<CR>", { noremap = true, silent = true })
	end,
}
