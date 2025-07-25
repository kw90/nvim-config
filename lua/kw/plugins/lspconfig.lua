return {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      -- Global LSP settings
      vim.diagnostic.config({
        virtual_text = {
          prefix = '●', -- Could be '■', '▎', 'x'
        },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })

      -- Diagnostic signs
      local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      -- Global mappings for diagnostics
      vim.keymap.set('n', '<leader>dde', vim.diagnostic.open_float, { desc = "Diagnostics: Show in float", noremap = true, silent = true })
      vim.keymap.set("n", "<leader>dE", "<cmd>Telescope diagnostics bufnr=0<cr>", { desc = "Diagnostics: Show all (Telescope)", noremap = true, silent = true })
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Diagnostics: Go to previous", noremap = true, silent = true })
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Diagnostics: Go to next", noremap = true, silent = true })
      vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Diagnostics: Add to location list", noremap = true, silent = true })
    end,
}
