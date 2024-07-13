vim.opt.mouse = "a" --启用鼠标点击

vim.opt.clipboard = "unnamedplus" --剪贴板寄存器设置为系统剪贴板
vim.g.clipboard = { --实现WSL下剪贴板功能
  name = "WslClipboard",
  copy = {
    ["+"] = "clip.exe",
    ["*"] = "clip.exe",
  },
  paste = {
    ["+"] = "powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace('`r', ''))",
    ["*"] = "powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace('`r', ''))",
  },
  cache_enabled = 0,
}