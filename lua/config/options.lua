-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options hereif vim.fn.has('wsl') == 1 then
if vim.fn.has("wsl") == 1 then
  local copy = { "/mnt/c/Windows/System32/clip.exe" }
  local paste = {
    "/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe",
    "-NonInteractive",
    "-NoProfile",
    "-NoLogo",
    "-c",
    '[Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
  }
  vim.g.clipboard = {
    name = "WslClipboard",
    copy = {
      ["+"] = copy,
      ["*"] = copy,
    },
    paste = {
      ["+"] = paste,
      ["*"] = paste,
    },
    cache_enabled = 0,
  }
end
