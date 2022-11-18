let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/autoload/plugged')

" tmux requires additional setup: https://github.com/christoomey/vim-tmux-navigator
Plug 'christoomey/vim-tmux-navigator'
Plug 'djoshea/vim-autoread'
Plug 'tpope/vim-commentary'
" Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'akinsho/nvim-toggleterm.lua'
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-orgmode/orgmode'
" Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'

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
Plug 'morhetz/gruvbox'
Plug 'ayu-theme/ayu-vim'
Plug 'joshdick/onedark.vim'
Plug 'dracula/vim'
Plug 'nvim-lualine/lualine.nvim'
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

set termguicolors
let ayucolor="mirage" " for mirage version of theme
colorscheme ayu


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Key mapping
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <silent> <Leader> :WhichKey '<Space>'<CR>

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
" nnoremap <Leader>s <C-w>v<C-w>l
" nnoremap <Leader>v <C-w>s<C-w>j
noremap <Leader>q :q<cr>
noremap <Leader>w :w<cr>
noremap <Leader>wq :wq<cr>


nnoremap <Leader>ff <cmd>Telescope find_files<cr>
nnoremap <Leader>fg <cmd>lua require("telescope").extensions.live_grep_args.live_grep_args()<cr>
nnoremap <Leader>fb <cmd>Telescope buffers<cr>
nnoremap <Leader>fh <cmd>Telescope help_tags<cr>
nnoremap <Leader>fp <cmd>Telescope pickers<cr>
nnoremap <Leader>fr <cmd>Telescope resume<cr>

nnoremap <silent> <Leader>bb :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <Leader>bn :lua require'dap'.continue()<CR>
nnoremap <silent> <Leader>bs :lua require'dap'.step_over()<CR>
nnoremap <silent> <Leader>bi :lua require'dap'.step_into()<CR>
nnoremap <silent> <Leader>bo :lua require'dap'.step_out()<CR>
nnoremap <silent> <Leader>bu :lua require('dapui').toggle('sidebar')<CR>

nnoremap <Leader>t <Cmd>ToggleTerm<CR>

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
require('config');
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
" use nvim_lsp
let g:vista_default_executive = 'nvim_lsp'

" [vim-markdown]
set conceallevel=0
set nofoldenable
let g:vim_markdown_folding_level = -1
let g:vim_markdown_follow_anchor = 1
let g:vim_markdown_math = 1
let g:vim_markdown_json_frontmatter = 1

" command! -bang -nargs=? Rg
"     \ call fzf#vim#grep(RgCommand(<f-args>), 1, fzf#vim#with_preview(), <bang>0)

" function! RgCommand(...)
"   " not sure why f-args won't split argument by spaces  
"   " this is a hack implementation
"   return printf("rg --column --line-number --no-heading --color=always --smart-case %s", a:1)
" endfunction

" function! LspStatus() abort
"   if luaeval('#vim.lsp.buf_get_clients() > 0')
"     return luaeval("require('lsp-status').status()")
"   endif

"   return ''
" endfunction
