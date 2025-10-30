-- lua/mouse.lua
-- Mouse and clipboard integration for Neovim

-- Enable mouse support in all modes
vim.opt.mouse = "a"

-- Use the system clipboard for all yank, delete, change, put operations
vim.opt.clipboard = "unnamedplus"

-- Yank visual selection to system clipboard when releasing left mouse button
-- Works in visual mode: drag to select, release to yank
vim.keymap.set("x", "<LeftRelease>", '"+y', { noremap = true, silent = true })

-- Optional: if you use line numbers and don’t want them copied,
-- this autocommand toggles relativenumber off in visual mode
-- so only the text is yanked.
vim.api.nvim_create_autocmd("ModeChanged", {
  pattern = { "*:v", "*:V", "*:\22" }, -- entering visual modes
  callback = function()
    vim.opt.relativenumber = false
  end,
})

vim.api.nvim_create_autocmd("ModeChanged", {
  pattern = { "v:*", "V:*", "\22:*" }, -- leaving visual modes
  callback = function()
    vim.opt.relativenumber = true
  end,
})

-- Auto-toggle mouse based on focus
vim.api.nvim_create_autocmd("FocusLost", {
  callback = function()
    vim.opt.mouse = ""
  end,
})

vim.api.nvim_create_autocmd("FocusGained", {
  callback = function()
    vim.opt.mouse = "a"
  end,
})

