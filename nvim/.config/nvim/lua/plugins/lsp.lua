return {
	{
		"neovim/nvim-lspconfig",
		event =  { 'BufReadPre', 'BufNewFile' },
	},
	{
		"williamboman/mason.nvim",
		cmd = { 'Mason', 'MasonInstall', 'MasonUninstall', 'MasonLog', 'MasonUpdate' },
	},
	{
		"williamboman/mason-lspconfig.nvim",
		event =  { 'BufReadPre', 'BufNewFile' },
		dependencies = {
			{
				"williamboman/mason.nvim",
				"neovim/nvim-lspconfig",
			},
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "rust_analyzer", "pyright" }
			})

			require("mason-lspconfig").setup_handlers{
				function (server_name)
					require("lspconfig")[server_name].setup{}
				end,
			}
		end
	}
}
