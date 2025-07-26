return {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
        "williamboman/mason.nvim",
        "neovim/nvim-lspconfig",
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local mason_lspconfig = require("mason-lspconfig")
        local lspconfig = require("lspconfig")

        mason_lspconfig.setup({
            ensure_installed = {
                "basedpyright",
                "ruff",
                "lua_ls",
                "pylsp",
                "yamlls",
                "marksman",
                "bashls",
                "sqlls",
                "gopls",
            },
            automatic_installation = true,
            automatic_enable = {
                exclude = { "pyright", "basedpyright", "ruff", "pylsp" }
            },
        })

        -- Setup LSP servers
        local servers = { "basedpyright", "ruff", "lua_ls", "pylsp" }

        for _, server in pairs(servers) do
            if server == "basedpyright" then
                lspconfig.basedpyright.setup({
                    settings = {
                        python = {
                            analysis = {
                                typeCheckingMode = "basic",
                                autoSearchPaths = true,
                                useLibraryCodeForTypes = true,
                                autoImportCompletions = true,
                                diagnosticMode = "workspace",
                                stubPath = vim.fn.stdpath("data") .. "/lazy/python-type-stubs",
                            },
                        },
                    },
                    on_attach = function(client, bufnr)
                        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

                        local opts = { noremap = true, silent = true, buffer = bufnr }
                        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration,
                            { desc = "LSP: Go to declaration", unpack(opts) })
                        vim.keymap.set('n', 'gd', vim.lsp.buf.definition,
                            { desc = "LSP: Go to definition", unpack(opts) })
                        vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "LSP: Hover documentation", unpack(opts) })
                        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation,
                            { desc = "LSP: Go to implementation", unpack(opts) })
                        vim.keymap.set('n', 'sh', vim.lsp.buf.signature_help,
                            { desc = "LSP: Signature help", unpack(opts) })
                        vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder,
                            { desc = "LSP: Add workspace folder", unpack(opts) })
                        vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder,
                            { desc = "LSP: Remove workspace folder", unpack(opts) })
                        vim.keymap.set('n', '<leader>wl', function()
                            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                        end, { desc = "LSP: List workspace folders", unpack(opts) })
                        vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition,
                            { desc = "LSP: Type definition", unpack(opts) })
                        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename,
                            { desc = "LSP: Rename symbol", unpack(opts) })
                        vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action,
                            { desc = "LSP: Code actions", unpack(opts) })
                        vim.keymap.set('n', 'gr', vim.lsp.buf.references,
                            { desc = "LSP: Go to references", unpack(opts) })
                        vim.keymap.set("n", "<leader>fr", "<cmd>Telescope lsp_references<cr>",
                            { desc = "LSP: Find references (Telescope)", unpack(opts) })
                        vim.keymap.set("n", "<leader>lr", "<cmd>LspRestart<cr>",
                            { desc = "LSP: Restart server", unpack(opts) })
                    end,
                })
            elseif server == "ruff" then
                lspconfig.ruff.setup({
                    cmd = { "ruff", "server", "--preview" },
                    settings = {
                        args = {
                            "--line-length=120",
                            "--extend-select=A001,A002,AIR,B,C90,D,E,F,I,NPY,PD,PERF,PIE,PLE,PLW,RUF,SIM,T20,TID,UP",
                            "--extend-ignore=D100,D104,D107,UP032",
                            "--unsafe-fixes",
                        },
                    },
                    on_attach = function(client, bufnr)
                        client.server_capabilities.hoverProvider = false

                        local opts = { noremap = true, silent = true, buffer = bufnr }
                        vim.keymap.set('n', '<leader>vff', function()
                            vim.lsp.buf.format {
                                async = true,
                                filter = function(c) return c.name == "ruff" end
                            }
                        end, { desc = "LSP: Format with Ruff", unpack(opts) })
                        vim.keymap.set('n', '<leader>vfi', function()
                            vim.lsp.buf.code_action({
                                context = { only = { "source.organizeImports" } },
                                apply = true
                            })
                        end, { desc = "Ruff: Organize imports", unpack(opts) })
                        vim.keymap.set('n', '<leader>vfx', function()
                            vim.lsp.buf.code_action({
                                context = { only = { "source.fixAll" } },
                                apply = true
                            })
                        end, { desc = "Ruff: Fix all", unpack(opts) })
                    end,
                })
            elseif server == "pylsp" then
                lspconfig.pylsp.setup({
                    settings = {
                        pylsp = {
                            plugins = {
                                -- Disable overlapping features with pyright/ruff
                                pycodestyle = { enabled = false },
                                mccabe = { enabled = true },
                                pyflakes = { enabled = false },
                                flake8 = { enabled = false },
                                autopep8 = { enabled = false },
                                yapf = { enabled = false },
                                -- Enable rope for refactoring
                                rope_completion = { enabled = true },
                                rope_autoimport = { enabled = true },
                            }
                        }
                    },
                    on_attach = function(client, bufnr)
                        -- Disable capabilities that conflict with pyright
                        client.server_capabilities.hoverProvider = false
                        client.server_capabilities.signatureHelpProvider = false
                        client.server_capabilities.completionProvider = false
                        client.server_capabilities.documentSymbolProvider = false
                        client.server_capabilities.workspaceSymbolProvider = false
                        client.server_capabilities.renameProvider = false
                        client.server_capabilities.definitionProvider = false
                        client.server_capabilities.typeDefinitionProvider = false
                        client.server_capabilities.implementationProvider = false
                        client.server_capabilities.referencesProvider = false
                        -- Keep only refactoring capabilities
                        local opts = { noremap = true, silent = true, buffer = bufnr }
                        vim.keymap.set('n', '<leader>rr', vim.lsp.buf.code_action,
                            { desc = "Pylsp: Refactor actions", unpack(opts) })
                    end,
                })
            else
                lspconfig[server].setup({
                    on_attach = function(client, bufnr)
                        client.server_capabilities.hoverProvider = false

                        local opts = { noremap = true, silent = true, buffer = bufnr }
                        vim.keymap.set('n', '<leader>vff', function()
                            vim.lsp.buf.format {
                                async = true,
                            }
                        end, { desc = "LSP: Format buffer with " .. server, unpack(opts) })
                    end,
                })
            end
        end
    end,
}
