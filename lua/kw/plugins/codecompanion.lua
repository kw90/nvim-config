return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
  },
  config = function()
    require("codecompanion").setup({
      extensions = {
        mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = {
            show_result_in_chat = true,  -- Show mcp tool results in chat
            make_vars = true,            -- Convert resources to #variables
            make_slash_commands = true,  -- Add prompts as /slash commands
          }
        }
      },
      adapters = {
        anthropic_c = function()
          return require("codecompanion.adapters").extend("anthropic", {
            name = "anthropic_c",
            schema = {
              model = {
                default = "claude-3-7-sonnet-20250219",
              },
            },
            env = {
              api_key = "CLAUDE_API_KEY",
            },
          })
        end,
      },
      strategies = {
        -- Change the default chat adapter
        chat = {
          adapter = "anthropic_c",
        },
        inline = {
          adapter = "anthropic_c",
        },
        cmd = {
          adapter = "anthropic_c",
        }
      },
      display = {
        action_palette = {
          width = 95,
          height = 10,
          prompt = "Prompt ", -- Prompt used for interactive LLM calls
          provider = "telescope", -- Can be "default", "telescope", "fzf_lua", "mini_pick" or "snacks". If not specified, the plugin will autodetect installed providers.
          opts = {
            show_default_actions = true, -- Show the default actions in the action palette?
            show_default_prompt_library = true, -- Show the default prompt library in the action palette?
          },
        },
      },
      -- tools = {
      --   ["mcp"] = {
      --     callback = require("mcphub.extensions.codecompanion"),
      --     description = "Call tools and resources from the MCP Servers",
      --     opts = {
      --       user_approval = true,
      --     },
      --   },
      -- },
      log_level = "DEBUG",
    })
    vim.keymap.set({ "n", "v" }, "<leader>cc", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
    vim.keymap.set({ "n", "v" }, "<LocalLeader>a", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
    vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

    -- Expand 'cc' into 'CodeCompanion' in the command line
    vim.cmd([[cab cc CodeCompanion]])
  end
}
