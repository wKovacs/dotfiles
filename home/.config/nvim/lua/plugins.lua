-- Setup Pluginmanager Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",     -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

-- Install Plugins
require("lazy").setup({
    spec = {
        "tpope/vim-fugitive",
        "myusuf3/numbers.vim",
        "tpope/vim-surround",
        "airblade/vim-gitgutter",
        "folke/tokyonight.nvim",
        "nvim-tree/nvim-tree.lua",
        "nvim-lualine/lualine.nvim",
        "nvim-tree/nvim-web-devicons",
        "neovim/nvim-lspconfig",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lsp",
        "saadparwaiz1/cmp_luasnip",
        "L3MON4D3/LuaSnip",
        "numToStr/FTerm.nvim",
        "stevearc/aerial.nvim",
        "google/vim-jsonnet",
        "mfussenegger/nvim-ansible",
        { {
            "nvim-treesitter/nvim-treesitter",
            build = ":TSUpdate",
            config = function()
                local configs = require("nvim-treesitter.configs")

                configs.setup({
                    ensure_installed = { "vim", "vimdoc", "markdown", "terraform" },
                    sync_install = false,
                    highlight = { enable = true },
                    indent = { enable = true },
                })
            end
        } }
    },
    rocks = {
        enabled = false
    },
    pkg = {
        enabled = false
    }
})

-- theme
require("tokyonight").setup {
    style = "night",
    sidebars = { "qf", "help", "NvimTree" },
}

-- lualine
require('lualine').setup {
    options = {
        theme = 'tokyonight',
        globalstatus = true,
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
    },
    sections = {
        lualine_c = {
            {
                'filename',
                path= 1,
            },
        },
        lualine_x = {
            "aerial",
            {
                'fileformat',
                symbols = {
                    unix = '', -- e712
                    dos = '', -- e70f
                    mac = '', -- e711
                }
            },

        },
        lualine_y = { 'filetype' },
        lualine_z = { 'searchcount', 'location' },
    }
}

-- numbers
local numbers_exclude = vim.g.numbers_exclude
table.insert(numbers_exclude, "NvimTree")
table.insert(numbers_exclude, "aerial")
vim.g.numbers_exclude = numbers_exclude

-- nvim-tree.lua
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- empty setup using defaults
local function my_on_attach(bufnr)
    local api = require "nvim-tree.api"

    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- custom mappings
    vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent, opts('Up'))
    vim.keymap.set('n', 'C', api.tree.change_root_to_node, opts('CD'))
    vim.keymap.set('n', 's', api.node.open.vertical, opts('Open: Vertical Split'))
end

-- pass to setup along with your other options
require("nvim-tree").setup {
    on_attach = my_on_attach,
    view = {
        float = {
            enable = true,
        }
    },
    filters = {
        dotfiles = true,
    },
    renderer = {
        highlight_opened_files = "icon",
        icons = {
            glyphs = {
                git = {
                    unstaged = "",
                    staged = "",
                    unmerged = "",
                    renamed = "",
                    untracked = "",
                    deleted = "",
                    ignored = "",
                },
            }
        }
    }
}

-- terminal
require 'FTerm'.setup {
    border     = 'double',
    dimensions = {
        height = 0.15,
        width = 0.9,
        x = 0.5,
        y = 0.95,
    },
}

-- aerial outline
require("aerial").setup {
    -- optionally use on_attach to set keymaps when aerial has attached to a buffer
    on_attach = function(bufnr)
        -- Jump forwards/backwards with '{' and '}'
        vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
        vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
    end,
    layout = {
        default_direction = "float",
        placement = "edge",
    },
    float = {
        relative = "editor",
        override = function(conf, source_winid)
            -- This is the config that will be passed to nvim_open_win.
            -- Change values here to customize the layout
            conf.row = 0
            local width = vim.api.nvim_win_get_width(source_winid)
            conf.col = width - 1
            conf.anchor = "NE"
            return conf
        end,
    },

}

vim.g.jsonnet_fmt_on_save = 0
