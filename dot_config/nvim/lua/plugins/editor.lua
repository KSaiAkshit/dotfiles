local M = {
	{
		"kevinhwang91/nvim-bqf",
		ft = { "qf", "Trouble" },
	},
	{
		"folke/trouble.nvim",
		keys = {
			{ "<leader>D",  "<cmd>Trouble diagnostics toggle<cr>",                        desc = "Diagnostics (Trouble)", },
			{ "<leader>d",  "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",           desc = "Buffer Diagnostics (Trouble)", },
			{ "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>",                desc = "Symbols (Trouble)", },
			{ "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / references / ... (Trouble)", },
			{ "<leader>xL", "<cmd>Trouble loclist toggle<cr>",                            desc = "Location List (Trouble)", },
			{ "<leader>xQ", "<cmd>Trouble qflist toggle<cr>",                             desc = "Quickfix List (Trouble)", },
			{
				"[q",
				function()
					if require("trouble").is_open() then
						require("trouble").previous({ skip_groups = true, jump = true })
					else
						local ok, err = pcall(vim.cmd.cprev)
						if not ok then
							vim.notify(err, vim.log.levels.ERROR)
						end
					end
				end,
				desc = "Previous trouble/quickfix item",
			},
			{
				"]q",
				function()
					if require("trouble").is_open() then
						require("trouble").next({ skip_groups = true, jump = true })
					else
						local ok, err = pcall(vim.cmd.cnext)
						if not ok then
							vim.notify(err, vim.log.levels.ERROR)
						end
					end
				end,
				desc = "Next trouble/quickfix item",
			},
		},
		opts = {}, -- for default options, refer to the configuration section for custom setup.
	},
	{
		"folke/todo-comments.nvim",
		cmd = { "TodoTrouble", "TodoTelescope" },
		event = "BufReadPre",
		config = true,
		keys = {
			{ "]t",         function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
			{ "[t",         function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
			{ "<leader>xt", "<cmd>TodoTrouble<cr>",                              desc = "Todo (Trouble)" },
			{ "<leader>xx", "<cmd>TodoQuickFix<cr>",                             desc = "Todo (QuickFix)" },
			{ "<leader>st", "<cmd>TodoTelescope<cr>",                            desc = "Todo" },
		},
	},
	{
		"mbbill/undotree",
		event = "BufReadPre",
		cmd = "UndotreeToggle",
		keys = {
			{
				"<leader>uu",
				"<cmd>UndotreeToggle<cr>",
				desc = "Toggle Undotree",
			},
		},
	}
}

return M
