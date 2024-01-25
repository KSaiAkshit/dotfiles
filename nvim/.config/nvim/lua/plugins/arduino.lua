local M = {
	"glebzlat/Arduino.nvim",
	ft = "arduino",
	config = function()
		require('arduino').setup {
			default_fqbn = "arduino:avr:uno",

			--Path to clangd (all paths must be full)
			clangd = require 'mason-core.path'.bin_prefix 'clangd',
			--Path to arduino-cli
			arduino = "/usr/bin/arduino-cli",

			--Data directory of arduino-cli
			arduino_config_dir = "/home/akira/.local/share/arduino15/",
		}

		require 'lspconfig' ['arduino_language_server'].setup {
			on_new_config = arduino.on_new_config,
		}
	end
}
return M
