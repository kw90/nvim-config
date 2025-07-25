return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        -- Python adapter
        "nvim-neotest/neotest-python",
    },
    config = function()
        require("neotest").setup({
            adapters = {
                require("neotest-python")({
                    dap = { justMyCode = false },
                    args = { "--log-level", "DEBUG" },
                    runner = "pytest",
                    python = function()
                        -- Try poetry first
                        local handle = io.popen("poetry env info --executable 2>/dev/null")
                        if handle then
                            local result = handle:read("*a")
                            handle:close()
                            if result and result ~= "" then
                                return vim.trim(result)
                            end
                        end

                        -- Try .venv/bin/python
                        if vim.fn.executable(".venv/bin/python") == 1 then
                            return ".venv/bin/python"
                        end

                        -- Try venv/bin/python
                        if vim.fn.executable("venv/bin/python") == 1 then
                            return "venv/bin/python"
                        end

                        -- Try VIRTUAL_ENV
                        local venv = os.getenv("VIRTUAL_ENV")
                        if venv then
                            local venv_python = venv .. "/bin/python"
                            if vim.fn.executable(venv_python) == 1 then
                                return venv_python
                            end
                        end

                        -- Fallback to system python
                        return "python"
                    end,
                    pytest_discover_instances = true,
                }),
            },
            discovery = {
                enabled = true,
                concurrent = 4,
            },
            running = {
                concurrent = true,
            },
            summary = {
                enabled = true,
                animated = true,
                follow = true,
                expand_errors = true,
            },
            output = {
                enabled = true,
                open_on_run = "short",
            },
            quickfix = {
                enabled = false,
            },
            status = {
                enabled = true,
                signs = true,
                virtual_text = true,
            },
            icons = {
                child_indent = "│",
                child_prefix = "├",
                collapsed = "─",
                expanded = "╮",
                failed = "❌",
                final_child_indent = " ",
                final_child_prefix = "╰",
                non_collapsible = "─",
                passed = "✅",
                running = "🏃‍♂️",
                running_animated = { "/", "|", "\\", "-", "/", "|", "\\", "-" },
                skipped = "⏩",
                unknown = "❔",
            },
        })

        -- Keymaps for neotest
        vim.keymap.set("n", "<leader>tt", function()
            require("neotest").run.run()
        end, { desc = "Test: Run nearest" })

        vim.keymap.set("n", "<leader>tf", function()
            require("neotest").run.run(vim.fn.expand("%"))
        end, { desc = "Test: Run file" })

        vim.keymap.set("n", "<leader>tD", function()
            require("neotest").run.run({ strategy = "dap" })
        end, { desc = "Test: Debug nearest" })

        vim.keymap.set("n", "<leader>ts", function()
            require("neotest").run.stop()
        end, { desc = "Test: Stop" })

        vim.keymap.set("n", "<leader>ta", function()
            require("neotest").run.attach()
        end, { desc = "Test: Attach" })

        vim.keymap.set("n", "<leader>to", function()
            require("neotest").output.open({ enter = true, auto_close = true })
        end, { desc = "Test: Show output" })

        vim.keymap.set("n", "<leader>tO", function()
            require("neotest").output_panel.toggle()
        end, { desc = "Test: Toggle output panel" })

        vim.keymap.set("n", "<leader>tS", function()
            require("neotest").summary.toggle()
        end, { desc = "Test: Toggle summary" })

        vim.keymap.set("n", "<leader>tw", function()
            require("neotest").watch.toggle(vim.fn.expand("%"))
        end, { desc = "Test: Watch file" })
    end,
}

