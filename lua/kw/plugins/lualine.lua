return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    opts = function()
        return {
            options = {
                theme = 'base16',
            },
            -- sections = {
            --     lualine_a = { { "mode", icon = "" } },
            --     lualine_b = { { "branch", icon = "" } },
            --     lualine_c = {
            --         {
            --             "diagnostics",
            --             symbols = {
            --                 error = " ",
            --                 warn = " ",
            --                 info = " ",
            --                 hint = "󰝶 ",
            --             },
            --         },
            --         { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            --         {
            --             "filename",
            --             symbols = { modified = "  ", readonly = "", unnamed = "" },
            --             path = 1,
            --         },
            --         {
            --             function()
            --                 return require("nvim-navic").get_location()
            --             end,
            --             cond = function()
            --                 return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
            --             end,
            --             color = { fg = colors.grey, bg = colors.none },
            --         },
            --     },
            --     lualine_x = {
            --         {
            --             require("lazy.status").updates,
            --             cond = require("lazy.status").has_updates,
            --             color = { fg = colors.green },
            --         },
            --         {
            --             function()
            --                 local icon = " "
            --                 local status = require("copilot.api").status.data
            --                 return icon .. (status.message or "")
            --             end,
            --             cond = function()
            --                 local ok, clients = pcall(vim.lsp.get_clients, { name = "copilot", bufnr = 0 })
            --                 return ok and #clients > 0
            --             end,
            --             color = function()
            --                 if not package.loaded["copilot"] then
            --                     return
            --                 end
            --                 local status = require("copilot.api").status.data
            --                 return copilot_colors[status.status] or copilot_colors[""]
            --             end,
            --         },
            --         {
            --             function()
            --                 local codeium = require("codeium")
            --                 return codeium.GetStatusString()
            --             end,
            --         },
            --         { "diff" },
            --     },
            --     lualine_y = {
            --         {
            --             "macro-recording",
            --             fmt = function()
            --                 local recording_register = vim.fn.reg_recording()
            --                 if recording_register ~= "" then
            --                     return "Recording @" .. recording_register
            --                 else
            --                     return ""
            --                 end
            --             end,
            --         },
            --         {
            --             "progress",
            --         },
            --         {
            --             "location",
            --             color = { fg = colors.cyan, bg = colors.none },
            --         },
            --     },
            --     lualine_z = {
            --         function()
            --             return " 🚀 "
            --         end,
            --     },
            -- },

            extensions = { "lazy", "toggleterm", "mason", "trouble", "nvim-dap-ui", "neo-tree" },
        }
    end,
}
