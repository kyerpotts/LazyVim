return {
  "ravitemer/mcphub.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  build = "npm install -g mcp-hub@latest", -- Installs `mcp-hub` node binary globally
  opts = {},
  require("which-key").add({
    mode = { "n", "v" },
    {
      { "<leader>am", "<cmd>MCPHub<cr>", desc = "MCPHub" },
    },
  }),
}
