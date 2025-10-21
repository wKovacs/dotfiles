vim.g.mapleader = " "
Nmap("<leader><space>", ":noh<cr>")

-- remap
-- Imap("jj", "<ESC>")
Imap("<c-e>", "<c-o>$")
Imap("<c-a>", "<c-o>^")
Nmap("<leader>b", "<c-t>")

-- Windows
Nmap("<C-j>", "<c-w>j")
Nmap("<C-k>", "<c-w>k")
Nmap("<C-h>", "<c-w>h")
Nmap("<C-l>", "<c-w>l")
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Markdown Headlines
Nmap("<leader>1", "yypVr=")
Nmap("<leader>2", "yypVr-")

-- Yanking
Nmap("<Leader>y", ":reg<CR>")
Vmap("<Leader>y", "\"+y")
Vmap("<Leader>d", "\"+d")
Nmap("<Leader>p", "\"+p")
Nmap("<Leader>P", "\"+P")
Vmap("<Leader>p", "\"+p")
Vmap("<Leader>P", "\"+P")

-- sudo/doas write
if (os.execute('which doas') == 0)
then
    vim.api.nvim_set_keymap("c", "w!", "w !doas tee %", { noremap = true, silent = false })
else
    vim.api.nvim_set_keymap("c", "w!", "w !sudo tee %", { noremap = true, silent = false })
end

-- Move in Command mode
Cmap("<C-a>", "<Home>")
Cmap("<C-b>", "<Left>")
Cmap("<C-f>", "<Right>")
Cmap("<C-d>", "<Delete>")
Cmap("<M-b>", "<S-Left>")
Cmap("<M-f>", "<S-Right>")

-- Plugins
-- NvimTree
Nmap("<leader>f", ":NvimTreeToggle<cr>")

-- Fterm
vim.keymap.set('n', "<Leader>t", '<CMD>lua require("FTerm").toggle()<CR>')
vim.keymap.set('t', "jj", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')

-- Aerial
vim.keymap.set("n", "<Leader>a", "<cmd>AerialToggle!<CR>")
vim.keymap.set("n", "<Leader>A", "<cmd>AerialOpen<CR>")

-- Disable Neovim's built-in right-click handling to prevent context menu and double-paste.
vim.api.nvim_set_keymap('n', '<RightMouse>', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<RightMouse>', '<Nop>', { noremap = true, silent = true })

-- Minimal mapping to ensure Space starts Visual Mode when sent from tmux.
vim.api.nvim_set_keymap('n', ' ', 'v', { noremap = true, silent = true })
