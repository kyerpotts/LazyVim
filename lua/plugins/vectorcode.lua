return {
  "Davidyz/VectorCode",
  version = "*",
  build = "uv tool upgrade vectorcode",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  cmd = "VectorCode",
  event = "VeryLazy",
}
