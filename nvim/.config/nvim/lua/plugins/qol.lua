local M = {
	{
		"folke/twilight.nvim",
		lazy = true,
		cmd = { "Twilight", "TwilightEnable", "TwilightDisable" },
	},
	{
		"folke/zen-mode.nvim",
		lazy = true,
		cmd = "ZenMode",
		opts = {
			plugins = {
				alacritty = {
					enabled = true,
					font = "12"
				}
			}
		}
	}
}

return M
