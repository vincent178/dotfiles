local function plug(repo) return 'https://github.com/' .. repo end

-- Run a plugin's build step after install/update. Registered BEFORE
-- vim.pack.add() so it also fires for installs served from the lockfile.
-- The plugin isn't loaded yet when this fires mid-install, so packadd it
-- first (per :h vim.pack-events) before invoking its command.
vim.api.nvim_create_autocmd('PackChanged', {
  group = vim.api.nvim_create_augroup('pack_hooks', {}),
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'nvim-treesitter' and (kind == 'install' or kind == 'update') then
      if not ev.data.active then
        vim.cmd.packadd('nvim-treesitter')
      end
      -- treesitter parsers are built via :TSUpdate (was vim-plug's `do`)
      vim.cmd('TSUpdate')
    end
  end,
})

-- load = true is required when calling add() from init.lua: without it
-- plugin/*.vim files are NOT sourced (only rtp is set), so vim-script
-- plugins (surround, fugitive, NERDTree, table-mode, auto-pairs, autoread,
-- tmux-navigator) and the gruvbox colorscheme would silently define no
-- commands/mappings.
vim.pack.add({
  plug('nvim-lua/plenary.nvim'),
  plug('tpope/vim-surround'),
  plug('christoomey/vim-tmux-navigator'),
  plug('jiangmiao/auto-pairs'),
  { src = plug('nvim-treesitter/nvim-treesitter'), version = 'main' },
  plug('nvim-treesitter/nvim-treesitter-textobjects'),
  plug('preservim/nerdtree'),
  plug('numToStr/Comment.nvim'),
  plug('stevearc/oil.nvim'),
  plug('dhruvasagar/vim-table-mode'),
  plug('stevearc/dressing.nvim'),
  plug('MunifTanjim/nui.nvim'),
  plug('HakonHarnes/img-clip.nvim'),
  plug('folke/which-key.nvim'),

  -- theme
  plug('ellisonleao/gruvbox.nvim'),

  -- lsp
  plug('williamboman/mason.nvim'),
  plug('williamboman/mason-lspconfig.nvim'),
  plug('neovim/nvim-lspconfig'),

  -- autocomplete
  plug('hrsh7th/nvim-cmp'),
  plug('hrsh7th/cmp-nvim-lsp'),
  plug('hrsh7th/cmp-buffer'),

  -- git
  plug('tpope/vim-fugitive'),

  -- context menu (LSP actions + copy path/remote url)
  plug('vincent178/nvim-menu'),

  -- fuzzy finder
  { src = plug('ibhagwan/fzf-lua'), version = 'main' },
}, { load = true })

vim.g.mapleader          = " "

vim.opt.background       = "dark"        -- or "light" for light mode
vim.opt.swapfile         = false         -- boolean: use a swapfile for the buffer
vim.opt.mouse            = 'a'           -- string, global: Enable mouse support, 'a' for all previous modes
vim.opt.number           = true          -- boolean: show line numbers
vim.opt.relativenumber   = true          -- boolean: show relative line numbers
vim.opt.signcolumn       = "yes"         -- string: show the sign column
vim.opt.timeoutlen       = 300           -- number: max ms to wait for a mapped key sequence to complete
vim.opt.clipboard        = "unnamedplus" -- string: yank/paste to system clipboard (+ register)

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

-- Auto-reload buffers changed externally (e.g. by Claude Code). vim's built-in
-- 'autoread' only fires on a few events and misses terminal/tmux sessions, so
-- force a :checktime on the events most likely to catch the change.
vim.opt.autoread = true
vim.api.nvim_create_autocmd(
  { 'FocusGained', 'BufEnter', 'WinEnter', 'CursorHold', 'CursorHoldI' },
  { group = vim.api.nvim_create_augroup('auto_read', {}), pattern = '*', command = 'checktime' }
)
-- In tmux, FocusGained only fires if `set -g focus-events on` is set, so keep
-- CursorHold as the reliable fallback (fires after 'updatetime' of inactivity).
vim.opt.updatetime = 250

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

-- nvim-treesitter (main branch): parsers + queries only. Highlight/indent are
-- enabled per-buffer via FileType, the supported modern pattern (:h nvim-treesitter).
-- The legacy nvim-treesitter.configs module was removed on `main`; ensure_installed
-- is replaced by an explicit install() call.
local ts_parsers = {
    "c", "cpp", "go", "lua", "rust", "python", "typescript", "javascript",
    "ruby", "markdown", "markdown_inline",
}

require('nvim-treesitter').setup({
    install_dir = vim.fn.stdpath('data') .. '/site',
})

-- Install any missing parsers (async; no-op when already installed).
require('nvim-treesitter.install').install(ts_parsers)

-- Enable treesitter highlight + indent for buffers whose language has a parser.
vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('treesitter_start', {}),
    callback = function(args)
        local lang = vim.treesitter.language.get_lang(args.match) or vim.bo[args.buf].filetype
        if pcall(vim.treesitter.start, args.buf, lang) and vim.bo[args.buf].filetype ~= '' then
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
    end,
})

-- nvim-treesitter-textobjects: select keymaps bound explicitly via its public
-- select_textobject() (the legacy configs.select.keymaps table is gone on `main`).
require('nvim-treesitter-textobjects').setup({
    select = { lookahead = true },
    move = { set_jumps = true },
})
local ts_select = require('nvim-treesitter-textobjects.select').select_textobject
vim.keymap.set({ 'x', 'o' }, 'af', function() ts_select('@function.outer') end)
vim.keymap.set({ 'x', 'o' }, 'if', function() ts_select('@function.inner') end)
vim.keymap.set({ 'x', 'o' }, 'ac', function() ts_select('@class.outer') end)
vim.keymap.set({ 'x', 'o' }, 'ic', function() ts_select('@class.inner') end)

require("oil").setup({
    keymaps = {
        ["<C-s>"] = { "actions.select", opts = { vertical = false, horizontal = true } },
        ["<C-v>"] = { "actions.select", opts = { vertical = true, horizontal = false } },
        ["<C-l>"] = false, 
        ["<C-h>"] = false, 
    },
})

require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = {"rust_analyzer", "gopls", "pyright", "ts_ls", "ruby_lsp", "clangd", "jsonls"},
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

-- nvim-menu: VSCode-style context menu (:NvimMenu). nui.nvim (above) is its
-- only dependency. No default keymap; bind your own, e.g. <Leader>m.
require('nvim-menu').setup()

-- keymaps
vim.keymap.set('i', '<C-a>', '<Home>')
vim.keymap.set('i', '<C-e>', '<End>')
vim.keymap.set('i', '<C-b>', '<Left>')
vim.keymap.set('i', '<C-f>', '<Right>')
vim.keymap.set('c', '<C-a>', '<Home>')
vim.keymap.set('c', '<C-b>', '<Left>')
vim.keymap.set('c', '<C-f>', '<Right>')
vim.keymap.set('n', '<Leader>n', '<cmd>NERDTreeToggle<CR>')
vim.keymap.set('n', '<Leader>g', require('fzf-lua').live_grep)
-- Pick a directory via fzf-lua (fd -t d), then live_grep inside it.
-- First entry is always '.' (cwd), so Enter immediately greps the current
-- directory; pick any other entry to narrow the scope.
vim.keymap.set('n', '<Leader>/', function()
  local cwd = vim.fn.getcwd()
  require('fzf-lua').files({
    prompt = 'Grep in dir> ',
    cwd = cwd,
    -- prepend '.' so the default selection (first line) == current directory;
    -- fd output is relative, so a leading '.' means "cwd" verbatim.
    cmd = 'echo . && fd -t d --follow',
    hidden = false,
    file_icons = false,
    git_icons = false,
    fzf_opts = { ['--info'] = 'inline' },
    actions = {
      ['default'] = function(selected)
        local dir = selected[1]
        if not dir or #dir == 0 then return end
        dir = dir == '.' and cwd or vim.fs.joinpath(cwd, dir)
        require('fzf-lua').live_grep({ cwd = dir })
      end,
    },
  })
end)
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
vim.keymap.set({ 'n', 'v' }, '<Leader>m', '<cmd>NvimMenu<CR>', { desc = 'Context menu' })

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
