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
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
    },

    {
        'nvim-treesitter/nvim-treesitter',
        cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
        build = ":TSUpdate",
        config = function()
            require('nvim-treesitter.configs').setup({
                ensure_installed = { "go", "rust", "ruby", "javascript", "json", "toml" }, -- A list of parser names
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
            local config_lsp_servers = { "gopls", "pyright", "jsonls", "tsserver" }

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

    'glepnir/lspsaga.nvim',

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

    'junegunn/fzf',
    'junegunn/fzf.vim',
    'nvim-telescope/telescope-fzf-native.nvim',
    'nvim-telescope/telescope-rg.nvim',
    'nvim-telescope/telescope-frecency.nvim',
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

    'rebelot/kanagawa.nvim',
    'ellisonleao/gruvbox.nvim',
    'sam4llis/nvim-tundra'
})

vim.cmd('colorscheme gruvbox')



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
local noremapsilent = { noremap = true, silent = true }
local wk = require("which-key")


-- Save and exit
vim.keymap.set('n', '<Leader>w', ':w<CR>', noremap)
vim.keymap.set('n', '<Leader>q', ':q<CR>', noremap)
vim.keymap.set('n', '<Leader>qa', ':qa<CR>', noremap)

-- To turn off highlighting until the next search
vim.keymap.set('n', '<Leader>/', ':nohlsearch<CR>', noremapsilent)

-- Move cursor when insert mode
vim.keymap.set('i', "<C-a>", "<Home>", noremap)
vim.keymap.set('i', "<C-e>", "<End>", noremap)
vim.keymap.set('i', "<C-b>", "<Left>", noremap)
vim.keymap.set('i', "<C-f>", "<Right>", noremap)

-- map("n", "<C-j>", "<C-w>j<C-w>")
-- map("n", "<C-h>", "<C-w>h<C-w>")
-- map("n", "<C-k>", "<C-w>k<C-w>")
-- map("n", "<C-l>", "<C-w>l<C-w>")

-- vim.keymap.set('n', '<Leader>bp', ':bprevious<CR>', noremap)
-- vim.keymap.set('n', '<Leader>bn', ':bnext<CR>', noremap)
-- vim.keymap.set('n', '<Leader>bf', ':bfirst<CR>', noremap)
-- vim.keymap.set('n', '<Leader>bl', ':blast<CR>', noremap)
-- vim.keymap.set('n', '<Leader>bd', ':bdelete<CR>', noremap)

-- Clipboard
vim.keymap.set('v', '<Leader>y', '"+y', noremap)
vim.keymap.set('n', '<Leader>Y', '"+yg_', noremap)
vim.keymap.set('n', '<Leader>y', '"+y', noremap)
vim.keymap.set('n', '<Leader>yy', '"+yy', noremap)

vim.keymap.set('n', '<Leader>p', '"+p', noremap)
vim.keymap.set('n', '<Leader>P', '"+P', noremap)
vim.keymap.set('v', '<Leader>p', '"+p', noremap)
vim.keymap.set('v', '<Leader>P', '"+P', noremap)

-- Nvimtree
wk.register({
    n = {
        name = "file tree",
        t = { "<cmd>NvimTreeToggle<CR>", "Toggle file tree" },
        c = { "<cmd>NvimTreeFocus<CR>", "Focus current buffer in file tree" },
        f = { "<cmd>NvimTreeFindFile<CR>", "Move cursor for current buffer" },
    },
}, { prefix = "<Leader>" })

-- Telescope
wk.register({
    ["<Leader>f"] = {
        name = "+telescope",
        f = { function() require('telescope.builtin').find_files({ follow = true }) end, "List files" },
        c = { require('telescope.builtin').current_buffer_fuzzy_find, "Find in current file" },
        b = { require('telescope.builtin').buffers, "List buffers" },
        g = { require('telescope').extensions.live_grep_args.live_grep_args, "Find in project" },
        v = { require('telescope.builtin').registers, "List registers" },
        m = { require('telescope.builtin').marks, "List marks" },
        t = { require('telescope.builtin').colorscheme, "List colorscheme" },
    }
})

-- Dap
vim.keymap.set('n', '<Leader>bb', require('dap').toggle_breakpoint, noremap)
vim.keymap.set('n', '<Leader>bn', require('dap').continue, noremap)
vim.keymap.set('n', '<Leader>bs', require('dap').step_over, noremap)
vim.keymap.set('n', '<Leader>bi', require('dap').step_into, noremap)
vim.keymap.set('n', '<Leader>bo', require('dap').step_out, noremap)

-- Dap UI
vim.keymap.set('n', '<Leader>bus', require("dapui").close, noremap)
vim.keymap.set('n', '<Leader>buo', require("dapui").open, noremap)

-- Lsp
vim.keymap.set('n', '<Leader>lr', '<cmd>LspRestart<CR>', noremapsilent)

vim.keymap.set('n', "gh", "<cmd>Lspsaga finder<CR>", noremapsilent)
vim.keymap.set('n', 'gD', "<cmd>Lspsaga peek_definition<CR>", noremapsilent)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, noremapsilent)
vim.keymap.set('n', "K", "<cmd>Lspsaga hover_doc<CR>", noremapsilent)
vim.keymap.set('n', 'gi', require('telescope.builtin').lsp_implementations, noremapsilent)
vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, noremapsilent)

vim.keymap.set({ 'n', 'v' }, '<Leader>ca', "<cmd>Lspsaga code_action<CR>", noremapsilent)
vim.keymap.set('n', "gr", "<cmd>Lspsaga rename<CR>", noremapsilent)

vim.keymap.set('n', '<Leader>fd', '<cmd>lua vim.lsp.buf.formatting()<CR>', noremapsilent)

vim.keymap.set('n', '<Leader>e', vim.diagnostic.open_float, noremapsilent)
vim.keymap.set('n', '[d', "<cmd>Lspsaga diagnostic_jump_prev<CR>", noremapsilent)
vim.keymap.set('n', ']d', "<cmd>Lspsaga diagnostic_jump_next<CR>", noremapsilent)
vim.keymap.set('n', '[e', function()
    require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, noremapsilent)
vim.keymap.set('n', ']e', function()
    require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
end, noremapsilent)

-- ToggleTerm
vim.keymap.set('n', '<Leader>t', ':ToggleTerm<CR>', noremap)

function _G.set_terminal_keymaps()
    local opts = { buffer = 0 }
    vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
    vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

vim.api.nvim_set_keymap("n", "<leader>ta", ":$tabnew<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>tc", ":tabclose<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>to", ":tabonly<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>tn", ":tabn<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>tp", ":tabp<CR>", { noremap = true })
-- move current tab to previous position
vim.api.nvim_set_keymap("n", "<leader>tmp", ":-tabmove<CR>", { noremap = true })
-- move current tab to next position
vim.api.nvim_set_keymap("n", "<leader>tmn", ":+tabmove<CR>", { noremap = true })


vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>",
    { silent = true, noremap = true }
)
vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",
    { silent = true, noremap = true }
)
