vim.opt.completeopt = "menu,menuone,noselect"

return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-path",                     -- source for file system paths
        "hrsh7th/cmp-buffer",                   -- source for text from buffer
        "hrsh7th/cmp-nvim-lsp",                 -- source for completions from language server
        {
            "L3MON4D3/LuaSnip",                 -- snippet engine
            dependencies = {
                "saadparwaiz1/cmp_luasnip",     -- luasnip completion source
                "rafamadriz/friendly-snippets", -- set of preconfigured snippets for different languages
            },
            config = function()
                require("luasnip.loaders.from_vscode").lazy_load()
            end,
        },
        -- {
        --     "milanglacier/minuet-ai.nvim",
        --     config = function()
        --         require('minuet').setup {
        --             -- Your configuration options here
        --             provider = 'claude',
        --             provider_options = {
        --                 claude = {
        --                     max_tokens = 512,
        --                     model = "claude-3-5-haiku-20241022",
        --                     -- system = "see [Prompt] section for the default value",
        --                     -- few_shots = "see [Prompt] section for the default value",
        --                     -- chat_input = "See [Prompt Section for default value]",
        --                     stream = true,
        --                     api_key = 'CLAUDE_API_KEY',
        --                     optional = {
        --                         -- pass any additional parameters you want to send to claude request,
        --                         -- e.g.
        --                         -- stop_sequences = nil,
        --                     },
        --                 },
        --             }
        --         }
        --     end,
        -- },
        { 'nvim-lua/plenary.nvim' },
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
            Codeium = "",
            Minuet = "🤖",
        }
        -- find more here: https://www.nerdfonts.com/cheat-sheet
        vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#00FF00" }) -- Green color
        vim.api.nvim_set_hl(0, "CmpItemKindCodeium", { fg = "#A0F0F0" }) -- LightBlue color
        vim.api.nvim_set_hl(0, "CmpItemKindMinuet", { fg = "#9580FF" })  -- Purple color for Minuet

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
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),    -- scroll docs backwards
                ["<C-f>"] = cmp.mapping.scroll_docs(4),     -- scroll docs forwards
                ["<C-Space>"] = cmp.mapping.complete(),     -- show completion suggestions
                ["<C-e>"] = cmp.mapping.abort(),            -- close completion window
                ["<CR>"] = cmp.mapping.confirm({ select = false }),
                ["<Tab>"] = cmp.mapping.select_next_item(),
                ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                -- ["<A-y>"] = require('minuet').make_cmp_map(),
            }),
            formatting = {
                fields = { "kind", "abbr", "menu" },
                format = function(entry, vim_item)
                    -- Kind icons
                    -- First check the source and override kind for AI sources
                    if entry.source.name == "minuet" then
                        vim_item.kind = kind_icons["Minuet"]
                    else
                        -- Use the normal kind icon for other sources
                        vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
                    end
                    vim_item.menu = ({
                        nvim_lsp = "[LSP]",
                        luasnip = "[Snippet]",
                        buffer = "[Buffer]",
                        path = "[Path]",
                        codeium = "[Codeium]",
                        -- minuet = "[Minuet]",
                    })[entry.source.name]
                    return vim_item
                end,
            },
            sources = cmp.config.sources({
                -- { name = "minuet" },     -- minuet for Claude et al.
                { name = "codeium", keyword_length = 3, max_item_count = 5 },
                { name = "nvim_lsp" },   -- lsp completions
                { name = "luasnip" },    -- text from buffer
                { name = "nvim_lua" },   -- Neovim Lua API
                { name = "treesitter" }, -- Treesitter
                { name = "buffer" },     -- text from buffer
                { name = "path" },       -- file system paths

            }),
            performance = {
            --     -- It is recommended to increase the timeout duration due to the typically slower response speed of LLMs
            --     -- compared to other completion sources. This is not needed when you only need manual completion.
                debounce = 50,
                throttle = 50,
                fetching_timeout = 200,
            },
            experimental = {
                ghost_text = false,
                native_menu = false,
            },
        })
    end,
}
