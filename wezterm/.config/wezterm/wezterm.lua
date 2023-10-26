local wezterm = require("wezterm")
local colors = require("lua/rose-pine").colors()
local act = wezterm.action
local config = {}

config.colors = colors
config.enable_tab_bar = false
config.font_size = 10.0


config.font = wezterm.font("JetBrainsMono Nerd Font")
-- config.font_size = 11.0

config.window_background_opacity = 0.6
-- config.default_prog = { "/usr/bin/fish", "-l" }
-- config.default_prog = { "/home/akshit/.local/scripts/zellija" }
config.default_prog = { "/usr/bin/zellij", "a", "-c" }
config.default_cursor_style = "BlinkingBar"
config.window_close_confirmation = 'NeverPrompt'

config.keys = {
  {
    key = 'E',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.QuickSelectArgs {
      label = 'open url',
      patterns = {
        'https?://\\S+',
      },
      action = wezterm.action_callback(function(window, pane)
        local url = window:get_selection_text_for_pane(pane)
        wezterm.log_info('opening: ' .. url)
        wezterm.open_with(url)
      end),
    },
  },
}

return config
