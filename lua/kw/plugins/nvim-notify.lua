return {
	"rcarriga/nvim-notify",
	config = function()
		require("notify").setup({
			stages = "slide",
			-- Default timeout for notifications
			timeout = 500,
			background_colour = "#2E3440",
			fps = 120,
			icons = {
				DEBUG = "",
				ERROR = "",
				INFO = "",
				TRACE = "✎",
				WARN = "",
			},
			level = 2,
            top_down = false,
            render = 'wrapped-compact'
		})
	end,
}
