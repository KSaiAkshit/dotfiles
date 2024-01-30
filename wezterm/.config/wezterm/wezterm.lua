local wezterm = require("wezterm")
local colors = require("lua/rose-pine").colors()
local config = {}

config.colors = colors
config.enable_tab_bar = false
config.font_size = 10.0
-- config.enable_wayland = false


-- config.font = wezterm.font("JetBrainsMono NF")
config.font = wezterm.font("MonaspiceNe Nerd Font")
-- config.font_size = 11.0

config.window_background_opacity = 0.6
-- config.default_prog = { "/usr/bin/zellij", "a", "-c" }
config.window_close_confirmation = 'NeverPrompt'
config.warn_about_missing_glyphs = false

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
