local fmt = string.format
local tavily_api_key = os.getenv("TAVILY_API_KEY")
local anthropic_api_key = os.getenv("ANTHROPIC_API_KEY")
if not anthropic_api_key then
  vim.notify("ANTHROPIC_API_KEY not found in environment", vim.log.levels.ERROR)
end
local hostname = vim.fn.hostname()
local use_ollama = hostname == "deephome"
local use_claude = hostname == "tidepool"

local adapter_config = {}
if use_ollama then
  adapter_config = {
    adapter = "ollama",
    model = "qwen3:30B-A3B",
  }
elseif use_claude then
  adapter_config = {
    adapter = "anthropic",
    model = "claude-sonnet-4-20250514",
  }
else
  adapter_config = {
    adapter = "anthropic",
    model = "claude-sonnet-4-20250514",
  }
end

return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "ravitemer/mcphub.nvim",
      "ravitemer/codecompanion-history.nvim",
      {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown", "codecompanion" },
      },
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
    require("which-key").add({
      mode = { "n", "v" },
      {
        "<leader>a",
        group = "+ai",
        icon = { icon = "󱚣", hl = "true" },
      },
    }),
    keys = {
      { "<leader>ac", "<cmd>CodeCompanionActions<cr>", desc = "Open Action Palette" },
      { "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle Chat" },
      { "<leader>ax", "<cmd>CodeCompanionChat RefreshCache<cr>", desc = "Refresh Chat" },
      { "<leader>ai", "<cmd>CodeCompanion<cr>", desc = "Inline Assistant", mode = "n" },
      { "<leader>ai", "<cmd>'<'>CodeCompanion<cr>", desc = "Inline Assistant", mode = "v" },
      { "<leader>ah", "<cmd>'<'>CodeCompanionHistory<cr>", desc = "History", mode = "n" },
      { "<leader>ae", "<cmd>'<'>CodeCompanion /explain<cr>", desc = "Explain Code", mode = "v" },
      { "<leader>at", "<cmd>'<'>CodeCompanion /tests<cr>", desc = "Generate Tests", mode = "v" },
      { "<leader>af", "<cmd>'<'>CodeCompanion /fix<cr>", desc = "Fix Code", mode = "v" },
      { "<leader>ad", "<cmd>'<'>CodeCompanion /lsp<cr>", desc = "Diagnose", mode = "v" },
      { "<leader>ao", "<cmd>CodeCompanionChat Add<cr>", desc = "Add Selection to Chat", mode = "v" },
    },
    ---@module "vectorcode"
    opts = {
      log_level = "TRACE",
      strategies = {
        chat = adapter_config,
        inline = adapter_config,
        cmd = adapter_config,
      },
      prompt_library = {
        ["DnD Companion"] = {
          strategy = "chat",
          description = "Get help with DnD",
          opts = {
            adapter = {
              adapter = "ollama",
              model = "qwen3:30B-A3B",
            },
            index = 1,
            ignore_system_prompt = true,
            auto_submit = false,
            is_slash_cmd = true,
            short_name = "DM Assistant",
            stop_context_insertion = true,
          },
          prompts = {
            {
              role = "system",
              content = [[You are the Dungeon Master's Creative Assistant, an expert in crafting immersive D&D 5e campaigns, adventures, and content. Your expertise includes:

## Core Responsibilities:
- **Campaign Creation**: Develop overarching storylines, themes, and narrative arcs
- **Adventure Design**: Create engaging encounters, plot hooks, and session content
- **World Building**: Design locations, NPCs, organizations, and lore
- **Game Balance**: Ensure encounters are appropriately challenging and rewarding
- **Player Engagement**: Tailor content to different player types and party dynamics

## Content Creation Guidelines:
- Always consider the party's level, size, and composition when designing encounters
- Include multiple solution paths for challenges (combat, social, exploration)
- Provide clear motivation and consequences for player actions
- Balance serious moments with opportunities for humor and levity
- Ensure all content follows D&D 5e rules and mechanics

## Response Format:
When creating campaign content, organize your responses with:
1. **Overview**: Brief summary of the concept
2. **Key Elements**: Important NPCs, locations, or mechanics
3. **Implementation**: How to run/use the content at the table
4. **Variations**: Adaptations for different party levels or styles
5. **DM Notes**: Behind-the-scenes tips and potential complications

## Specializations:
- **Encounter Design**: Combat, social, and exploration challenges
- **NPC Creation**: Memorable characters with clear motivations
- **Plot Development**: Compelling storylines with meaningful choices
- **Session Planning**: Structured content for 3-4 hour sessions
- **Improvisation Support**: Quick generators for unexpected moments

Always ask clarifying questions about:
- Party level and composition
- Campaign setting and tone
- Available session time
- Player preferences and experience level
- Specific areas where the DM needs help

Remember: Your goal is to help create memorable, engaging experiences that bring players together around the table.]],
            },
            {
              role = "user",
              content = [[Help me to continue writing my campaign: ]],
              opts = {
                visible = false,
              },
            },
          },
        },
      },
      extensions = {
        vectorcode = {
          ---@type VectorCode.CodeCompanion.ExtensionOpts
          opts = {
            tool_group = {
              enabled = true,
              extras = {},
              collapse = false,
            },
            tool_opts = {
              ---@type VectorCode.CodeCompanion.ToolOpts
              ["*"] = {},
              ---@type VectorCode.CodeCompanion.LsToolOpts
              ls = {},
              ---@type VectorCode.CodeCompanion.VectoriseToolOpts
              vectorise = {},
              ---@type VectorCode.CodeCompanion.QueryToolOpts
              query = {
                max_num = { chunk = -1, document = -1 },
                default_num = { chunk = 50, document = 10 },
                include_stderr = false,
                use_lsp = false,
                no_duplicate = true,
                chunk_mode = false,
                ---@type VectorCode.CodeCompanion.SummariseOpts
                summarise = {
                  ---@type boolean|(fun(chat: CodeCompanion.Chat, results: VectorCode.QueryResult[]):boolean)|nil
                  enabled = false,
                  adapter = nil,
                  system_prompt = function(original_prompt)
                    return original_prompt
                  end,
                  query_augmented = true,
                },
              },
              files_ls = {},
              files_rm = {},
            },
          },
        },
        history = {
          enabled = true,
          opts = {
            keymap = "gh",
            save_chat_keymap = "sc",
            auto_save = true,
            expiration_days = 0,
            picker = "snacks",
            picker_keymaps = {
              rename = { n = "r", i = "<M-r>" },
              delete = { n = "d", i = "<M-r>" },
              duplicate = { n = "<C-y>", i = "<C-y>" },
            },
            auto_generate_title = false,
            -- title_generation_opts = {
            --   adapter = nil,
            --   model = nil,
            --   refresh_every_n_prompts = 2,
            --   max_refreshes = 3,
            -- },
            continue_last_chat = false,
            delete_on_clearing_chat = false,
            dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
            enable_logging = false,
            chat_filter = function(chat_data)
              return chat_data.cwd == vim.fn.getcwd()
            end,
          },
        },
        mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = {
            show_result_in_chat = true,
            make_vars = true,
            make_slash_commands = true,
          },
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
        tavily = function()
          return require("codecompanion.adapters").extend("tavily", {
            env = {
              api_key = tavily_api_key,
            },
          })
        end,
        display = {
          action_palette = {
            width = 20,
            height = 8,
            prompt = "Prompt ", -- Prompt used for interactive LLM calls
            provider = "snacks", -- Can be "default", "telescope", "fzf_lua", "mini_pick" or "snacks". If not specified, the plugin will autodetect installed providers.
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
  -- build = "make",
  -- event = "VeryLazy",
  -- version = false, -- Never set this value to "*"! Never!
  -- ---@module 'avante'
  -- ---@type avante.Config
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
  --       file_types = { "Avante" },
  --     },
  --     ft = { "Avante" },
  --   },
  -- },
  -- opts = {
  --   -- add any opts here
  --   -- for example
  --   input = {
  --     provider = "snacks",
  --     provider_opts = {
  --       title = "Avante Input",
  --       iccon = " ",
  --     },
  --   },
  --   provider = "ollama",
  --   providers = {
  --     ollama = {
  --       endpoint = "http://localhost:11434",
  --       model = "qwen2.5-coder:7b",
  --       extra_request_body = {
  --         max_tokens = 120000,
  --       },
  --     },
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
  -- rag_service = {
  --   enabled = true,
  --   host_mount = os.getenv("Home"),
  --   runner = "docker",
  --   llm = {
  --     provider = "ollama",
  --     endpoint = "http://localhost:11434",
  --     model = "qwen3:14b",
  --     extra = nil,
  --   },
  --   embed = {
  --     provider = "ollama",
  --     endpoint = "http://localhost:11434",
  --     model = "qwen3:14b",
  --     extra = nil,
  --   },
  --   docker_extra_args = "",
  -- },
  -- },
}
