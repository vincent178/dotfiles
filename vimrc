"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 
" Vimrc file used by Vincent, created at 2015.04.24
" Please contact me if you have any problem
" Email address hl007@outlook.com
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vbundle
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

" My Bundles here:

" Language Syntax
Bundle 'vim-ruby/vim-ruby'
Bundle 'pangloss/vim-javascript'
Bundle 'kchmck/vim-coffee-script'
Bundle 'juvenn/mustache.vim'
Bundle 'Blackrush/vim-gocode'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-markdown'
Bundle 'dgryski/vim-godef'
Bundle 'elixir-lang/vim-elixir'

" Function expand
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-commentary'
Bundle 'mileszs/ack.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'mattn/emmet-vim'
Bundle 'scrooloose/nerdtree'
Bundle 'Lokaltog/vim-powerline'
Bundle 'jgdavey/tslime.vim'
Bundle 'jiangmiao/auto-pairs'
Bundle 'christoomey/vim-tmux-navigator'
Bundle 'jistr/vim-nerdtree-tabs'


" AutoComplete
Bundle 'Valloric/YouCompleteMe'
Bundle 'marijnh/tern_for_vim'

" Color theme for vim
Bundle 'jnurmine/Zenburn'
Bundle 'jpo/vim-railscasts-theme'
Bundle 'altercation/vim-colors-solarized'
Bundle 'wesgibbs/vim-irblack'
Bundle 'tomasr/molokai'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set t_Co=256
set number
set ruler
set hidden     
set noswapfile
set incsearch
set hlsearch
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936,gbk,cp936 
set encoding=utf-8
set guifont=Menlo:h15
set mouse=a

colors Zenburn

" Enable syntax highlighting
syntax enable
syntax on   
highlight Pmenu ctermbg=238 gui=bold

" Enable filetype plugins
filetype plugin on
filetype indent on

" autocomplete
set omnifunc=syntaxcomplete#Complete
set completeopt-=preview


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Key mapping
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <C-t> <C-p>

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
map <Leader>f :Ack!<Space>

nnoremap <Leader>n :NERDTreeToggle<CR>
nnoremap <Leader>s <C-w>v<C-w>l
nnoremap <Leader>v <C-w>s<C-w>j
noremap <Leader>q :q<cr>
noremap <Leader>w :w<cr>
noremap <Leader>wq :wq<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Make backspace works in Insert mode
" Like most other apps
set backspace=2
set tabstop=2  
set softtabstop=2
set shiftwidth=2

autocmd FileType c setlocal sw=4 sts=4 et
autocmd FileType python setlocal sw=4 sts=4 et
autocmd FileType php setlocal sw=4 sts=4 et
autocmd FileType javascript setlocal sw=2 sts=2 et
autocmd FileType css setlocal sw=2 sts=2 et
autocmd FileType scss setlocal sw=2 sts=2 et
autocmd FileType sass setlocal sw=2 sts=2 et

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab
set autoindent   
set smartindent 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Customazation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Paste toggle
nnoremap <F2> :set invpaste paste?<CR>
imap <F2> <C-O>:set invpaste paste?<CR>
set pastetoggle=<F2>

" Automatic Saving
autocmd BufLeave,FocusLost * silent! wall

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Function 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin Setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" neocomplete
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#enable_auto_select = 1

" NERDTree show hidden files at startup
let NERDTreeShowHidden=1

" Powerline configration
let g:Powerline_symbols = 'unicode'
set laststatus=2
let g:Powerline_dividers_override = ['','','','|']

set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn|bower_components|acceptance_tests|node_modules)$',
  \ 'file': '\v\.(exe|so|dll)$'}

" Use Ag with ack.vim
let g:ackprg = 'ag --nogroup --nocolor --column'

set wildignore+=*/node_modules/*,*/bower_components/*,*/acceptance_tests/*

if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  "setglobal bomb
  set fileencodings=ucs-bom,utf-8,latin1
endif

