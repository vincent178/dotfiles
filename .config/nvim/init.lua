-- lazypath = ~/.local/share/nvim/lazy/lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1

require("lazy").setup({
    'nvim-lua/plenary.nvim',
    'christoomey/vim-tmux-navigator',
    'djoshea/vim-autoread',
    'tpope/vim-commentary',
    'jiangmiao/auto-pairs',
    'tpope/vim-surround',
    'akinsho/nvim-toggleterm.lua',
    'tpope/vim-dadbod',
    'kristijanhusak/vim-dadbod-ui',
    {
        'nvim-treesitter/nvim-treesitter',
        cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
        build = ":TSUpdate",
    },
    'nvim-orgmode/orgmode',

    {
         "folke/which-key.nvim",
          event = "VeryLazy",
          init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
          end
    },

    'folke/trouble.nvim',

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

    { 'nvim-tree/nvim-web-devicons', lazy = true },
    
    'wakatime/vim-wakatime',
    'vincent178/nvim-github-linker',
    'Exafunction/codeium.vim',

    'godlygeek/tabular',
    'plasticboy/vim-markdown',
    'sotte/presenting.vim',
    'iamcco/markdown-preview.nvim',
    'ferrine/md-img-paste.vim',

    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',
    'hrsh7th/nvim-cmp',
    'hrsh7th/vim-vsnip',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'nvim-lua/lsp-status.nvim',
    'glepnir/lspsaga.nvim',
    'j-hui/fidget.nvim',
    'leoluz/nvim-dap-go',
    'simrat39/rust-tools.nvim',


    'mfussenegger/nvim-dap',
    'rcarriga/nvim-dap-ui',


    'tpope/vim-fugitive',
    'tpope/vim-rhubarb',
    'lewis6991/gitsigns.nvim',

    'junegunn/fzf',
    'junegunn/fzf.vim',
    'nvim-telescope/telescope.nvim',
    'nvim-telescope/telescope-fzf-native.nvim',
    'nvim-telescope/telescope-rg.nvim',
    'nvim-telescope/telescope-frecency.nvim',
    'nvim-telescope/telescope-live-grep-args.nvim',
    'tami5/sqlite.lua',

    'junegunn/seoul256.vim',
    'mhartington/oceanic-next',
    'ayu-theme/ayu-vim',
    'joshdick/onedark.vim',
    'dracula/vim',

    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = { theme = 'gruvbox' }
    },
 
    'rebelot/kanagawa.nvim',
    'ellisonleao/gruvbox.nvim',
    'sam4llis/nvim-tundra'
})

require('config') -- LSP / Treesitter
require('keymap')

-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

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


-- Auto Format
-- cmd([[
-- autocmd BufWritePre * lua vim.lsp.buf.format()
-- ]])

-- Theme/UI
-- require('kanagawa').setup({
-- 	keywordStyle = { italic = false, bold = true },
-- })
-- cmd("colorscheme kanagawa")

-- set termguicolors
vim.opt.background = 'dark'
vim.cmd('colorscheme gruvbox')

-- clear sign column highlights, see more: https://stackoverflow.com/questions/15277241/changing-vim-gutter-color
vim.cmd([[
highlight clear SignColumn
]])

vim.cmd([[
highlight DapBreakpoint guifg=#DC3535
highlight DapStopped guifg=#F49D1A
highlight DapBreakpointRejected guifg=#B2B2B2
]])

-- require('lualine').setup { options = { theme = 'gruvbox' } }

require('gitsigns').setup()


-- require("nvim-tree").setup({
--     git = {
--         enable = false
--     },
--     diagnostics = {
--         enable = false
--     },
-- })
