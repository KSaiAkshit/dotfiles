local M = {
	{
		"folke/twilight.nvim",
		lazy = true,
		cmd = { "Twilight", "TwilightEnable", "TwilightDisable" },
		opts = {
			exclude = {
				"norg"
			}
		}
	},
	{
		"folke/zen-mode.nvim",
		lazy = true,
		cmd = "ZenMode",
		opts = {
			options = {
				relativenumber = false
			},
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
