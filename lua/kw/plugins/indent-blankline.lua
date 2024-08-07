return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	opts = {
		char = "|",
		use_treesitter = true,
		show_first_indent_level = true,
		filetype_exclude = { "help", "startify", "dashboard", "packer", "neogitstatus", "NvimTree" },
		buftype_exclude = { "terminal", "nofile" },
	},
	dependencies = { "HiPhish/rainbow-delimiters.nvim" },
	config = function()
		local highlight = {
			"RainbowRed",
			"RainbowYellow",
			"RainbowBlue",
			"RainbowOrange",
			"RainbowGreen",
			"RainbowViolet",
			"RainbowCyan",
		}
		local hooks = require("ibl.hooks")
		-- create the highlight groups in the highlight setup hook, so they are reset
		-- every time the colorscheme changes
		hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
			vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
			vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
			vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
			vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
			vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
			vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
		end)

		vim.g.rainbow_delimiters = { highlight = highlight }
		require("ibl").setup({
			-- indent = { highlight = highlight },
			scope = {
				highlight = highlight,
				include = {
					node_type = {
						["*"] = {
							"function",
							"class",
							"method",
							"if_statement",
							"for_statement",
							"while_statement",
							"switch_statement",
							"try_statement",
							"catch_clause",
							-- "object",
							-- "array",
							-- "dictionary",
							-- "list",
							-- "tuple",
							-- "lambda",
							"block",
							"module",
							"program",
						}, -- Apply to all node types
					},
				},
			},
			exclude = {
				filetypes = { "dashboard", "NvimTree", "packer" },
				buftypes = { "terminal" },
			},
		})
		hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
	end,
}
