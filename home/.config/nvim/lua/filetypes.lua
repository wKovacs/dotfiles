vim.api.nvim_create_autocmd({ "BufWrite" }, {
    callback = function()
        save_cursor = vim.fn.getpos(".")
        vim.cmd([[%s/\s\+$//e]])
        vim.fn.setpos(".", save_cursor)
    end,
})
