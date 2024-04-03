return {
	{
		"lewis6991/gitsigns.nvim",
		ft = { "gitcommit", "diff" },
		keys = {
			{ "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>",              desc = "[Gitsigns] preview hunk" },
			{ "<leader>gt", "<cmd>Gitsigns toggle_current_line_blame<CR>", desc = "[Gitsigns] Toggle line blame" },
			{ "]h",         "<cmd>Gitsigns next_hunk<CR>",                 desc = "Next Hunk" },
			{ "[h",         "<cmd>Gitsigns prev_hunk<CR>",                 desc = "Previous Hunk" },
		},
		init = function()
			-- load gitsigns only when a git file is opened
			vim.api.nvim_create_autocmd({ "BufRead" }, {
				group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
				callback = function()
					vim.fn.jobstart({ "git", "-C", vim.loop.cwd(), "rev-parse" },
						{
							on_exit = function(_, return_code)
								if return_code == 0 then
									vim.api.nvim_del_augroup_by_name "GitSignsLazyLoad"
									vim.schedule(function()
										require("lazy").load { plugins = { "gitsigns.nvim" } }
									end)
								end
							end
						}
					)
				end,
			})
		end,
		config = true,
	},
	{
		'tpope/vim-fugitive',
		dependencies = { 'tpope/vim-rhubarb' },
		lazy = true,
		cmd = "Git",
	},
	{
		"NeogitOrg/neogit",
		cmd = "Neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim",

			"nvim-telescope/telescope.nvim", -- optional
		},
		config = true
	}
}
