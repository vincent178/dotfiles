-- lazypath = ~/.local/share/nvim/lazy/lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.background = "dark"   -- or "light" for light mode

vim.opt.swapfile = false      -- boolean: use a swapfile for the buffer
vim.opt.mouse = 'a'           -- string, global: Enable mouse support, 'a' for all previous modes
vim.opt.number = true         -- boolean: show line numbers
vim.opt.relativenumber = true -- boolean: show relative line numbers
vim.opt.cursorline = true     -- boolean: highlight the text line of the cursor
vim.opt.signcolumn = "yes"    -- string: show the sign column

-- Encoding
vim.opt.encoding = 'utf8'     -- string: string encoding to use
vim.opt.fileencoding = 'utf8' -- string: file encoding to use

-- Search
vim.opt.incsearch = true  -- boolean
vim.opt.hlsearch = true   -- boolean
vim.opt.smartcase = true  -- boolean: override the 'ignorecase' option if the search pattern contains upper case characters.
vim.opt.ignorecase = true -- boolean: ignore case in search patterns

-- Whitespace
vim.opt.expandtab = true -- boolean: use spaces instead of tabs
vim.opt.shiftwidth = 4   -- number:  size of an indent
vim.opt.softtabstop = 4  -- number:  number of spaces tabs count for in insert mode
vim.opt.tabstop = 4      -- number:  number of spaces tabs count for

-- Splits
vim.opt.splitright = true -- boolean: place new window to right of current one
vim.opt.splitbelow = true -- boolean: place new window below the current one

require("lazy").setup({
    -- System
    'ayu-theme/ayu-vim',
    'RRethy/nvim-base16',
    'ellisonleao/gruvbox.nvim',
    'nvim-lua/plenary.nvim',
    'christoomey/vim-tmux-navigator',
    'djoshea/vim-autoread',
    'tpope/vim-commentary',
    'jiangmiao/auto-pairs',
    'tpope/vim-surround',
    'akinsho/nvim-toggleterm.lua',
    'vincent178/nvim-github-linker',
    'wakatime/vim-wakatime',
    {
        'nvimdev/dashboard-nvim',
        event = 'VimEnter',
        config = function()
          require('dashboard').setup({})
        end,
        dependencies = { {'nvim-tree/nvim-web-devicons'}}
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
    },
    {
        'nvim-treesitter/nvim-treesitter',
        cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
        build = ":TSUpdate",
        config = function()
            require('nvim-treesitter.configs').setup({
                ensure_installed = { "go", "rust", "ruby", "javascript", "json", "toml", "markdown", "markdown_inline" },
                auto_install = true,
                sync_install = true,
                highlight = true,
            })
        end
    },
    {
         "folke/which-key.nvim",
          event = "VeryLazy",
          init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
          end,
    },
    {
         "folke/trouble.nvim",
         dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
        'nvim-tree/nvim-tree.lua',
        cmd = { 'NvimTreeToggle', 'NvimTreeFocus' },
        opts = {
            git = {
                enable = false
            },
            diagnostics = {
                enable = false
            },
        },
        config = function(_, opts)
            require('nvim-tree').setup(opts)
        end
    },
    {
        'nvim-tree/nvim-web-devicons',
        lazy = true
    },
    {
        'Exafunction/codeium.vim',
         event = 'BufEnter'
    },

    -- LSP
    'williamboman/mason.nvim',
    {
        'williamboman/mason-lspconfig.nvim',
        dependencies = { 'williamboman/mason.nvim', 'neovim/nvim-lspconfig' },
        config = function(_, _)
            require('mason').setup()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "rust_analyzer",
                    "gopls",
                    "lua_ls",
                    "pyright",
                    "jsonls",
                    "tsserver",
                    "ruby_ls"
                }
            })
        end
    },

    {
        'neovim/nvim-lspconfig',
        config = function(_, _)
            local config_lsp_servers = { "gopls", "pyright", "jsonls", "tsserver", "ruby_ls" }

            for _, lsp in ipairs(config_lsp_servers) do
                require('lspconfig')[lsp].setup({})
            end

            -- Custom Lua LSP config
            require('lspconfig').lua_ls.setup {
                settings = {
                    Lua = {
                        runtime = {
                            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                            version = 'LuaJIT',
                        },
                        diagnostics = {
                            -- Get the language server to recognize the `vim` global
                            globals = { 'vim' },
                        },
                        workspace = {
                            -- Make the server aware of Neovim runtime files
                            library = vim.api.nvim_get_runtime_file("", true),
                        },
                        -- Do not send telemetry data containing a randomized but unique identifier
                        telemetry = {
                            enable = false,
                        },
                    },
                },
            }
        end
    },
    {
        'glepnir/lspsaga.nvim',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'nvim-tree/nvim-web-devicons'
        },
        config = function()
            require('lspsaga').setup({})
        end
    },
    {
        'j-hui/fidget.nvim',
        tag = "legacy",
        event = "LspAttach",
        config = function()
            require('fidget').setup({})
        end
    },
    'mfussenegger/nvim-dap',
    'rcarriga/nvim-dap-ui',

    -- Autocomplete
    'hrsh7th/vim-vsnip',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'delphinus/cmp-ctags',
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/vim-vsnip',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'delphinus/cmp-ctags',
        },
        config = function()
            local cmp = require('cmp')
            cmp.setup({
                snippet = {
                    expand = function(args)
                        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                }),
                sources = cmp.config.sources({
                    { name = 'path' },                                       -- file paths
                    { name = 'nvim_lsp' },                                   -- from language server
                    { name = 'nvim_lsp_signature_help' },                    -- display function signatures with current parameter emphasized
                    { name = 'nvim_lua', keyword_length = 2 },               -- complete neovim's Lua runtime API such vim.lsp.*
                    { name = 'buffer', keyword_length = 2 },                 -- source current buffer
                    { name = 'calc' },                                       -- source for math calculation
                    { name = 'vsnip' },                                      -- For vsnip
                    {
                        name = 'ctags',                                      -- For universal ctags
                        option = {
                            trigger_characters_ft = {
                                ruby = {'.', '::'}
                            },
                        }
                    },
                }),
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                formatting = {
                    fields = { 'menu', 'abbr', 'kind' },
                    format = function(entry, item)
                        print(entry, item)
                        local menu_icon = {
                            nvim_lsp = 'λ',
                            vsnip = '⋗',
                            buffer = 'Ω',
                            path = 'Þ',
                            ctags = '',
                        }
                        item.menu = menu_icon[entry.source.name]
                        return item
                    end,
                }
        })
        end
    },

    -- Git
    'tpope/vim-fugitive',
    'tpope/vim-rhubarb',
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup({})
        end
    },

    -- Fuzzy Finder
    'nvim-telescope/telescope-fzf-native.nvim',
    'nvim-telescope/telescope-live-grep-args.nvim',
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-telescope/telescope-fzf-native.nvim',
            'nvim-telescope/telescope-rg.nvim',
            'nvim-telescope/telescope-frecency.nvim',
            'nvim-telescope/telescope-live-grep-args.nvim',
            'folke/trouble.nvim',
        },
        config = function()
            local telescope = require("telescope")
            local trouble = require("trouble.providers.telescope")
            telescope.setup {
                defaults = {
                    cache_picker = {
                        num_pickers = -1,
                    },
                    mappings = {
                        i = { ["<C-t>"] = trouble.open_with_trouble },
                        n = { ["<C-t>"] = trouble.open_with_trouble },
                    },
                },
                pickers = {
                    find_files = {
                        find_command = { 'fd', '--type', 'f', '--strip-cwd-prefix', '--exclude', '.git', '--hidden' },
                    }
                },
                extensions = {
                    fzf = {
                        case_mode = "ignore_case",
                    }
                }
            }
            telescope.load_extension('fzf')
            telescope.load_extension('live_grep_args')
        end
    },
})

