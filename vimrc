" call pathogen#infect()
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vbundle
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

" My Bundles here:

Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-speeddating'
Bundle 'tpope/vim-bundler'
Bundle 'tpope/vim-ragtag'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-cucumber'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-dispatch'
Bundle 'tpope/vim-classpath'
Bundle 'tpope/vim-rvm'

" Bundle 'Valloric/YouCompleteMe'
Bundle 'Shougo/neocomplcache.vim'

" Language Syntax
Bundle 'vim-ruby/vim-ruby'
Bundle 'pangloss/vim-javascript'
Bundle 'kchmck/vim-coffee-script'
Bundle 'juvenn/mustache.vim'
Bundle 'Blackrush/vim-gocode'


Bundle 'mileszs/ack.vim'
Bundle 'msanders/snipmate.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'mattn/emmet-vim'
Bundle 'scrooloose/nerdtree'
Bundle 'Lokaltog/vim-powerline'
Bundle 'ervandew/supertab'
Bundle 'jgdavey/tslime.vim'
Bundle 'godlygeek/tabular'
Bundle 'm2ym/rsense'
Bundle 'jiangmiao/auto-pairs'
Bundle 'christoomey/vim-tmux-navigator'
Bundle 'kakkyz81/evervim'


" Color theme for vim
Bundle 'jnurmine/Zenburn'
Bundle 'jpo/vim-railscasts-theme'
Bundle 'altercation/vim-colors-solarized'
Bundle 'wesgibbs/vim-irblack'
Bundle 'tomasr/molokai'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set to auto read when a file is changed from the outside
set autoread
set background=dark

set number
set ruler
" set nocompatible   
set nowrapscan 
set hidden     
set noimdisable
set iminsert=0
set imsearch=0
set noswapfile
set incsearch
set hlsearch


if has("mouse")
  set mouse=a
endif

" Make backspace works in Insert mode
" Like most other apps
set backspace=2

" Enable filetype plugins
filetype plugin on
filetype indent on

" Output using 256 colors
set t_Co=256

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

colors zenburn

set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936,gbk,cp936 
set termencoding=utf-8
set encoding=utf-8
set guifont=Menlo:h13      

" Enable syntax highlighting
syntax enable
syntax on   

highlight Pmenu ctermbg=238 gui=bold

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Key mapping
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Bash like keybinding
inoremap <C-A> <Home>
inoremap <C-E> <End>
inoremap <C-B> <Left>
inoremap <C-F> <Right>



" Remap leader key
let mapleader=","

" Copy and paste into system clipboard
vnoremap <Leader>y "+y
nnoremap <Leader>y "+y
nnoremap <Leader>p "+p


" Close search
nmap <silent> <Leader>/ :silent noh<CR>

" Ack key mappings
map <Leader>f :Ack<Space>

" Bind n for NerdTree
nnoremap <Leader>n :NERDTreeToggle<CR>

nnoremap <Leader>s <C-w>v<C-w>l
nnoremap <Leader>v <C-w>s<C-w>j

noremap <Leader>q :q<cr>
noremap <Leader>w :w<cr>
noremap <Leader>wq :wq<cr>

noremap <Leader>es :EvervimSetup<cr>
noremap <Leader>el :EvervimNotebookList<cr>
noremap <Leader>ef :EvervimSearchByQuery<cr>
noremap <Leader>ec :EvervimCreateNote<cr>

 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Different indentaion based of filetype
filetype plugin indent on

set tabstop=2  
set softtabstop=2
set shiftwidth=2

autocmd FileType c setlocal sw=4 sts=4 et
autocmd FileType python setlocal sw=4 sts=4 et
autocmd FileType php setlocal sw=4 sts=4 et
autocmd FileType javascript setlocal sw=2 sts=2 et
autocmd FileType css setlocal sw=4 sts=4 et
autocmd FileType scss setlocal sw=4 sts=4 et
autocmd FileType sass setlocal sw=4 sts=4 et

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab
set autoindent   
set smartindent 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Function customazation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Paste toggle
nnoremap <F2> :set invpaste paste?<CR>
imap <F2> <C-O>:set invpaste paste?<CR>
set pastetoggle=<F2>

" Run neocomplete at startup
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1


" Powerline configration
let g:Powerline_symbols = 'fancy'
set laststatus=2
let g:Powerline_dividers_override = ['','','','|']

" lets SuperTab decide which completion mode
set completeopt-=preview
let g:SuperTabDefaultCompletionType = "<C-X><C-O>"

" Automatic Saving
autocmd BufLeave,FocusLost * silent! wall

let g:evervim_devtoken=$EVERNOTE


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Gvim Only
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Window Settings
set hidden
set guioptions-=r
set guioptions-=L

" Tab Switch
map <D-1> 1gt
map <D-2> 2gt
map <D-3> 3gt
map <D-4> 4gt
map <D-5> 5gt
map <D-6> 6gt
map <D-7> 7gt
map <D-8> 8gt
map <D-9> 9gt
map <D-0> :tablast<CR>
