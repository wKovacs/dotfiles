-- Map Functions
function Map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function Nmap(shortcut, command)
  Map('n', shortcut, command)
end

function Imap(shortcut, command)
  Map('i', shortcut, command)
end

function Vmap(shortcut, command)
  Map('v', shortcut, command)
end

function Cmap(shortcut, command)
  Map('c', shortcut, command)
end
HOME = os.getenv("HOME")
