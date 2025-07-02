local anthropic_api_key = os.getenv("ANTHROPIC_API_KEY")
if not anthropic_api_key then
  vim.notify("ANTHROPIC_API_KEY not found in environement", vim.log.levels.ERROR)
end
return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "ravitemer/mcphub.nvim",
      {
        "HakonHarnes/img-clip.nvim",
        opts = {
          filetypes = {
            codecompanion = {
              prompt_for_file_name = false,
              template = "[Image]($FILE_PATH)",
              use_absolute_path = true,
            },
          },
        },
      },
    },
    keys = {
      { "<leader>a", group = "AI" },
      { "<leader>ac", "<cmd>CodeCompanionActions<cr>", desc = "Open Action Palette" },
      { "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle Chat" },
      { "<leader>ax", "<cmd>CodeCompanionChat RefreshCache<cr>", desc = "Refresh Chat" },
      { "<leader>ai", "<cmd>CodeCompanion<cr>", desc = "Inline Assistant", mode = "n" },
      { "<leader>ai", "<cmd>'<'>CodeCompanion<cr>", desc = "Inline Assistant", mode = "v" },
      { "<leader>ae", "<cmd>'<'>CodeCompanion /explain<cr>", desc = "Explain Code", mode = "v" },
      { "<leader>at", "<cmd>'<'>CodeCompanion /tests<cr>", desc = "Generate Tests", mode = "v" },
      { "<leader>af", "<cmd>'<'>CodeCompanion /fix<cr>", desc = "Fix Code", mode = "v" },
      { "<leader>ad", "<cmd>'<'>CodeCompanion /lsp<cr>", desc = "Diagnose", mode = "v" },
      { "<leader>ao", "<cmd>CodeCompanionChat Add<cr>", desc = "Add Selection to Chat", mode = "v" },
    },
    opts = {
      strategies = {
        chat = {
          adapter = "anthropic",
          model = "claude-sonnet-4-20250514",
        },
        inline = {
          adapter = "anthropic",
          model = "claude-sonnet-4-20250514",
        },
        cmd = {
          adapter = "anthropic",
          model = "claude-sonnet-4-20250514",
        },
      },
      adapters = {
        anthropic = function()
          return require("codecompanion.adapters").extend("anthropic", {
            schema = {
              model = {
                default = "claude-sonnet-4-20250514",
              },
            },
            env = {
              api_key = anthropic_api_key,
            },
          })
        end,
        display = {
          action_palette = {
            width = 50,
            height = 8,
            prompt = "Prompt ", -- Prompt used for interactive LLM calls
            provider = "fzf_lua", -- Can be "default", "telescope", "fzf_lua", "mini_pick" or "snacks". If not specified, the plugin will autodetect installed providers.
            opts = {
              show_default_actions = true, -- Show the default actions in the action palette?
              show_default_prompt_library = true, -- Show the default prompt library in the action palette?
            },
          },
        },
      },
    },
  },
  -- "yetone/avante.nvim",
  -- -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  -- -- ⚠️ must add this setting! ! !
  -- build = function()
  --   -- conditionally use the correct build system for the current OS
  --   if vim.fn.has("win32") == 1 then
  --     return "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
  --   else
  --     return "make"
  --   end
  -- end,
  -- event = "VeryLazy",
  -- version = false, -- Never set this value to "*"! Never!
  -- ---@module 'avante'
  -- ---@type avante.Config
  -- opts = {
  --   -- add any opts here
  --   -- for example
  --   provider = "claude",
  --   providers = {
  --     claude = {
  --       endpoint = "https://api.anthropic.com",
  --       model = "claude-opus-4-20250514",
  --       timeout = 30000, -- Timeout in milliseconds
  --       extra_request_body = {
  --         temperature = 0.75,
  --         max_tokens = 20480,
  --       },
  --     },
  --   },
  -- },
  -- dependencies = {
  --   "nvim-lua/plenary.nvim",
  --   "MunifTanjim/nui.nvim",
  --   --- The below dependencies are optional,
  --   "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
  --   "ibhagwan/fzf-lua", -- for file_selector provider fzf
  --   "stevearc/dressing.nvim", -- for input provider dressing
  --   "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
  --   {
  --     -- support for image pasting
  --     "HakonHarnes/img-clip.nvim",
  --     event = "VeryLazy",
  --     opts = {
  --       -- recommended settings
  --       default = {
  --         embed_image_as_base64 = false,
  --         prompt_for_file_name = false,
  --         drag_and_drop = {
  --           insert_mode = true,
  --         },
  --         -- required for Windows users
  --         use_absolute_path = true,
  --       },
  --     },
  --   },
  --   {
  --     -- Make sure to set this up properly if you have lazy=true
  --     "MeanderingProgrammer/render-markdown.nvim",
  --     opts = {
  --       file_types = { "markdown", "Avante" },
  --     },
  --     ft = { "markdown", "Avante" },
  --   },
  -- },
}
