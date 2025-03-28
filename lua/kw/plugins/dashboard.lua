return {
	"nvimdev/dashboard-nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", "nvim-lua/plenary.nvim" },
	event = "VimEnter",
	config = function()
		local dashboard = require("dashboard")

		local conf = {}
		conf.header = {
			"",
			"",
			"",
			"",
			"",
			" ████████╗███████╗██████╗ ███╗   ███╗██╗███╗   ██╗ █████╗ ██╗         ████████╗██╗   ██╗██████╗ ██████╗ ██╗███╗   ██╗███████╗ ",
			" ╚══██╔══╝██╔════╝██╔══██╗████╗ ████║██║████╗  ██║██╔══██╗██║         ╚══██╔══╝██║   ██║██╔══██╗██╔══██╗██║████╗  ██║██╔════╝ ",
			"    ██║   █████╗  ██████╔╝██╔████╔██║██║██╔██╗ ██║███████║██║            ██║   ██║   ██║██████╔╝██████╔╝██║██╔██╗ ██║█████╗   ",
			"    ██║   ██╔══╝  ██╔══██╗██║╚██╔╝██║██║██║╚██╗██║██╔══██║██║            ██║   ██║   ██║██╔══██╗██╔══██╗██║██║╚██╗██║██╔══╝   ",
			"    ██║   ███████╗██║  ██║██║ ╚═╝ ██║██║██║ ╚████║██║  ██║███████╗       ██║   ╚██████╔╝██║  ██║██████╔╝██║██║ ╚████║███████╗ ",
			"    ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝       ╚═╝    ╚═════╝ ╚═╝  ╚═╝╚═════╝ ╚═╝╚═╝  ╚═══╝╚══════╝ ",
			"",
			"",
			"",
			"",
			"",
		}
		dashboard.setup({
			theme = "hyper",
			shortcut_type = "number",
			config = conf,
		})
	end,
}
