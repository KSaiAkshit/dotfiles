require("akira.opts")
require("akira.keybinds")
require("akira.autocmds")
require("akira.lazy")

-- Neovide settings
if vim.g.neovide then
	vim.o.guifont = "JetBrainsMono Nerd Font:h12"

	-- transparency
	local alpha = function ()
		return string.format("%x", math.floor(255 * vim.g.transparency or 0.8))
	end
	vim.g.neovide_transparency = 0.8
	vim.g.transparency = 0.8
	vim.g.neovide_background_color = "#1f1d2e" .. alpha()
end
