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
Plug 'nvim-orgmode/orgmode'
Plug 'folke/which-key.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'kevinhwang91/promise-async'
Plug 'kevinhwang91/nvim-ufo'
Plug 'Joakker/lua-json5'

" Markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'sotte/presenting.vim' 
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'ferrine/md-img-paste.vim'

" LSP and other IDE like plugins
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'liuchengxu/vista.vim'
Plug 'buoto/gotests-vim'
Plug 'hrsh7th/vim-vsnip'
Plug 'cespare/vim-toml'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'simrat39/rust-tools.nvim'
Plug 'nvim-lua/lsp-status.nvim'
Plug 'j-hui/fidget.nvim'
Plug 'leoluz/nvim-dap-go'

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
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope-rg.nvim'
Plug 'nvim-telescope/telescope-frecency.nvim'
Plug 'nvim-telescope/telescope-live-grep-args.nvim'
Plug 'tami5/sqlite.lua'

" Colortheme
Plug 'junegunn/seoul256.vim'
Plug 'mhartington/oceanic-next'
Plug 'ayu-theme/ayu-vim'
Plug 'joshdick/onedark.vim'
Plug 'dracula/vim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'rebelot/kanagawa.nvim'
Plug 'ellisonleao/gruvbox.nvim'
" require font setting in iterm2
Plug 'kyazdani42/nvim-web-devicons' 

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let mapleader=" "

" set ignorecase

set completeopt=menuone,noselect,preview

" Load plugins according to detected filetype
filetype plugin indent on  
syntax enable

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Key mapping
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

autocmd FileType markdown nmap <buffer><silent> <Leader>mi :call mdip#MarkdownClipboardImage()<CR>
autocmd FileType markdown nmap <buffer><silent> <Leader>mp <cmd>MarkdownPreviewToggle<CR>
autocmd FileType markdown nmap <buffer><silent> <Leader>mtv <cmd>Toc<CR>
autocmd FileType markdown nmap <buffer><silent> <Leader>mti <cmd>InsertToc<CR>
autocmd FileType markdown nmap <buffer><silent> <Leader>mv <cmd>PresentingStart<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set shiftwidth=2
set tabstop=2
set softtabstop=2

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Lua Config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

lua << EOF
require('editor') -- Basic config
require('keymap') 
require('config') -- LSP / Treesitter
EOF

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Function
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin Setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:AutoPairsMapCR = 0

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
" use nvim_lsp
let g:vista_default_executive = 'nvim_lsp'

" [vim-markdown]
set conceallevel=0
set nofoldenable
let g:vim_markdown_folding_level = -1
let g:vim_markdown_follow_anchor = 1
let g:vim_markdown_math = 1
let g:vim_markdown_json_frontmatter = 1

