return {
	{
		"rose-pine/neovim",
		lazy = false,
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				variant = "moon",
				disable_background = true,
				disable_float_background = true,
				highlight_groups = {
					MiniStatuslineModeInsert = { fg = "base", bg = "foam" },
					MiniStatuslineModeNormal = { fg = "base", bg = "rose" },
					MiniStatuslineModeVisual = { fg = "base", bg = "iris" },
					MiniStatuslineModeCommand = { fg = "base", bg = "love" },
				},
			})
			vim.cmd([[colorscheme rose-pine]])
		end,
	},
	{
		"stevearc/dressing.nvim",
		config = true,
		lazy = true,
		init = function()
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.select = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.select(...)
			end
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.input = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.input(...)
			end
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			indent = {
				char = "│",
				tab_char = "│",
			},
			scope = { enabled = false },
			exclude = {
				filetypes = {
					"help",
					"alpha",
					"dashboard",
					"neo-tree",
					"Trouble",
					"trouble",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"lazyterm",
				},
			},
		},
	},
}
