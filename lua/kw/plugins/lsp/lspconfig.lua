return {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "folke/neodev.nvim", -- Provides lsp completion for neovim config
        "folke/neoconf.nvim", -- Per-project lsp config
    },
    config = function()
        local default_python_folder = "/Users/kaiwaelti/.config/nvim/venv/bin"
        -- vim.g.python3_host_prog = default_python_folder .. "/python3"

        -- IMPORTANT: make sure to setup neodev BEFORE lspconfig
        local neodev = require("neodev")
        neodev.setup()

        -- IMPORTANT: make sure to setup neoconf before lspconfig
        local neoconf = require("neoconf")
        neoconf.setup()

        local lspconfig = require("lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        -- set general keymaps
        local opts = { noremap = true, silent = true }

        -- Define the border style for the hover
        local border = {
            { "╭", "FloatBorder" },
            { "─", "FloatBorder" },
            { "╮", "FloatBorder" },
            { "│", "FloatBorder" },
            { "╯", "FloatBorder" },
            { "─", "FloatBorder" },
            { "╰", "FloatBorder" },
            { "│", "FloatBorder" },
        }

        opts.desc = "Show line diagnostics"
        vim.keymap.set("n", "<leader>dde", vim.diagnostic.open_float, opts)

        opts.desc = "Show buffer diagnostics"
        vim.keymap.set("n", "<leader>dE", "<cmd>Telescope diagnostics bufnr=0<cr>", opts)

        opts.desc = "Go to previous diagnostic"
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

        opts.desc = "Go to next diagnostic"
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

        -- define on_attach and capabilities
        local on_attach = function(_, bufnr)
            -- Enable completions triggered by <C-x><C-o>
            -- vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

            -- Set buffer specific keymaps
            local bufopts = { noremap = true, silent = false, buffer = bufnr }

            bufopts.desc = "Go to definition"
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)

            bufopts.desc = "Get references"
            vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)

            bufopts.desc = "Show documentation for object under the cursor"
            vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)

            -- bufopts.desc = "List all symbols in the current workspace"
            -- vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, bufopts)

            bufopts.desc = "Open diagnostics float"
            vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, bufopts)

            bufopts.desc = "Show code actions"
            vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, bufopts)

            bufopts.desc = "Show LSP references"
            vim.keymap.set("n", "<leader>fr", "<cmd>Telescope lsp_references<cr>", bufopts)

            bufopts.desc = "Smart rename"
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)

            bufopts.desc = "Format file"
            vim.keymap.set("n", "<leader>vff", vim.lsp.buf.format, bufopts)

            bufopts.desc = "Show signature help"
            vim.keymap.set("n", "<leader>sh", vim.lsp.buf.signature_help, bufopts)

            bufopts.desc = "Restart LSP"
            vim.keymap.set("n", "<leader>lr", "<cmd>LspRestart<cr>", opts)

            -- Override the default hover handler
            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
                border = border,
            })
        end

        local capabilities = cmp_nvim_lsp.default_capabilities()

        -- lua_ls config
        lspconfig.lua_ls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" },
                        missing_parameters = false, -- disable missing parameters for lua
                    },
                    completion = {
                        callSnippet = "Replace",
                    },
                },
            },
        })

        local venv_path = os.getenv("VIRTUAL_ENV")
        local py_path = nil
        -- decide which python executable to use for mypy
        if venv_path ~= nil then
            py_path = venv_path .. "/bin/python3"
        else
            py_path = default_python_folder .. "/python3"
        end

        -- pylsp config
        lspconfig.pylsp.setup({
            cmd = {py_path, "-m", "pylsp"}, -- Set the Python executable path
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                pylsp = {
                    plugins = {
                        -- Disable most linting and formatting, use ruff instead
                        pyflakes = { enabled = false },
                        mccabe = { enabled = false },
                        pycodestyle = { enabled = false },
                        autopep8 = { enabled = false },
                        yapf = { enabled = false },
                        black = { enabled = false },
                        -- ruff configuration
                        ruff = {
                            enabled = true,
                            formatEnabled = true,
                            unsafeFixes = true,
                            lineLength = 120,
                            extendSelect = {
                                "A001", -- flake8-builtins; detect shadowing of python builtin symbols by variables
                                "A002", -- flake8-builtins; detect shadowing of python builtin symbols by arguments
                                "AIR", -- airflow; enforce airflow specific rules
                                "B", -- bugbear; detect common bug patterns and issues
                                "C90", -- mccabe complexity; enforce a maximum complexity
                                "D", -- pydocstyle; enforce docstring conventions
                                "E", -- pycodestyle; enforce the PEP8 style guide
                                "F", -- Pyflakes; checks for errors in Python code
                                "I", -- isort
                                "NPY", -- numpy; enforce numpy specific rules
                                "PD", -- pandas-vet; detect common pandas errors
                                "PERF", -- flake8-performance; check for performance issues
                                "PIE", -- flake8-pie; enforce pie specific rules (misc. lints)
                                "PLE", -- pylint-errors; check for pylint errors
                                "PLW", -- pylint-warnings; check for pylint warnings
                                "RUF", -- ruff; enforce ruff specific rules
                                "SIM", -- flake8-simplify; simplify code
                                "T20", -- flake8-print; disallow print statements
                                "TID", -- flake8-tidy-imports; enforce consistent import rules
                                "UP", -- pyupgrade; upgrade syntax to newer versions
                            },
                            extendIgnore = {
                                "D100", -- Missing docstring in public module
                                "D104", -- Missing docstring in public package
                                "D107", -- Missing docstring in __init__
                                "UP032", -- Use % formatting in logging calls and when raising exception
                            },
                            format = {
                                "I", -- Import rules (isort)
                                "F", -- Pyflakes
                                "E", -- Error checking
                            },
                        },
                        -- type checker
                        pylsp_mypy = {
                            enabled = true,
                            overrides = { "--python-executable", py_path, true, "--no-pretty"},
                        },
                        -- completion settings
                        jedi_completion = {
                            enabled = true,
                            fuzzy = true,
                        },
                        rope_autoimport = {
                            -- NOTE: Rope autoimport works by checking for diagnostic F821. Make sure you have a linter
                            -- running that returns that diagnostic if you want auto-import. This is the reason, I have
                            -- configured ruff with extendSelect to always include F
                            enabled = true,
                            completions = { enabled = true },
                            code_actions = { enabled = true },
                        },
                    },
                },
            },
            flags = {
                debounce_text_changes = 500,
            },
            on_init = function(client)
                client.config.flags = client.config.flags or {}
                client.config.flags.timeout = 5000 -- Set timeout to 10 seconds
            end,
        })

        -- gopls config
        lspconfig.gopls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        -- yamlls config
        local yamlls_capabilities = cmp_nvim_lsp.default_capabilities()
        yamlls_capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
        }
        lspconfig.yamlls.setup({
            capabilities = yamlls_capabilities,
            on_attach = on_attach,
            settings = {
                yaml = {
                    format = {
                        enable = true,
                    },
                    editor = {
                        tabSize = 4,
                    },
                },
            },
        })

        -- Marksman config
        lspconfig.marksman.setup({})
        lspconfig.bashls.setup({})
    end,
}
