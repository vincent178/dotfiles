local Plug = vim.fn['plug#']

vim.call('plug#begin')

Plug('nvim-lua/plenary.nvim')
Plug('tpope/vim-surround')
Plug('christoomey/vim-tmux-navigator')
Plug('djoshea/vim-autoread')
Plug('wakatime/vim-wakatime')
Plug('jiangmiao/auto-pairs')
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
Plug('nvim-treesitter/nvim-treesitter-textobjects')
Plug('preservim/nerdtree')
Plug('numToStr/Comment.nvim')
Plug('stevearc/oil.nvim')
Plug('dhruvasagar/vim-table-mode')

-- theme
Plug('ellisonleao/gruvbox.nvim')

-- lsp
Plug('williamboman/mason.nvim')
Plug('williamboman/mason-lspconfig.nvim')
Plug('neovim/nvim-lspconfig')

-- autocomplete
Plug('hrsh7th/nvim-cmp')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-buffer')
Plug('Exafunction/codeium.vim')

-- git
Plug('tpope/vim-fugitive')
Plug('vincent178/nvim-github-linker')

-- fuzzy finder
Plug('ibhagwan/fzf-lua', { ['branch'] = 'main' })

vim.call('plug#end')

vim.g.mapleader          = " "

vim.opt.background       = "dark" -- or "light" for light mode
vim.opt.swapfile         = false  -- boolean: use a swapfile for the buffer
vim.opt.mouse            = 'a'    -- string, global: Enable mouse support, 'a' for all previous modes
vim.opt.number           = true   -- boolean: show line numbers
vim.opt.relativenumber   = true   -- boolean: show relative line numbers
vim.opt.signcolumn       = "yes"  -- string: show the sign column

-- Encoding
vim.opt.encoding         = 'utf8' -- string: string encoding to use
vim.opt.fileencoding     = 'utf8' -- string: file encoding to use

-- Search
vim.opt.incsearch        = true   -- boolean
vim.opt.hlsearch         = true   -- boolean
vim.opt.smartcase        = true   -- boolean: override the 'ignorecase' option if the search pattern contains upper case characters.
vim.opt.ignorecase       = true   -- boolean: ignore case in search patterns

-- Tab and Space
vim.opt.expandtab        = true   -- boolean: use Leaders instead of tabs
vim.opt.shiftwidth       = 4      -- number:  size of an indent
vim.opt.softtabstop      = 4      -- number:  number of Leaders tabs count for in insert mode
vim.opt.tabstop          = 4      -- number:  number of Leaders tabs count for

-- Splits
vim.opt.splitright       = true   -- boolean: place new window to right of current one
vim.opt.splitbelow       = true   -- boolean: place new window below the current one

vim.opt.jumpoptions      = 'stack'

vim.cmd('colorscheme gruvbox')

-- clear sign column highlights so that sign column is the same color as where your line numbers show up
-- https://stackoverflow.com/questions/15277241/changing-vim-gutter-color
vim.cmd('highlight clear SignColumn')

-- remove ':' from the characters list considered being possibly part of a file name and path name
-- https://stackoverflow.com/questions/36500099/vim-gf-should-open-file-and-jump-to-line
vim.cmd('set isfname-=:')

vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight_yank', {}),
  desc = 'Hightlight selection on yank',
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = 500 }
  end,
})

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    update_in_insert = true,
    underline = false,
    severity_sort = true,
    float = false,
})

require('nvim-treesitter.configs').setup({
    ensure_installed = {"c", "cpp", "go", "lua", "rust", "python", "typescript", "javascript", "ruby", "markdown", "markdown_inline"},
    highlight = {
        enable = true,
    },
    indent = {
        enable = true,
    },
    incremental_selection = {
        enable = true,
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
            },
        },
    }
})

require("oil").setup({
    keymaps = {
        ["<C-s>"] = { "actions.select", opts = { vertical = false, horizontal = true } },
        ["<C-v>"] = { "actions.select", opts = { vertical = true, horizontal = false } },
        ["<C-l>"] = false, 
        ["<C-h>"] = false, 
    },
})

require('mason').setup({})
require("mason-lspconfig").setup({
    ensure_installed = {"rust_analyzer", "gopls", "pyright", "ts_ls", "ruby_lsp", "clangd", "jsonls"},
    handlers = {
        function (server_name)
            require("lspconfig")[server_name].setup({})
        end,
    },
})

local cmp = require('cmp')
cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'buffer', keyword_length = 2 },
    })
})

require('fzf-lua').setup({
  keymap = {
    fzf = {
      ["ctrl-q"] = "select-all+accept",
    }
  },
})

require('Comment').setup({
    ignore = '^$',
})

require("nvim-github-linker").setup()

-- keymaps
vim.keymap.set('i', '<C-a>', '<Home>')
vim.keymap.set('i', '<C-e>', '<End>')
vim.keymap.set('i', '<C-b>', '<Left>')
vim.keymap.set('i', '<C-f>', '<Right>')
vim.keymap.set('c', '<C-a>', '<Home>')
vim.keymap.set('c', '<C-b>', '<Left>')
vim.keymap.set('c', '<C-f>', '<Right>')
vim.keymap.set('n', '<Leader>n', '<cmd>NERDTreeToggle<CR>')
vim.keymap.set('n', '<Leader>g', require('fzf-lua').live_grep_glob)
vim.keymap.set('n', '<Leader>f', require('fzf-lua').files)
vim.keymap.set('n', '<Leader>b', require('fzf-lua').buffers)
vim.keymap.set('n', '<Leader>o', '<cmd>Oil<CR>')
vim.keymap.set('n', '<CR>', '<cmd>noh<CR><CR>')
vim.keymap.set('n', '[q', '<cmd>cprevious<CR>')
vim.keymap.set('n', ']q', '<cmd>cnext<CR>')
vim.keymap.set('n', '<c-]>', 'g<c-]>')
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '[e', function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end)
vim.keymap.set('n', ']e', function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end)
vim.keymap.set('n', '<Leader>l', vim.diagnostic.setloclist)
 
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<Leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set({ 'n', 'v' }, '<Leader>=', function() vim.lsp.buf.format { async = true } end, opts)
  end,
})
