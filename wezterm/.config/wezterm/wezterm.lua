local wezterm = require("wezterm")
local colors = require("lua/rose-pine").colors()
local config = {
	colors = colors,
	enable_tab_bar = false,
	font_size = 10.0,
}

config.font = wezterm.font("JetBrainsMono Nerd Font")
-- config.font_size = 11.0

config.window_background_opacity = 0.6
-- config.default_prog = { "/usr/bin/fish", "-l" }
-- config.default_prog = { "/home/akshit/.local/scripts/zellija" }
config.default_prog = { "/usr/bin/zellij", "a", "-c" }
config.default_cursor_style = "BlinkingBar"
config.window_close_confirmation = 'NeverPrompt'

return config
