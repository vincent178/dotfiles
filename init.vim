call plug#begin('~/.vim/autoload/plugged')

" tmux requires additional setup: https://github.com/christoomey/vim-tmux-navigator
Plug 'christoomey/vim-tmux-navigator'
Plug 'djoshea/vim-autoread'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'akinsho/nvim-toggleterm.lua'
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

" LSP and other IDE like plugins
Plug 'neovim/nvim-lspconfig'
Plug 'liuchengxu/vista.vim'
Plug 'hrsh7th/nvim-compe'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'buoto/gotests-vim'
Plug 'hrsh7th/vim-vsnip'
Plug 'cespare/vim-toml'

" Dap
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'

" Project tree
Plug 'scrooloose/nerdtree'

" Git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

" Fuzzy finder
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" Colortheme
Plug 'junegunn/seoul256.vim'
Plug 'mhartington/oceanic-next'
Plug 'morhetz/gruvbox'
Plug 'ayu-theme/ayu-vim'
Plug 'joshdick/onedark.vim'
Plug 'dracula/vim'
Plug 'hoob3rt/lualine.nvim'
" require font setting in iterm2
Plug 'kyazdani42/nvim-web-devicons' 

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let mapleader=","

" lang en_US.UTF-8

set nocompatible
set autoindent
set expandtab
set showmode
set showcmd
set ruler
set hidden
set noswapfile
set incsearch
set hlsearch
set encoding=utf-8
set termencoding=utf-8
set mouse=a
set cursorline
set number
set ignorecase

set completeopt=menuone,noselect,preview

" Load plugins according to detected filetype
filetype plugin indent on  
syntax enable

set termguicolors
let ayucolor="mirage" " for mirage version of theme
colorscheme ayu


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Key mapping
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" move entire line in visual mode 
xnoremap K :move '<-2<CR>gv-gv
xnoremap J :move '>+1<CR>gv-gv

" nnoremap <Up> :resize +2<CR>
" nnoremap <Down> :resize -2<CR>
" nnoremap <Left> :vertical resize +2<CR>
" nnoremap <Right> :vertical resize -2<CR>

tnoremap <Esc> <C-\><C-n>
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-l> <C-\><C-n><C-w>l

inoremap <C-A> <Home>
inoremap <C-E> <End>
inoremap <C-B> <Left>
inoremap <C-F> <Right>

nnoremap <Leader>c :let @+=expand('%:p')<CR>
nnoremap <Leader>r :source ~/.config/nvim/init.vim<CR>
vnoremap <Leader>y "+y
nnoremap <Leader>y "+y
nnoremap <Leader>p "+p
nmap <silent> <Leader>/ :silent noh<CR>
nnoremap <Leader>s <C-w>v<C-w>l
nnoremap <Leader>v <C-w>s<C-w>j
noremap <Leader>q :q<cr>
noremap <Leader>w :w<cr>
noremap <Leader>wq :wq<cr>

nnoremap <Leader>ff <cmd>Telescope find_files<cr>
nnoremap <Leader>fg <cmd>Telescope live_grep<cr>
nnoremap <Leader>fb <cmd>Telescope buffers<cr>
nnoremap <Leader>fh <cmd>Telescope help_tags<cr>

nnoremap <silent> <Leader>bb :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <Leader>bn :lua require'dap'.continue()<CR>
nnoremap <silent> <Leader>bs :lua require'dap'.step_over()<CR>
nnoremap <silent> <Leader>bi :lua require'dap'.step_into()<CR>
nnoremap <silent> <Leader>bo :lua require'dap'.step_out()<CR>
nnoremap <silent> <Leader>bu :lua require('dapui').toggle('sidebar')<CR>

nnoremap <Leader>tt <Cmd>1ToggleTerm<CR>
nnoremap <Leader>tf <Cmd>2ToggleTerm direction=float<CR>

" confirm complete with return
" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
" inoremap <silent><expr> <CR> compe#complete()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set shiftwidth=4
set tabstop=4
set softtabstop=4

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Lua Config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

lua << EOF
local nvim_lsp = require('lspconfig')

nvim_lsp.rust_analyzer.setup{}
nvim_lsp.pyright.setup{}
nvim_lsp.gopls.setup{
    flags = {
        debounce_text_changes = 500,
    }
}
nvim_lsp.solargraph.setup{}
nvim_lsp.ccls.setup {
    init_options = {
        compilationDatabaseDirectory = "build";
        index = {
            threads = 0;
        };
        clang = {
            excludeArgs = { "-frounding-math" };
        };
    }
}

-- Use an on_attach function to only map the following keys 
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    --Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap=true, silent=true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua require(\'telescope.builtin\').lsp_references()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua require(\'telescope.builtin\').lsp_implementations()<CR>', opts)

    buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    buf_set_keymap('n', 'rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)

    buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "gopls", "rust_analyzer", "pyright", "solargraph", "ccls" }
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup { on_attach = on_attach }
end

require'compe'.setup{
    enabled = true;
    autocomplete = true;
    debug = false;
    min_length = 1;
    preselect = 'enable';
    throttle_time = 80;
    source_timeout = 200;
    resolve_timeout = 800;
    incomplete_delay = 400;
    max_abbr_width = 100;
    max_kind_width = 100;
    max_menu_width = 100;
    documentation = true;

    source = {
        path = true;
        buffer = true;
        calc = true;
        nvim_lsp = true;
        nvim_lua = true;
        vsnip = true;
        ultisnips = true;
    };
}

require("toggleterm").setup{
    shell = "/bin/zsh --login" -- change the default shell
}

require('nvim-web-devicons').setup{}

require('lualine').setup{options = {theme = 'ayu_mirage'}}

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
EOF

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Function
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin Setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" [vim-markdown]
let g:markdown_fenced_languages = ['go', 'ruby', 'vim']

" [dadbod-ui]
" disable auto execute on save
let g:db_ui_execute_on_save = 0

" [nerdtree] 
" display hidden files
let NERDTreeShowHidden=1
nnoremap <Leader>n :NERDTreeToggle<CR>

" [vim-go]
let g:go_gopls_enabled = 0
let g:go_def_mapping_enabled = 0
let g:go_code_completion_enabled = 0

" [vista] 
" set tag view width
let g:vista_sidebar_width = 48
" disable tag view icon
let g:vista#renderer#enable_icon = 0
" use coc-vim
let g:vista_default_executive = 'nvim_lsp'

" toggle Vista view
nnoremap gv :Vista!!<CR>

" [vim-markdown]
let g:vim_markdown_folding_disabled = 1

" [fzf.vim]
map <C-t> :Files<CR>
map <Leader>f :Rg<Space>

" command! -bang -nargs=? Rg
"     \ call fzf#vim#grep(RgCommand(<f-args>), 1, fzf#vim#with_preview(), <bang>0)

" function! RgCommand(...)
"   " not sure why f-args won't split argument by spaces  
"   " this is a hack implementation
"   return printf("rg --column --line-number --no-heading --color=always --smart-case %s", a:1)
" endfunction

