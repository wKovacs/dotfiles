-- ./lua/tmux.lua
vim.cmd([[
  augroup TmuxMouse
    autocmd!
    " Disable tmux mouse when entering Neovim
    autocmd VimEnter * silent !tmux set -g mouse off
    " Restore tmux mouse when leaving Neovim
    autocmd VimLeave * silent !tmux set -g mouse on
  augroup END
]])
