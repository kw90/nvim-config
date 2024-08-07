return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-telescope/telescope-live-grep-args.nvim",
        "nvim-treesitter/nvim-treesitter",
        "nvim-telescope/telescope-ui-select.nvim",
        build = make,
        config = function()
            require("telescope").load_extension("fzf")
        end,
    },
    opts = {
        defaults = {
            results_title = false,
            sorting_strategy = "ascending",
            layout_strategy = "center",
            layout_config = {
                preview_cutoff = 1, -- Preview should always show (unless previewer = false)
                width = function(_, max_columns, _)
                    return math.min(max_columns, 80)
                end,
                height = function(_, _, max_lines)
                    return math.min(max_lines, 15)
                end,
            },
            border = true,
            borderchars = {
                prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
                results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
                preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
            },
        },
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        local builtin = require("telescope.builtin")
        local lga_actions = require("telescope-live-grep-args.actions")

        telescope.setup({
            defaults = {
                path_display = { "truncate" },
                mappings = {
                    i = {
                        ["<C-k>"] = actions.move_selection_previous, -- move to previous result
                        ["<C-j>"] = actions.move_selection_next, -- move to next result
                        ["<C-l>"] = actions.send_to_qflist + actions.open_qflist, -- send items to quickfix list
                    },
                },
            },
            extensions = {
                live_grep_args = {
                    auto_quoting = true, -- enable/disable auto-quoting
                    -- define mappings, e.g.
                    mappings = { -- extend mappings
                        i = {
                            ["<C-q>"] = lga_actions.quote_prompt(),
                            ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
                        },
                    },
                    layout_config = {
                        width = 0.99,
                        height = 0.99,
                    },
                    -- theme = "dropdown", -- use dropdown theme
                    layout_strategy = "vertical",
                },
            },
        })

        -- Use live_grep_args extension
        telescope.load_extension("live_grep_args")

        -- Use fzf to fuzzy find
        telescope.load_extension("fzf")
        telescope.load_extension("ui-select")

        -- Keymaps
        vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Fuzzy find files in cwd" })
        vim.keymap.set("n", "<leader>fg", builtin.git_files, { desc = "Fuzzy find files in git files" })
        vim.keymap.set("n", "<leader>fs", builtin.live_grep, { desc = "Fuzzy find string in files in cwd" })
        vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Show open buffers" })
        vim.keymap.set("n", "<leader>ss", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
        vim.keymap.set(
            "n",
            "<leader>su",
            ":lua require('telescope-live-grep-args.shortcuts').grep_word_under_cursor()<CR>"
        )
        vim.keymap.set({ "n", "v" }, "<leader>fc", builtin.grep_string, { desc = "Search string under cursor in cwd" })
    end,
}
