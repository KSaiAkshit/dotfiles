local M = {
	-- {
	-- 	"vhyrro/luarocks.nvim",
	-- 	priority = 1000,
	-- 	config = true,
	-- },
	-- TODO: Upgrade to v8 using luarocks
	{
		"nvim-neorg/neorg",
		cmd = "Neorg",
		ft = "norg",
		-- version = "*",
		version = "v7.0.0", -- Pin Neorg to the latest stable release
		-- dependencies = { "luarocks.nvim" },
		opts = {
			load = {
				["core.defaults"] = {}, -- Loads default behaviour
				["core.concealer"] = {}, -- Adds Pretty icons to docs
				["core.export"] = {},
				["core.export.markdown"] = {
					config = { extensions = "all" },
				},
				["core.keybinds"] = {
					config = {
						defaul_keybinds = true,
						neorg_leader = "<Leader>n",
					},
				},
				["core.dirman"] = {
					config = { -- Manages Neorg workspaces
						workspaces = {
							notes = "~/Documents/Notes/norg",
						},
						default_workspace = "notes",
						index = "index.norg",
					},
				},
			},
		},
	}
}

return M
