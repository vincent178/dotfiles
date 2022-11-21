-- use vim.keymap.set instead of vim.api.nvim_set_keymap, check more in https://github.com/neovim/neovim/commit/6d41f65aa45f10a93ad476db01413abaac21f27d

local noremap = { noremap = true }
local noremapsilent = { noremap = true, silent = true }

-- Save and exit
vim.keymap.set('n', '<Leader>w', ':w<CR>', noremap)
vim.keymap.set('n', '<Leader>q', ':q<CR>', noremap)
vim.keymap.set('n', '<Leader>qa', ':qa<CR>', noremap)

-- To turn off highlighting until the next search
vim.keymap.set('n', '<Leader>/', ':nohlsearch<CR>', noremapsilent)

-- Move cursor when insert mode
vim.keymap.set('i', "<C-A>", "<Home>", noremap)
vim.keymap.set('i', "<C-E>", "<End>", noremap)
vim.keymap.set('i', "<C-B>", "<Left>", noremap)
vim.keymap.set('i', "<C-F>", "<Right>", noremap)

-- map("n", "<C-j>", "<C-w>j<C-w>")
-- map("n", "<C-h>", "<C-w>h<C-w>")
-- map("n", "<C-k>", "<C-w>k<C-w>")
-- map("n", "<C-l>", "<C-w>l<C-w>")

vim.keymap.set('n', '<Leader>bp', ':bprevious<CR>', noremap)
vim.keymap.set('n', '<Leader>bn', ':bnext<CR>', noremap)
vim.keymap.set('n', '<Leader>bf', ':bfirst<CR>', noremap)
vim.keymap.set('n', '<Leader>bl', ':blast<CR>', noremap)
vim.keymap.set('n', '<Leader>bd', ':bdelete<CR>', noremap)

-- Clipboard
vim.keymap.set('v', '<Leader>y', '"+y', noremap)
vim.keymap.set('n', '<Leader>Y', '"+yg_', noremap)
vim.keymap.set('n', '<Leader>y', '"+y', noremap)
vim.keymap.set('n', '<Leader>yy', '"+yy', noremap)

vim.keymap.set('n', '<Leader>p', '"+p', noremap)
vim.keymap.set('n', '<Leader>P', '"+P', noremap)
vim.keymap.set('v', '<Leader>p', '"+p', noremap)
vim.keymap.set('v', '<Leader>P', '"+P', noremap)

-- Telescope
vim.keymap.set('n', '<Leader>ff', require('telescope.builtin').find_files, noremap)
vim.keymap.set("n", "<Leader>fg", require('telescope').extensions.live_grep_args.live_grep_args, noremap)
vim.keymap.set("n", "<Leader>fb", require('telescope.builtin').buffers, noremap)
vim.keymap.set("n", "<Leader>fh", require('telescope.builtin').help_tags, noremap)
vim.keymap.set("n", "<Leader>fp", require('telescope.builtin').pickers, noremap)
vim.keymap.set("n", "<Leader>fr", require('telescope.builtin').resume, noremap)

-- ToggleTerm
vim.keymap.set('n', '<Leader>t', ':ToggleTerm<CR>', noremap)

-- Dap
vim.keymap.set('n', '<Leader>db', require 'dap'.toggle_breakpoint, noremap)
vim.keymap.set('n', '<Leader>dn', require 'dap'.continue, noremap)
vim.keymap.set('n', '<Leader>ds', require 'dap'.step_over, noremap)
vim.keymap.set('n', '<Leader>di', require 'dap'.step_into, noremap)
vim.keymap.set('n', '<Leader>do', require 'dap'.step_out, noremap)

vim.keymap.set('n', '<Leader>lr', '<cmd>LspRestart<CR>', noremapsilent)

vim.keymap.set('n', 'gd', vim.lsp.buf.definition, noremapsilent)
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, noremapsilent)
vim.keymap.set('n', 'K', vim.lsp.buf.hover, noremapsilent)
vim.keymap.set('n', 'gi', require('telescope.builtin').lsp_implementations, noremapsilent)
vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, noremapsilent)

vim.keymap.set('n', '<Leader>ca', vim.lsp.buf.code_action, noremapsilent)

vim.keymap.set('n', '<Leader>fd', '<cmd>lua vim.lsp.buf.formatting()<CR>', noremapsilent)
vim.keymap.set('n', 'rn', '<cmd>lua vim.lsp.buf.rename()<CR>', noremapsilent)

vim.keymap.set('n', '<Leader>e', vim.diagnostic.open_float, noremapsilent)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, noremapsilent)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, noremapsilent)
