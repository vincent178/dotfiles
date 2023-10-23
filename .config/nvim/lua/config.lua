require('nvim-github-linker').setup()

-- Util function
local sign = function(opts)
    vim.fn.sign_define(opts.name, {
        texthl = opts.name,
        text = opts.text,
        numhl = ''
    })
end

-- Mason
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "rust_analyzer", "gopls", "lua_ls", "pyright", "jsonls", "tsserver", "ruby_ls" } -- Manage language server dependencies
})

-- UI for language server progress
require("fidget").setup({})

-- Default LSP config list
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

-- Custom Rust LSP config and more, see more: https://github.com/simrat39/rust-tools.nvim
local extension_path = vim.env.HOME .. '/.local/share/nvim/mason/packages/codelldb/extension/'
local codelldb_path = extension_path .. 'adapter/codelldb'
local liblldb_path = extension_path .. 'lldb/lib/liblldb.dylib'

local rt = require("rust-tools")

rt.setup({
    server = {
        on_attach = function(_, bufnr)
            -- Hover actions
            vim.keymap.set("n", "<Leader>ha", rt.hover_actions.hover_actions, { buffer = bufnr })
            -- Code action groups
            vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
        end,
    },
    dap = {
        adapter = require('rust-tools.dap').get_codelldb_adapter(codelldb_path, liblldb_path)
    }
})

-- Nvim autocomplete
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

-- Terminal
require("toggleterm").setup({
    shell = "/bin/zsh --login" -- change the default shell
})

-- Dap
require('dap-go').setup()

require('dapui').setup({
    icons = { expanded = "▾", collapsed = "▸" },
    controls = {
        enabled = false,
    }
})

-- Use nvim-dap events to open and close the windows automatically
local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open({})
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close({})
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close({})
end

sign({ name = 'DapBreakpoint', text = '●' })
sign({ name = 'DapStopped', text = '➞' })
sign({ name = 'DapBreakpointRejected', text = '⊝' })

-- Trouble
require('trouble').setup({})

-- Telescope
local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")

local telescope = require("telescope")

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

-- LSP diagnostics config
sign({ name = 'DiagnosticSignError', text = '' })
sign({ name = 'DiagnosticSignWarn', text = '' })
sign({ name = 'DiagnosticSignHint', text = '' })
sign({ name = 'DiagnosticSignInfo', text = '' })

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

-- Treesitter
require('nvim-treesitter.configs').setup({
    ensure_installed = { "go", "rust", "ruby", "javascript", "json", "toml" }, -- A list of parser names
    auto_install = true,                                                       -- Automatically install missing parsers when entering buffer
    sync_install = true,                                                       -- Install parsers synchronously (only applied to `ensure_installed`)
    highlight = true
})

require('lspsaga').setup({})