-- clear sign column highlights so that sign column is the same color as where your line numbers show up
-- see more: https://stackoverflow.com/questions/15277241/changing-vim-gutter-color
vim.cmd('highlight clear SignColumn')

vim.cmd('colorscheme base16-gruvbox-dark-hard')

-- Auto Format
-- cmd([[
-- autocmd BufWritePre * lua vim.lsp.buf.format()
-- ]])

local signs = {Error = '', Warn = '', Hint = '', Info = ''}
for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = ''})
end

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    update_in_insert = true,
    underline = false,
    severity_sort = true,
    float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '- ',
    },
})

require("which-key").register({
    ["<Leader>f"] = {
        name = "find",
        g = { require('telescope').extensions.live_grep_args.live_grep_args, "Find in project" },
        f = { require('telescope.builtin').find_files, "List files" },
        b = { require('telescope.builtin').buffers, "List buffers" },
        v = { require('telescope.builtin').registers, "List registers" },
        m = { require('telescope.builtin').marks, "List marks" },
        t = { require('telescope.builtin').colorscheme, "List colorscheme" },
        d = { require('telescope.builtin').lsp_document_diagnostics, "Document diagnostics" },
        w = { require('telescope.builtin').lsp_workspace_diagnostics, "Workspace diagnostics" },
    },

    ["<Leader>t"] = {
        name = "tab",
        a = { "<cmd>tabnew<CR>", "New tab" },
        c = { "<cmd>tabclose<CR>", "Close tab" },
        o = { "<cmd>tabonly<CR>", "Only tab" },
        n = { "<cmd>tabn<CR>", "Next tab" },
        p = { "<cmd>tabp<CR>", "Previous tab" },
    },

    ["<Leader>m"] = {
        name = "menu",
        a = { "<cmd>Lspsaga code_action<CR>", "LSP code action" },
        r = { "<cmd>Lspsaga rename<CR>", "LSP rename" },
        f = { "<cmd>NvimTreeToggle<CR>", "Toggle file tree" },
    },

    K = { "<cmd>Lspsaga hover_doc<CR>", "LSP hover doc" },
    gh = { "<cmd>Lspsaga finder<CR><cr>", "LSP finder" },
    gD = { "<cmd>Lspsaga peek_definition<CR>", "LSP definition" },
    gd = { vim.lsp.buf.definition, "LSP go to definition" },
    gi = { require('telescope.builtin').lsp_implementations, "Go to implementation" },
    gr = { require('telescope.builtin').lsp_references, "Go to references" },
    ['<Leader>/'] = { require('telescope.builtin').current_buffer_fuzzy_find, "Find in current file" },
    ['<CR>'] = { "<cmd>noh<CR><CR>", "Clear search highlight" },

    ["[d"] = { "<cmd>Lspsaga diagnostic_jump_prev<CR>", "Previous diagnostic" },
    ["]d"] = { "<cmd>Lspsaga diagnostic_jump_next<CR>", "Next diagnostic" },
    ["[e"] = { function() require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR }) end, "Previous error" },
    ["]e"] = { function() require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR }) end, "Next error" },
    ['<c-]>'] = { "g<c-]>", "Jump to definition" },
})

require('which-key').register({
    ['<C-a>'] = { "<Home>", "Move cursor to start of line" },
    ['<C-e>'] = { "<End>", "Move cursor to end of line" },
    ['<C-b>'] = { "<Left>", "Move cursor left" },
    ['<C-f>'] = { "<Right>", "Move cursor right" },
}, { mode = 'i' })
