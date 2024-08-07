return {
    "azabiong/vim-highlighter",
    config = function()
        vim.cmd("let HiSet   = 'f<CR>'")
        vim.cmd("let HiErase = 'f<BS>'")
        vim.cmd("let HiClear = 'f<C-L>'")
    end,
}

