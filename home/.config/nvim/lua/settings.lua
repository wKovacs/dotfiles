vim.cmd.colorscheme('tokyonight')

vim.opt.background="dark"
vim.opt.wildmode="longest:full,full"
vim.opt.visualbell=true
vim.opt.cursorline=true
vim.opt.cursorcolumn=true
vim.opt.number=true

-- Whitespace
vim.opt.wrap=true
vim.opt.tabstop=4
vim.opt.shiftwidth=4
vim.opt.softtabstop=4
vim.opt.expandtab=true

-- Searching
vim.opt.ignorecase=true
vim.opt.smartcase=true
vim.opt.gdefault=true

vim.opt.lazyredraw=true
vim.opt.showmatch=true
vim.opt.iskeyword:remove({'_'})

vim.opt.backupdir=HOME .."/.vimtmp"
vim.opt.directory=HOME .. "/.vimtmp"

-- Use system clipboard for all Neovim copy/paste operations avoiding copying of line numbers
vim.opt.clipboard = 'unnamedplus'

-- Remove auto-commenting (new lines start with comment chracter if current line is a comment)
vim.opt.formatoptions:remove({'r', 'o'})

-- Disable auto-commenting after filetype plugins load
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*", -- Apply to all file types
  callback = function()
    vim.opt.formatoptions:remove({'r', 'o'})
  end,
})
