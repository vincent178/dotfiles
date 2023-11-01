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

vim.opt.swapfile = false      -- boolean: Use a swapfile for the buffer
vim.opt.mouse = 'a'           -- string, global: Enable mouse support, 'a' for all previous modes
vim.opt.number = true         -- boolean: Show line numbers
vim.opt.relativenumber = true -- boolean: Show relative line numbers
vim.opt.cursorline = true     -- boolean: Highlight the text line of the cursor
vim.opt.signcolumn = "yes"    -- str: Show the sign column

-- Encoding
vim.opt.encoding = 'utf8'     -- str:  String encoding to use
vim.opt.fileencoding = 'utf8' -- str:  File encoding to use

-- Search
vim.opt.incsearch = true  -- boolean
vim.opt.hlsearch = true   -- boolean
vim.opt.smartcase = true  -- boolean: Override the 'ignorecase' option if the search pattern contains upper case characters.
vim.opt.ignorecase = true -- boolean: Ignore case in search patterns

-- Whitespace
vim.opt.expandtab = true -- boolean: Use spaces instead of tabs
vim.opt.shiftwidth = 4   -- num:  Size of an indent
vim.opt.softtabstop = 4  -- num:  Number of spaces tabs count for in insert mode
vim.opt.tabstop = 4      -- num:  Number of spaces tabs count for

-- Splits
vim.opt.splitright = true -- boolean: Place new window to right of current one
vim.opt.splitbelow = true -- boolean: Place new window below the current one

require("lazy").setup({
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
                ensure_installed = { "go", "rust", "ruby", "javascript", "json", "toml", "markdown", "markdown_inline" }, -- A list of parser names
                auto_install = true,                                                       -- Automatically install missing parsers when entering buffer
                sync_install = true,                                                       -- Install parsers synchronously (only applied to `ensure_installed`)
                highlight = true
            })
        end
    },

    {
         "folke/which-key.nvim",
          event = "VeryLazy",
          init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
          end
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

    'hrsh7th/vim-vsnip',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',

    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/vim-vsnip',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
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
                sources = {
                    { name = 'path' },                                       -- file paths
                    { name = 'nvim_lsp' },                                   -- from language server
                    { name = 'nvim_lsp_signature_help' },                    -- display function signatures with current parameter emphasized
                    { name = 'nvim_lua',               keyword_length = 2 }, -- complete neovim's Lua runtime API such vim.lsp.*
                    { name = 'buffer',                 keyword_length = 2 }, -- source current buffer
                    { name = 'calc' },                                       -- source for math calculation
                    { name = 'vsnip' },                                      -- For vsnip users.
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                formatting = {
                    fields = { 'menu', 'abbr', 'kind' },
                    format = function(entry, item)
                        local menu_icon = {
                            nvim_lsp = 'λ',
                            vsnip = '⋗',
                            buffer = 'Ω',
                            path = 'Þ',
                        }
                        item.menu = menu_icon[entry.source.name]
                        return item
                    end,
                }
        })
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

    'tpope/vim-fugitive',
    'tpope/vim-rhubarb',
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup({})
        end
    },

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

    'tami5/sqlite.lua',

    'junegunn/seoul256.vim',
    'mhartington/oceanic-next',
    'ayu-theme/ayu-vim',
    'joshdick/onedark.vim',
    'dracula/vim',
    'RRethy/nvim-base16',
    'rebelot/kanagawa.nvim',
    'ellisonleao/gruvbox.nvim',
    'sam4llis/nvim-tundra',
})

-- clear sign column highlights, see more: https://stackoverflow.com/questions/15277241/changing-vim-gutter-color
vim.cmd('highlight clear SignColumn')

vim.cmd('colorscheme base16-gruvbox-dark-hard')


-- Auto Format
-- cmd([[
-- autocmd BufWritePre * lua vim.lsp.buf.format()
-- ]])

local sign = function(opts)
    vim.fn.sign_define(opts.name, {
        texthl = opts.name,
        text = opts.text,
        numhl = ''
    })
end

sign({ name = 'DiagnosticSignError', text = '' })
sign({ name = 'DiagnosticSignWarn', text = '' })
sign({ name = 'DiagnosticSignHint', text = '' })
sign({ name = 'DiagnosticSignInfo', text = '' })

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

local noremap = { noremap = true }

-- Move cursor when insert mode
vim.keymap.set('i', "<C-a>", "<Home>", noremap)
vim.keymap.set('i', "<C-e>", "<End>", noremap)
vim.keymap.set('i', "<C-b>", "<Left>", noremap)
vim.keymap.set('i', "<C-f>", "<Right>", noremap)

-- Clipboard
vim.keymap.set('v', '<Leader>y', '"+y', noremap)
vim.keymap.set('n', '<Leader>Y', '"+yg_', noremap)
vim.keymap.set('n', '<Leader>y', '"+y', noremap)
vim.keymap.set('n', '<Leader>yy', '"+yy', noremap)

vim.keymap.set('n', '<Leader>p', '"+p', noremap)
vim.keymap.set('n', '<Leader>P', '"+P', noremap)
vim.keymap.set('v', '<Leader>p', '"+p', noremap)
vim.keymap.set('v', '<Leader>P', '"+P', noremap)

local wk = require("which-key")

wk.register({
    ["<Leader>n"] = {
        name = "file tree",
        t = { "<cmd>NvimTreeToggle<CR>", "Toggle file tree" },
        c = { "<cmd>NvimTreeFocus<CR>", "Focus current buffer in file tree" },
        f = { "<cmd>NvimTreeFindFile<CR>", "Move cursor for current buffer" },
    },

    ["<Leader>f"] = {
        name = "find",
        c = { require('telescope.builtin').current_buffer_fuzzy_find, "Find in current file" },
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
        mp = { "<cmd>tabmove -1<CR>", "Move tab to previous position" },
        mn = { "<cmd>tabmove +1<CR>", "Next tab to next position" },
    },

    ["<Leader>/"] = { ":nohlsearch<CR>", "clear highlight" },
    ['<Leader>ca'] = { "<cmd>Lspsaga code_action<CR>", "LSP code action" },
    ['<Leader>rn'] = { "<cmd>Lspsaga rename<CR>", "LSP rename" },
    gh = { "<cmd>Lspsaga finder<CR><cr>", "LSP finder" },
    gD = { "<cmd>Lspsaga peek_definition<CR>", "LSP definition" },
    gd = { vim.lsp.buf.definition, "LSP go to definition" },
    K = { "<cmd>Lspsaga hover_doc<CR>", "LSP hover doc" },
    gi = { require('telescope.builtin').lsp_implementations, "Go to implementation" },
    gr = { require('telescope.builtin').lsp_references, "Go to references" },

    ["[d"] = { "<cmd>Lspsaga diagnostic_jump_prev<CR>", "Previous diagnostic" },
    ["]d"] = { "<cmd>Lspsaga diagnostic_jump_next<CR>", "Next diagnostic" },
    ["[e"] = { function() require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR }) end, "Previous error" },
    ["]e"] = { function() require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR }) end, "Next error" },
})
