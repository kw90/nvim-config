return {
    "williamboman/mason.nvim",
    lazy = false,
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        -- for conciness
        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")
        local mason_tool_installer = require("mason-tool-installer")

        -- enable mason and configure icons
        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })

        -- Add default lsp servers
        mason_lspconfig.setup({
            ensure_installed = {
                "lua_ls",
                "pylsp",
                "gopls",
                "yamlls",
            },
            -- auto-install configured servers
            automatic_installation = true,
        })

        -- Install tools
        mason_tool_installer.setup({
            ensure_installed = {
                "stylua", -- lua formatter
                "delve", -- go debugger
                "debugpy", -- python debugger
            },
        })
    end,
}
