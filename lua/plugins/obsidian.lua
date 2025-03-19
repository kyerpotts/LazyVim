-- Failed to run `config` for obsidian.nvim
--
-- ...ocal/share/nvim/lazy/obsidian.nvim/lua/obsidian/init.lua:104: module 'cmp' not found:
-- 	no field package.preload['cmp']
-- cache_loader: module cmp not found
-- cache_loader_lib: module cmp not found
-- 	no file './cmp.lua'
-- 	no file '/usr/share/luajit-2.1/cmp.lua'
-- 	no file '/usr/local/share/lua/5.1/cmp.lua'
-- 	no file '/usr/local/share/lua/5.1/cmp/init.lua'
-- 	no file '/usr/share/lua/5.1/cmp.lua'
-- 	no file '/usr/share/lua/5.1/cmp/init.lua'
-- 	no file './cmp.so'
-- 	no file '/usr/local/lib/lua/5.1/cmp.so'
-- 	no file '/usr/lib/lua/5.1/cmp.so'
-- 	no file '/usr/local/lib/lua/5.1/loadall.so'
--
-- # stacktrace:
--   - /obsidian.nvim/lua/obsidian/init.lua:104 _in_ **setup**
--   - .config/nvim/lua/config/lazy.lua:17
--   - .config/nvim/init.lua:2
return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = false,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "Braincage",
        path = "~/Documents/Braincage/",
      },
    },
    completion = {
      min_chars = 2,
    },
    mappings = {
      ["gf"] = {
        action = function()
          return require("obsidian").util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
      ["<leader>ch"] = {
        action = function()
          return require("obsidian").util.toggle_checkbox()
        end,
        opts = { buffer = true },
      },
      ["<cr>"] = {
        action = function()
          return require("obsidian").util.smart_action()
        end,
        opts = { buffer = true, expr = true },
      },
    },
    picker = {
      name = "fzf-lua",
      note_mappings = {
        new = "<C-x>",
        insert_link = "<C-l>",
      },
      tag_mappings = {
        tag_note = "<C-x>",
        insert_tag = "<C-l>",
      },
    },
    note_id_func = function(title)
      local suffix = ""
      if title ~= nil then
        suffix = title
      else
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end
      return suffix
    end,
  },
}
