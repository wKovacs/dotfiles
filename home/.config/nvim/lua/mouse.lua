-- lua/mouse.lua
-- Mouse and clipboard integration for Neovim
-- Works with Konsole selection and system clipboard

-- Enable mouse support in all modes when Neovim is focused
vim.opt.mouse = "a"

-- Use the system clipboard for all yank, delete, change, put operations
vim.opt.clipboard = "unnamedplus"

-- Optional: visually highlight the current line for better mouse feedback
vim.opt.cursorline = true

-- Auto-toggle mouse on focus
vim.api.nvim_create_autocmd("FocusLost", {
  callback = function()
    -- Disable mouse when Neovim loses focus so terminal selection works
    vim.opt.mouse = ""
  end,
})

vim.api.nvim_create_autocmd("FocusGained", {
  callback = function()
    -- Re-enable mouse when Neovim regains focus
    vim.opt.mouse = "a"
  end,
})

-- Optional: temporarily disable relative number in visual mode
-- to avoid copying line numbers
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

-- Remove unreliable <LeftRelease> yank mapping
-- Visual yanking automatically goes to system clipboard due to 'unnamedplus'
-- No need to try to yank on mouse release
