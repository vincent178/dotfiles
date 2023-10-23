local opt = vim.opt
local cmd = vim.cmd

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

opt.background = "dark"   -- or "light" for light mode

opt.swapfile = false      -- boolean: Use a swapfile for the buffer
opt.mouse = 'a'           -- string, global: Enable mouse support, 'a' for all previous modes
opt.number = true         -- boolean: Show line numbers
opt.relativenumber = true -- boolean: Show relative line numbers
opt.cursorline = true     -- boolean: Highlight the text line of the cursor
opt.signcolumn = "yes"    -- str: Show the sign column

-- Encoding
opt.encoding = 'utf8'     -- str:  String encoding to use
opt.fileencoding = 'utf8' -- str:  File encoding to use

-- Search
opt.incsearch = true  -- boolean
opt.hlsearch = true   -- boolean
opt.smartcase = true  -- boolean: Override the 'ignorecase' option if the search pattern contains upper case characters.
opt.ignorecase = true -- boolean: Ignore case in search patterns

-- Whitespace
opt.expandtab = true -- boolean: Use spaces instead of tabs
opt.shiftwidth = 4   -- num:  Size of an indent
opt.softtabstop = 4  -- num:  Number of spaces tabs count for in insert mode
opt.tabstop = 4      -- num:  Number of spaces tabs count for

-- Splits
opt.splitright = true -- boolean: Place new window to right of current one
opt.splitbelow = true -- boolean: Place new window below the current one


-- Auto Format
cmd([[
autocmd BufWritePre * lua vim.lsp.buf.format()
]])

-- Theme/UI
-- require('kanagawa').setup({
-- 	keywordStyle = { italic = false, bold = true },
-- })
-- cmd("colorscheme kanagawa")

-- set termguicolors
opt.background = 'dark'
cmd('colorscheme gruvbox')

-- clear sign column highlights, see more: https://stackoverflow.com/questions/15277241/changing-vim-gutter-color
cmd([[
highlight clear SignColumn
]])

cmd([[
highlight DapBreakpoint guifg=#DC3535
highlight DapStopped guifg=#F49D1A
highlight DapBreakpointRejected guifg=#B2B2B2
]])

require('lualine').setup { options = { theme = 'gruvbox' } }

require('gitsigns').setup()

require('nvim-web-devicons').setup({})

require("nvim-tree").setup({
    git = {
        enable = false
    },
    diagnostics = {
        enable = false
    },
})
