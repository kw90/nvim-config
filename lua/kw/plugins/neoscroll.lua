return {
	"karb94/neoscroll.nvim",
	config = function()
		require("neoscroll").setup({
			-- Set the easing function to 'quadratic' for a faster animation
			easing_function = "quadratic", -- Default is "cubic"
			-- Set the duration of the scroll animation in milliseconds
			-- Lower values will make the animation faster
			scroll_duration = 250, -- Default is 250
		})
	end,
}
