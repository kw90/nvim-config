return {
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			signs = true, -- show icons in the signs column
			sign_priority = 8, -- sign priority
			-- keywords recognized as todo comments
			keywords = {
				FIX = {
					icon = " ", -- icon used for the sign, and in search results
					color = "error", -- can be a hex color, or a named color (see below)
					alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
					-- signs = false, -- configure signs for some keywords individually
				},
				TODO = { icon = " ", color = "info" },
				HACK = { icon = " ", color = "warning" },
				WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
				PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
				NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
				TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
			},
			gui_style = {
				fg = "NONE", -- The gui style to use for the fg highlight group.
				bg = "BOLD", -- The gui style to use for the bg highlight group.
			},
		},
		-- keymaps
		init = function()
			vim.keymap.set("n", "<leader>tda", "<cmd>TodoTelescope<cr>", { desc = "Show all todo comments" })
			vim.keymap.set(
				"n",
				"<leader>tdt",
				"<cmd>Trouble todo focus=true win.position=right<cr>",
				{ desc = "List all project todos in trouble" }
			)
			vim.keymap.set(
				"n",
				"<leader>tdd",
				"<cmd>TodoTelescope keywords=TODO,FIX<cr>",
				{ desc = "Show todo and fix" }
			)
		end,
	},
	{
		"numToStr/Comment.nvim",
	},
}
