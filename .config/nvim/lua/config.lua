vim.opt.autoindent = true 
vim.opt.autoread = true   
vim.opt.cursorline = true
vim.opt.hidden = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ruler = true
vim.opt.showcmd = true
vim.opt.showmode = false  
vim.opt.swapfile = false

-- LSP CONFIG

local lsp_servers = { "rust_analyzer", "gopls", "sumneko_lua", "pyright", "jsonls" }
local all_packages = { "codelldb" }

-- merge lsp_servers to all_packages
for _, s in ipairs(lsp_servers) do
  table.insert(all_packages, s)
end

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = all_packages
})

local on_attach = function(client, bufnr)
    local opts = { noremap=true, silent=true, buffer=bufnr }

    vim.keymap.set('n', '<Leader>lr', '<cmd>LspRestart<CR>', opts)

    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', require('telescope.builtin').lsp_implementations, opts)
    vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, opts)

    vim.keymap.set('n', '<Leader>ca', vim.lsp.buf.code_action, opts)

    vim.keymap.set('n', '<Leader>fd', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    vim.keymap.set('n', 'rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)

    vim.keymap.set('n', '<Leader>e', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

    -- Auto Formatting
    if client.resolved_capabilities.document_formatting then
        -- vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync]]
    end
end

for _, lsp in ipairs(lsp_servers) do
    require('lspconfig')[lsp].setup { on_attach = on_attach }
end

-- TREESITTER CONFIG

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.org = {
  install_info = {
    url = 'https://github.com/milisims/tree-sitter-org',
    revision = 'main',
    files = {'src/parser.c', 'src/scanner.cc'},
  },
  filetype = 'org',
}

require'nvim-treesitter.configs'.setup {
  -- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
  highlight = {
    enable = true,
    disable = {'org'}, -- Remove this to use TS highlighter for some of the highlights (Experimental)
    additional_vim_regex_highlighting = {'org'}, -- Required since TS highlighter doesn't support all syntax features (conceal)
  },
  ensure_installed = {'org'}, -- Or run :TSUpdate org
}

local cmp = require('cmp')

cmp.setup({
  mapping = cmp.mapping.preset.insert({
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = {
    { name = 'path' },                              -- file paths
    { name = 'nvim_lsp' },      -- from language server
    { name = 'nvim_lsp_signature_help'},            -- display function signatures with current parameter emphasized
    { name = 'nvim_lua', keyword_length = 2},       -- complete neovim's Lua runtime API such vim.lsp.*
    { name = 'buffer', keyword_length = 2 },        -- source current buffer
    { name = 'vsnip', keyword_length = 2 },         -- nvim-cmp source for vim-vsnip 
    { name = 'calc'},                               -- source for math calculation
  },
  window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
  },
  formatting = {
      fields = {'menu', 'abbr', 'kind'},
      format = function(entry, item)
          local menu_icon ={
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

require('orgmode').setup({
    org_todo_keywords = {'TODO(t)',  'PROGRESS(p)', '|', 'DONE(d)'},
    org_agenda_files = {'~/Org/*'},
    org_default_notes_file = '~/Org/inbox.org',
    mappings = {
        capture = {
        }
    }
})
require('orgmode').setup_ts_grammar()

require("toggleterm").setup{
    shell = "/bin/zsh --login" -- change the default shell
}

require('nvim-web-devicons').setup{}

-- require('lualine').setup{options = {theme = 'ayu_mirage'}}
-- require('evil_lualine')

local dap = require('dap')
dap.adapters.go = function(callback, config)
    local stdout = vim.loop.new_pipe(false)
    local stderr = vim.loop.new_pipe(false)
    local handle
    local pid_or_err
    local port = 38697
    local opts = {
      stdio = {nil, stdout, stderr},
      args = {"dap", "-l", "127.0.0.1:" .. port},
      detached = true
    }
    handle, pid_or_err = vim.loop.spawn("dlv", opts, function(code)
      stdout:close()
      stderr:close()
      handle:close()
      if code ~= 0 then
        print('dlv exited with code', code)
      end
    end)
    assert(handle, 'Error running dlv: ' .. tostring(pid_or_err))
    stdout:read_start(function(err, chunk)
      assert(not err, err)
      if chunk then
        vim.schedule(function()
          require('dap.repl').append(chunk)
        end)
      end
    end)
    stderr:read_start(function(err, chunk)
      assert(not err, err)
      if chunk then
        vim.schedule(function()
          require('dap.repl').append(chunk)
        end)
      end
    end)
    -- Wait for delve to start
    vim.defer_fn(
      function()
        callback({type = "server", host = "127.0.0.1", port = port})
      end,
    100)
end
-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
dap.configurations.go = {
    {
      type = "go",
      name = "Debug",
      request = "launch",
      program = "${file}"
    },
    {
      type = "go",
      name = "Debug test", -- configuration for debugging test files
      request = "launch",
      mode = "test",
      program = "${file}"
    },
    -- works with go.mod packages and sub packages 
    {
      type = "go",
      name = "Debug test (go.mod)",
      request = "launch",
      mode = "test",
      program = "./${relativeFileDirname}"
    } 
}
require('dap.ext.vscode').load_launchjs(vim.fn.getcwd() .. '/.dap.json')

require('dapui').setup()

require('gitsigns').setup()

require('telescope').setup({
  defaults = {
    cache_picker = {
      num_pickers = -1,
    }
  },
})

require('telescope').load_extension('fzf')
require('telescope').load_extension('live_grep_args')

-- require('rust-tools').setup()

-- LSP Diagnostics Options Setup 
local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
end

sign({name = 'DiagnosticSignError', text = ''})
sign({name = 'DiagnosticSignWarn', text = ''})
sign({name = 'DiagnosticSignHint', text = ''})
sign({name = 'DiagnosticSignInfo', text = ''})

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    update_in_insert = true,
    underline = false,
    severity_sort = false,
    float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
})

vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

