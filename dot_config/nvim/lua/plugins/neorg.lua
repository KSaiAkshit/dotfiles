local M = { {
	"vhyrro/luarocks.nvim",
	priority = 1000,
	config = true,
},
	{
		"nvim-neorg/neorg",
		dependencies = { "luarocks.nvim" },
		version = "*",
		config = function()
			require("neorg").setup {
				load = {
					["core.defaults"] = {},
					["core.concealer"] = {},
					["core.dirman"] = {
						config = {
							workspaces = {
								notes = "~/notes",
							},
							default_workspace = "notes",
						},
					},
				},
			}

			vim.wo.foldlevel = 99
			vim.wo.conceallevel = 2
		end,
	} }

return M
