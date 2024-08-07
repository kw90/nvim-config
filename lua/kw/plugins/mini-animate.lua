return {
	"echasnovski/mini.nvim",
	version = false,
	config = function()
		require("mini.animate").setup({
			open = { enable = not require("lazy.core.config").spec.plugins["nvim-spectre"] },
			cursor = {
				timing = function(_, n)
					return 125 / n
				end,
			},
			scroll = {
				timing = function(_, n)
					return 32 / n
				end,
			},
			resize = {
				timing = function(_, n)
					return 32 / n
				end,
			},
			close = {
				timing = function(_, n)
					return 32 / n
				end,
			},
		})
	end,
}
