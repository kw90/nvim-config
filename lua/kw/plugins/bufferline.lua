return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
        local status, bufferline = pcall(require, "bufferline")
        if not status then
            print("ERROR bufferline")
            return
        end
        -- local colors = require("cyberdream.colors")
        local colors = {
            bg = "#181818",
            bg_light = "#282828",
            bg_highlight = "#585858",
            fg = "#888888",
            fg_light = "#989898",
            fg_lighter = "#a8a8a8",
            fg_highlight = "#b8b8b8",
            red = "#ab4642",
            green = "#a1b56c",
            yellow = "#f7ca88",
            blue = "#7cafc2",
            magenta = "#ba8baf",
            cyan = "#86c1b9",
            orange = "#dc9656",
        }

        bufferline.setup({
            options = {
                mode = "buffers",                   -- set to "tabs" to only show tabpages instead
                style_preset = bufferline.style_preset.default, -- or bufferline.style_preset.minimal,
                modified_icon = "●",
                buffer_close_icon = "",
                close_icon = "",
                left_trunc_marker = "",
                right_trunc_marker = "",
                numbers = "ordinal",
                max_name_length = 15,
                max_prefix_length = 6,
                diagnostics = "nvim_lsp",
                show_buffer_icons = true,
                show_buffer_close_icons = false,
                show_close_icon = false,
                persist_buffer_sort = true,
                color_icons = true, -- whether or not to add the filetype icon highlights
                diagnostics_indicator = function(count, level)
                    local icon = level:match("error") and "" or ""
                    return icon .. " " .. count
                end,
                get_element_icon = function(element)
                    -- element consists of {filetype: string, path: string, extension: string, directory: string}
                    -- This can be used to change how bufferline fetches the icon
                    local icon, hl =
                        require("nvim-web-devicons").get_icon_by_filetype(element.filetype, { default = false })
                    return icon, hl
                end,
                separator_style = "slope",
                enforce_regular_tabs = true,
                offsets = {
                    {
                        filetype = "neo-tree",
                        text = "File Explorer",
                        text_align = "center",
                        separator = true,
                        highlight = "Directory",
                    },
                    {
                        filetype = "NvimTree",
                        text = "File Explorer",
                        text_align = "center",
                        separator = true,
                    },
                },
                -- Other options...
                -- Other options...
                custom_filter = function(buf_number)
                    local buf_type = vim.bo[buf_number].buftype
                    local buf_name = vim.fn.bufname(buf_number)
                    local file_type = vim.bo[buf_number].filetype
                    -- Define lists of buffer types and names to ignore
                    local ignore_buf_types = { "quickfix", "nofile", "terminal" }
                    local ignore_file_types = { "help", "startify" }
                    local ignore_buf_names = { "" } -- Unnamed buffers
                    -- Check if the buffer type is in the ignore list
                    for _, ignore_type in ipairs(ignore_buf_types) do
                        if buf_type == ignore_type then
                            return false
                        end
                    end
                    -- Check if the file type is in the ignore list
                    for _, ignore_ft in ipairs(ignore_file_types) do
                        if file_type == ignore_ft then
                            return false
                        end
                    end
                    -- Check if the buffer name is in the ignore list
                    for _, ignore_name in ipairs(ignore_buf_names) do
                        if buf_name == ignore_name then
                            return false
                        end
                    end
                    return true
                end,
            },
            highlights = {
                fill = {
                    fg = colors.bg,
                    bg = colors.bg_light,
                },
                background = {
                    fg = colors.fg,
                    bg = colors.bg,
                },
                tab = {
                    fg = colors.fg,
                    bg = colors.bg,
                },
                tab_selected = {
                    fg = colors.fg_highlight,
                    bg = colors.bg_highlight,
                },
                tab_separator = {
                    fg = colors.fg,
                    bg = colors.bg,
                },
                tab_separator_selected = {
                    fg = colors.fg_highlight,
                    bg = colors.bg,
                },
                tab_close = {
                    fg = colors.red,
                    bg = colors.bg,
                },
                close_button = {
                    fg = colors.red,
                    bg = colors.bg,
                },
                close_button_visible = {
                    fg = colors.red,
                    bg = colors.bg,
                },
                close_button_selected = {
                    fg = colors.red,
                    bg = colors.bg_highlight,
                },
                buffer_visible = {
                    fg = colors.fg,
                    bg = colors.bg,
                },
                buffer_selected = {
                    fg = colors.fg_highlight,
                    bg = colors.bg_highlight,
                    bold = true,
                    italic = true,
                },
                numbers = {
                    fg = colors.fg,
                    bg = colors.bg,
                },
                numbers_visible = {
                    fg = colors.fg,
                    bg = colors.bg,
                },
                numbers_selected = {
                    fg = colors.fg_highlight,
                    bg = colors.bg_highlight,
                    bold = true,
                    italic = true,
                },
                diagnostic = {
                    fg = colors.yellow,
                    bg = colors.bg,
                },
                diagnostic_visible = {
                    fg = colors.yellow,
                    bg = colors.bg,
                },
                diagnostic_selected = {
                    fg = colors.yellow,
                    bg = colors.bg_highlight,
                    bold = true,
                    italic = true,
                },
                hint = {
                    fg = colors.green,
                    sp = colors.green,
                    bg = colors.bg,
                },
                hint_visible = {
                    fg = colors.green,
                    bg = colors.bg,
                },
                hint_selected = {
                    fg = colors.green,
                    bg = colors.bg_highlight,
                    sp = colors.green,
                    bold = true,
                    italic = true,
                },
                hint_diagnostic = {
                    fg = colors.green,
                    sp = colors.green,
                    bg = colors.bg,
                },
                hint_diagnostic_visible = {
                    fg = colors.green,
                    bg = colors.bg,
                },
                hint_diagnostic_selected = {
                    fg = colors.green,
                    bg = colors.bg_highlight,
                    sp = colors.green,
                    bold = true,
                    italic = true,
                },
                info = {
                    fg = colors.cyan,
                    sp = colors.cyan,
                    bg = colors.bg,
                },
                info_visible = {
                    fg = colors.cyan,
                    bg = colors.bg,
                },
                info_selected = {
                    fg = colors.cyan,
                    bg = colors.bg_highlight,
                    sp = colors.cyan,
                    bold = true,
                    italic = true,
                },
                info_diagnostic = {
                    fg = colors.cyan,
                    sp = colors.cyan,
                    bg = colors.bg,
                },
                info_diagnostic_visible = {
                    fg = colors.cyan,
                    bg = colors.bg,
                },
                info_diagnostic_selected = {
                    fg = colors.cyan,
                    bg = colors.bg_highlight,
                    sp = colors.cyan,
                    bold = true,
                    italic = true,
                },
                warning = {
                    fg = colors.orange,
                    sp = colors.orange,
                    bg = colors.bg,
                },
                warning_visible = {
                    fg = colors.orange,
                    bg = colors.bg,
                },
                warning_selected = {
                    fg = colors.orange,
                    bg = colors.bg_highlight,
                    sp = colors.orange,
                    bold = true,
                    italic = true,
                },
                warning_diagnostic = {
                    fg = colors.orange,
                    sp = colors.orange,
                    bg = colors.bg,
                },
                warning_diagnostic_visible = {
                    fg = colors.orange,
                    bg = colors.bg,
                },
                warning_diagnostic_selected = {
                    fg = colors.orange,
                    bg = colors.bg_highlight,
                    sp = colors.orange,
                    bold = true,
                    italic = true,
                },
                error = {
                    fg = colors.red,
                    bg = colors.bg,
                    sp = colors.red,
                },
                error_visible = {
                    fg = colors.red,
                    bg = colors.bg,
                },
                error_selected = {
                    fg = colors.red,
                    bg = colors.bg_highlight,
                    sp = colors.red,
                    bold = true,
                    italic = true,
                },
                error_diagnostic = {
                    fg = colors.red,
                    bg = colors.bg,
                    sp = colors.red,
                },
                error_diagnostic_visible = {
                    fg = colors.red,
                    bg = colors.bg,
                },
                error_diagnostic_selected = {
                    fg = colors.red,
                    bg = colors.bg_highlight,
                    sp = colors.red,
                    bold = true,
                    italic = true,
                },
                modified = {
                    fg = colors.magenta,
                    bg = colors.bg,
                },
                modified_visible = {
                    fg = colors.magenta,
                    bg = colors.bg,
                },
                modified_selected = {
                    fg = colors.magenta,
                    bg = colors.bg_highlight,
                },
                duplicate_selected = {
                    fg = colors.fg_lighter,
                    bg = colors.bg_highlight,
                    italic = true,
                },
                duplicate_visible = {
                    fg = colors.fg,
                    bg = colors.bg,
                    italic = true,
                },
                duplicate = {
                    fg = colors.fg,
                    bg = colors.bg,
                    italic = true,
                },
                separator_selected = {
                    fg = colors.bg_light,
                    bg = colors.bg_highlight,
                },
                separator_visible = {
                    fg = colors.bg,
                    bg = colors.bg,
                },
                separator = {
                    fg = colors.bg_light,
                    bg = colors.bg,
                },
                indicator_visible = {
                    fg = colors.bg,
                    bg = colors.bg,
                },
                indicator_selected = {
                    fg = colors.bg,
                    bg = colors.bg,
                },
                pick_selected = {
                    fg = colors.red,
                    bg = colors.bg_highlight,
                    bold = true,
                    italic = true,
                },
                pick_visible = {
                    fg = colors.red,
                    bg = colors.bg,
                    bold = true,
                    italic = true,
                },
                pick = {
                    fg = colors.red,
                    bg = colors.bg,
                    bold = true,
                    italic = true,
                },
                offset_separator = {
                    fg = colors.bg,
                    bg = colors.bg,
                },
                trunc_marker = {
                    fg = colors.bg,
                    bg = colors.bg,
                },
            },
        })
    end,
}
