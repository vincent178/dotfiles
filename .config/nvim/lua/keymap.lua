-- use vim.keymap.set instead of vim.api.nvim_set_keymap, check more in https://github.com/neovim/neovim/commit/6d41f65aa45f10a93ad476db01413abaac21f27d

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
        f = { require('telescope.builtin').find_files, "List files" },
        b = { require('telescope.builtin').buffers, "List buffers" },
        g = { require('telescope').extensions.live_grep_args.live_grep_args, "Search string" },
        v = { require('telescope.builtin').registers, "List registers" },
        m = { require('telescope.builtin').marks, "List marks" },
        t = { require('telescope.builtin').colorscheme, "List colorscheme" },
    }
})
-- vim.keymap.set('n', '<Leader>ff', require('telescope.builtin').find_files, noremap)
-- vim.keymap.set("n", "<Leader>fg", require('telescope').extensions.live_grep_args.live_grep_args, noremap)
-- vim.keymap.set("n", "<Leader>fb", require('telescope.builtin').buffers, noremap)
-- vim.keymap.set("n", "<Leader>fh", require('telescope.builtin').help_tags, noremap)
-- vim.keymap.set("n", "<Leader>fp", require('telescope.builtin').pickers, noremap)
-- vim.keymap.set("n", "<Leader>fr", require('telescope.builtin').resume, noremap)
-- vim.keymap.set("n", "<Leader>fv", require('telescope.builtin').registers, noremap)

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

vim.keymap.set('n', "gh", "<cmd>Lspsaga lsp_finder<CR>", noremapsilent)
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
    require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, noremapsilent)
vim.keymap.set('n', ']e', function()
    require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
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
