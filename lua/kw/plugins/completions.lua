vim.opt.completeopt = "menu,menuone,noselect"

return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-path", -- source for file system paths
		"hrsh7th/cmp-buffer", -- source for text from buffer
		"hrsh7th/cmp-nvim-lsp", -- source for completions from language server
		{
			"L3MON4D3/LuaSnip", -- snippet engine
			dependencies = {
				"saadparwaiz1/cmp_luasnip", -- luasnip completion source
				"rafamadriz/friendly-snippets", -- set of preconfigured snippets for different languages
			},
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
			end,
		},
	},
	config = function()
		local cmp = require("cmp")
		local luasnip_status, luasnip = pcall(require, "luasnip")
		if not luasnip_status then
			return
		end
		require("luasnip/loaders/from_vscode").lazy_load()

		local kind_icons = {
			Text = "󰉿",
			Method = "󰆧",
			Function = "󰊕",
			Constructor = "",
			Field = "",
			Variable = "󰀫",
			Class = "󰠱",
			Interface = "",
			Module = "",
			Property = "󰜢",
			Unit = "󰑭",
			Value = "󰎠",
			Enum = "",
			Keyword = "󰌋",
			Snippet = "",
			Color = "󰏘",
			File = "󰈙",
			Reference = "",
			Folder = "󰉋",
			EnumMember = "",
			Constant = "󰏿",
			Struct = "",
			Event = "",
			Operator = "󰆕",
			TypeParameter = " ",
			Misc = " ",
			Copilot = "",
			Codeium = "",
		}
		-- find more here: https://www.nerdfonts.com/cheat-sheet
		vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#00FF00" }) -- Green color
		vim.api.nvim_set_hl(0, "CmpItemKindCodeium", { fg = "#A0F0F0" }) -- LightBlue color

		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
				["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
				["<C-b>"] = cmp.mapping.scroll_docs(-4), -- scroll docs backwards
				["<C-f>"] = cmp.mapping.scroll_docs(4), -- scroll docs forwards
				["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
				["<C-e>"] = cmp.mapping.abort(), -- close completion window
				["<CR>"] = cmp.mapping.confirm({ select = false }),
				["<Tab>"] = cmp.mapping.select_next_item(),
				["<S-Tab>"] = cmp.mapping.select_prev_item(),
			}),
			formatting = {
				fields = { "kind", "abbr", "menu" },
				format = function(entry, vim_item)
					-- Kind icons
					vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
					-- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
					vim_item.menu = ({
						nvim_lsp = "[LSP]",
						luasnip = "[Snippet]",
						buffer = "[Buffer]",
						path = "[Path]",
                        copilot = "[Copilot]",
                        codeium = "[Codeium]",
					})[entry.source.name]
					return vim_item
				end,
			},
			sources = cmp.config.sources({
				{ name = "codeium" }, -- codeium
				{ name = "copilot" }, -- copilot
				{ name = "nvim_lsp" }, -- lsp completions
				{ name = "luasnip" }, -- text from buffer
				{ name = "nvim_lua" }, -- Neovim Lua API
				{ name = "treesitter" }, -- Treesitter
				{ name = "buffer" }, -- text from buffer
				{ name = "path" }, -- file system paths
			}),
			experimental = {
				ghost_text = false,
				native_menu = false,
			},
		})
	end,
}
