require("akira.opts")
require("akira.utils")
require("akira.keybinds")
require("akira.autocmds")
require("akira.lazy")

-- Neovide settings
if vim.g.neovide then
	vim.o.guifont = "ZedMono Nerd Font:h12"
	-- vim.g.neovide_background_color = "#1f1d2e" .. alpha()
	vim.g.neovide_opacity = 0.8
end
