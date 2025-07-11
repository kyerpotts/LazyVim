return {
  {
    "eldritch-theme/eldritch.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      palette = "default",
      transparent = true,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { bold = true },
        functions = { italic = true },
        variables = {},
        sidebars = "dark",
        floats = "dark",
      },
      lualine_bold = true,
    },
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
      style = "moon",
      styles = {
        keywords = { bold = true },
        functions = { italic = true },
        sidebars = "transparent",
        floats = "transparent",
      },
      dim_inactive = true,
    },
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      compile = false,
      undercurl = false,
      commentStyle = { italic = true },
      functionStyle = { bold = true },
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      typeStyle = {},
      transparent = true,
      dimInactive = false,
      terminalColors = false,
      colors = {
        palette = {},
        theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
      },
    },
  },
  -- {
  --   "scottmckendry/cyberdream.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require("cyberdream").setup({
  --       variant = "default",
  --       transparent = true,
  --       italic_comments = true,
  --     })
  --   end,
  -- },
  -- {
  --   "wtfox/jellybeans.nvim",
  --   lazy = false,
  --   priority = 0,
  --   opts = {
  --     style = "dark",
  --     transparent = true,
  --     italics = true,
  --     plugins = {
  --       all = true,
  --       auto = true,
  --     },
  --   },
  -- },
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },
  -- lua/plugins/rose-pine.lua
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require("rose-pine").setup({
        variant = "auto", -- auto, main, moon, or dawn
        dark_variant = "main", -- main, moon, or dawn
        dim_inactive_windows = false,
        extend_background_behind_borders = true,

        enable = {
          terminal = true,
          legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
          migrations = true, -- Handle deprecated options automatically
        },

        styles = {
          bold = true,
          italic = true,
          transparency = false,
        },

        groups = {
          border = "muted",
          link = "iris",
          panel = "surface",

          error = "love",
          hint = "iris",
          info = "foam",
          note = "pine",
          todo = "rose",
          warn = "gold",

          git_add = "foam",
          git_change = "rose",
          git_delete = "love",
          git_dirty = "rose",
          git_ignore = "muted",
          git_merge = "iris",
          git_rename = "pine",
          git_stage = "iris",
          git_text = "rose",
          git_untracked = "subtle",

          h1 = "iris",
          h2 = "foam",
          h3 = "rose",
          h4 = "gold",
          h5 = "pine",
          h6 = "foam",
        },

        palette = {
          -- Override the builtin palette per variant
          -- moon = {
          --     base = '#18191a',
          --     overlay = '#363738',
          -- },
        },

        highlight_groups = {
          Comment = { fg = "foam" },
          VertSplit = { fg = "muted", bg = "muted" },
        },

        before_highlight = function(group, highlight, palette)
          -- Disable all undercurls
          if highlight.undercurl then
            highlight.undercurl = false
          end
          --
          -- Change palette colour
          -- if highlight.fg == palette.pine then
          --   highlight.fg = palette.foam
          -- end
        end,
      })

      -- vim.cmd("colorscheme rose-pine-main")
      -- vim.cmd("colorscheme rose-pine-moon")
      -- vim.cmd("colorscheme rose-pine-dawn")
    end,
  },
  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "monokai-pro",
      colorscheme = "tokyonight",
      -- colorscheme = "cyberdream",
    },
  },
}
