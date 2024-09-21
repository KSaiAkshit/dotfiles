return {
	{
		"neovim/nvim-lspconfig",
		event =  { 'BufReadPre', 'BufNewFile' },
    config = function ()
      require('lspconfig.ui.windows').default_options.border = 'rounded'
    end
	},
	{
		"williamboman/mason.nvim",
		cmd = { 'Mason', 'MasonInstall', 'MasonUninstall', 'MasonLog', 'MasonUpdate' },
		opts = {
			ui = {
				border = "rounded",
			}
		}
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
				ensure_installed = { "lua_ls", "pyright" },
				automatic_installation = { exclude = "rust_analyzer" }
			})

			require("mason-lspconfig").setup_handlers{
				function (server_name)
					require("lspconfig")[server_name].setup{}
				end,
			}
		end
	}
}
