-- ==========================================
-- 1. Core Options
-- ==========================================
vim.g.mapleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.clipboard = 'unnamedplus'
vim.opt.termguicolors = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.guicursor = "n-v-c-i:block"
vim.opt.showmode = false

-- ==========================================
-- 2. Bootstrap Lazy.nvim
-- ==========================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ==========================================
-- 3. Plugins
-- ==========================================
require("lazy").setup({
    -- [THEME CHANGE] Pywal (Syncs with System/Matugen)
    {
        "AlphaTechnolog/pywal.nvim",
        priority = 1000,
        config = function()
            require("pywal").setup()
            vim.cmd.colorscheme "pywal"
        end
    },

    -- Old Theme (Disabled)
    -- {
    --     "lunarvim/synthwave84.nvim",
    --     priority = 1000,
    --     config = function()
    --         vim.cmd.colorscheme "synthwave84"
    --     end
    -- },

    -- Status Line (Lualine)
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lualine').setup({
                -- Auto theme usually picks up pywal correctly
                options = { theme = 'auto', component_separators = '', section_separators = { left = '', right = '' } },
                sections = { lualine_c = { '%=' }, lualine_x = {}, lualine_y = { 'filetype', 'progress' }, lualine_z = { { 'location', separator = { right = '' }, left_padding = 2 } } },
            })
        end
    },

    -- Tmux Navigation
    { "christoomey/vim-tmux-navigator" },

    -- File Explorer (Neo-tree)
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" },
        keys = { { "<leader>e", ":Neotree toggle<CR>", desc = "Toggle Explorer" } }
    },

    -- Git Integration (LazyGit)
    {
        "kdheepak/lazygit.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            { "<leader>gg", ":LazyGit<CR>", desc = "Open Git Tree (LazyGit)" }
        }
    },

    -- GitHub Copilot
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                suggestion = { enabled = true, auto_trigger = true, keymap = { accept = "<C-l>" } },
                panel = { enabled = false },
            })
        end,
    },

    -- Telescope (Finder)
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.5',
        dependencies = { 'nvim-lua/plenary.nvim' },
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File" },
            { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Find Text" },
        }
    },

    -- Treesitter (Syntax Highlighting)
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local status, configs = pcall(require, "nvim-treesitter.configs")
            if status then
                configs.setup({
                    ensure_installed = { "c", "cpp", "python", "javascript", "typescript", "tsx", "dart", "kotlin", "lua" },
                    sync_install = false,
                    auto_install = true,
                    highlight = { enable = true },
                    indent = { enable = true },
                })
            end
        end
    },

    -- Flutter Tools
    {
        'akinsho/flutter-tools.nvim',
        dependencies = { 'nvim-lua/plenary.nvim', 'stevearc/dressing.nvim' },
        config = function()
            require("flutter-tools").setup({
                ui = { border = "rounded" },
                decorations = { statusline = { app_version = true, device = true } },
                widget_guides = { enabled = true, debug = true },
            })
        end
    },

    -- LSP & Autocomplete
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
            "L3MON4D3/LuaSnip",
        },
        config = function()
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            -- Mason Setup
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = { "clangd", "pyright", "ts_ls", "kotlin_language_server" },
                handlers = {
                    function(server_name)
                        require("lspconfig")[server_name].setup({
                            capabilities = capabilities
                        })
                    end,
                }
            })

            -- Autocomplete Setup
            local cmp = require('cmp')
            cmp.setup({
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    ['<Tab>'] = cmp.mapping.select_next_item(),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                })
            })
        end
    },
}, {
    concurrency = 1,
    git = { timeout = 300 },
})

-- ==========================================
-- 4. Key Mappings
-- ==========================================
vim.keymap.set("i" ,"jk" , "<Esc>l" ,{desc = "exit insert mode "} )
vim.keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })
vim.keymap.set({ "i", "n" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- Buffer Nav
vim.keymap.set("n", "<S-l>", ":bnext<CR>", { desc = "Next Buffer" })
vim.keymap.set("n", "<S-h>", ":bprev<CR>", { desc = "Prev Buffer" })
vim.keymap.set("n", "<leader>x", ":bdelete<CR>", { desc = "Close Buffer" })

-- Flutter Commands
vim.keymap.set("n", "<leader>fr", ":FlutterRun<CR>", { desc = "Flutter Run" })
vim.keymap.set("n", "<leader>fq", ":FlutterQuit<CR>", { desc = "Flutter Quit" })
vim.keymap.set("n", "<leader>fR", ":FlutterRestart<CR>", { desc = "Flutter Hot Restart" })
