return {
  "christoomey/vim-tmux-navigator",
  event = "VeryLazy",
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
    "TmuxNavigateProcessList",
  },
  keys = {
    { "<c-h>", "<cmd><C-U>TmuxNavigateLeft", desc = "Tmux Navigate Left" },
    { "<c-j>", "<cmd><C-U>TmuxNavigateDown", desc = "Tmux Navigate Down" },
    { "<c-k>", "<cmd><C-U>TmuxNavigateUp", desc = "Tmux Navigate Up" },
    { "<c-l>", "<cmd><C-U>TmuxNavigateRight", desc = "Tmux Navigate Right" },
  },
}
