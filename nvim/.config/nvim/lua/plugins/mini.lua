return {
	"echasnovski/mini.nvim",
	config = function()
		require("mini.ai").setup()
		require("mini.align").setup()
		-- require("mini.animate").setup()

		-- vim.cmd("lua MiniAnimate.config.cursor.path = MiniAnimate.gen_path.angle()")

		--FIXME: Doesn't work for now...
		local colors = {
			base00 = "#1F1F28",
			base01 = "#2A2A37",
			base02 = "#223249",
			base03 = "#727169",
			base04 = "#C8C093",
			base05 = "#DCD7BA",
			base06 = "#938AA9",
			base07 = "#363646",
			base08 = "#C34043",
			base09 = "#FFA066",
			base0A = "#DCA561",
			base0B = "#98BB6C",
			base0C = "#7FB4CA",
			base0D = "#7E9CD8",
			base0E = "#957FB8",
			base0F = "#D27E99",

		}

			local oxocarbon = {
				-- Oxocarbon
				base00 = "#161616",
				base01 = "#262626",
				base02 = "#393939",
				base03 = "#525252",
				base04 = "#dde1e6",
				base05 = "#f2f4f8",
				base06 = "#ffffff",
				base07 = "#08bdba",
				base08 = "#3ddbd9",
				base09 = "#78a9ff",
				base0A = "#ee5396",
				base0B = "#33b1ff",
				base0C = "#ff7eb6",
				base0D = "#42be65",
				base0E = "#be95ff",
				base0F = "#82cfff",
			}
			local kanagawa = {
				-- Kanagawa
				base00 = "#1F1F28",
				base01 = "#2A2A37",
				base02 = "#223249",
				base03 = "#727169",
				base04 = "#C8C093",
				base05 = "#DCD7BA",
				base06 = "#938AA9",
				base07 = "#363646",
				base08 = "#C34043",
				base09 = "#FFA066",
				base0A = "#DCA561",
				base0B = "#98BB6C",
				base0C = "#7FB4CA",
				base0D = "#7E9CD8",
				base0E = "#957FB8",
				base0F = "#D27E99",
			}
		require("mini.base16").setup({
			palette = oxocarbon
			-- palette = {
			-- 	-- Oxocarbon
			-- 	base00 = "#161616",
			-- 	base01 = "#262626",
			-- 	base02 = "#393939",
			-- 	base03 = "#525252",
			-- 	base04 = "#dde1e6",
			-- 	base05 = "#f2f4f8",
			-- 	base06 = "#ffffff",
			-- 	base07 = "#08bdba",
			-- 	base08 = "#3ddbd9",
			-- 	base09 = "#78a9ff",
			-- 	base0A = "#ee5396",
			-- 	base0B = "#33b1ff",
			-- 	base0C = "#ff7eb6",
			-- 	base0D = "#42be65",
			-- 	base0E = "#be95ff",
			-- 	base0F = "#82cfff",
			-- }

			-- palette = {
			-- 	base00 = "#1F1F28",
			-- 	base01 = "#2A2A37",
			-- 	base02 = "#223249",
			-- 	base03 = "#727169",
			-- 	base04 = "#C8C093",
			-- 	base05 = "#DCD7BA",
			-- 	base06 = "#938AA9",
			-- 	base07 = "#363646",
			-- 	base08 = "#C34043",
			-- 	base09 = "#FFA066",
			-- 	base0A = "#DCA561",
			-- base0B = "#98BB6C",
			-- 	base0C = "#7FB4CA",
			-- 	base0D = "#7E9CD8",
			-- 	base0E = "#957FB8",
			-- 	base0F = "#D27E99",
			--
			-- }
		})
		require("mini.bracketed").setup()
		require("mini.bufremove").setup()
		local miniclue = require('mini.clue')

		miniclue.setup({
			triggers = {
				-- Leader triggers
				{ mode = 'n', keys = '<Leader>' },
				{ mode = 'x', keys = '<Leader>' },

				-- Built-in completion
				{ mode = 'i', keys = '<C-x>' },

				-- `g` key
				{ mode = 'n', keys = 'g' },
				{ mode = 'x', keys = 'g' },

				-- Marks
				{ mode = 'n', keys = "'" },
				{ mode = 'n', keys = '`' },
				{ mode = 'x', keys = "'" },
				{ mode = 'x', keys = '`' },

				-- Registers
				{ mode = 'n', keys = '"' },
				{ mode = 'x', keys = '"' },
				{ mode = 'i', keys = '<C-r>' },
				{ mode = 'c', keys = '<C-r>' },

				-- Window commands
				{ mode = 'n', keys = '<C-w>' },

				-- `z` key
				{ mode = 'n', keys = 'z' },
				{ mode = 'x', keys = 'z' },

				-- `[` `]` brackets from mini.bracketed
				{ mode = 'n', keys = '[' },
				{ mode = 'x', keys = '[' },

				{ mode = 'n', keys = ']' },
				{ mode = 'x', keys = ']' },

				-- `d` key
				{ mode = 'n', keys = 'd' },
				{ mode = 'x', keys = 'd' },
				{ mode = 'v', keys = 'd' },

				-- `c` key
				{ mode = 'n', keys = 'c' },
				{ mode = 'x', keys = 'c' },
				{ mode = 'v', keys = 'c' },

				-- `s` key from mini.surround
				{ mode = 'v', keys = 's' },
				{ mode = 'n', keys = 's' },
			},

			clues = {
				-- Enhance this by adding descriptions for <Leader> mapping groups
				miniclue.gen_clues.builtin_completion(),
				miniclue.gen_clues.g(),
				miniclue.gen_clues.marks(),
				miniclue.gen_clues.registers(),
				miniclue.gen_clues.windows(),
				miniclue.gen_clues.z(),
				{ mode = 'n', keys = '<Leader>f', desc = "+find" },
				{ mode = 'n', keys = '<Leader>s', desc = "+search" },
				{ mode = 'n', keys = '<Leader>p', desc = "+Pick" },
				{ mode = 'n', keys = '<Leader>b', desc = "+buffer" },
				{ mode = 'n', keys = '<Leader>g', desc = "+git" },
				{ mode = 'n', keys = '<Leader>u', desc = "+ui" },
				{ mode = 'n', keys = '<Leader>w', desc = "+workspace" },
			},
			window = {
				-- Show window immediately
				delay = 50,
				config = {
					width = 'auto',
				}
			}
		})
		require("mini.comment").setup()
		require("mini.completion").setup()

		vim.keymap.set('i', '<Tab>', [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true })
		vim.keymap.set('i', '<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true })

		vim.api.nvim_set_keymap('i', '<Down>', [[pumvisible() ? "<C-o>j" : "\<Down>"]], { expr = true, noremap = true })
		vim.api.nvim_set_keymap('i', '<Up>', [[pumvisible() ? "<C-o>k" : "\<Up>"]], { expr = true, noremap = true })
		require("mini.cursorword").setup()
		require("mini.doc").setup()
		require("mini.extra").setup()
		require("mini.files").setup()
		require("mini.notify").setup()
		require("mini.fuzzy").setup()
		local hipatterns = require('mini.hipatterns')
		hipatterns.setup({
			highlighters = {
				-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
				fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
				hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
				todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
				note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },
				-- Highlight hex color strings (`#rrggbb`) using that color
				hex_color = hipatterns.gen_highlighter.hex_color(),
			},
		})
		require('mini.indentscope').setup({
			delay = 10,
			symbol = "│" -- Character is called BOX DRAWING LEFT VERTICAL
		})
		require("mini.jump").setup()
		require("mini.jump2d").setup()
		require("mini.map").setup()
		require("mini.misc").setup()
		require("mini.move").setup {
			mappings = {
				-- Visual Mode
				left = '<C-h>',
				down = '<C-j>',
				up = '<C-k>',
				right = '<C-l>',
			}
		}
		require("mini.operators").setup()
		require("mini.pairs").setup()
		require("mini.pick").setup()
		require("mini.sessions").setup {
			autoread = false,
			autowrite = true,
		}
		require("mini.splitjoin").setup()
		require("mini.starter").setup()
		require("mini.statusline").setup()
		require("mini.surround").setup()
		require("mini.tabline").setup()
		require("mini.trailspace").setup()
		require("mini.visits").setup()
	end
}
