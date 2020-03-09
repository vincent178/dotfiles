call plug#begin('~/.vim/autoload/plugged')

" Engine with full language server protocol 
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Project file tree
Plug 'scrooloose/nerdtree'

" Golang for vim
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'sebdah/vim-delve' " golang debug

" Cross project search
Plug 'mileszs/ack.vim'
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'jiangmiao/auto-pairs'

" View and search LSP symbols, tags
Plug 'liuchengxu/vista.vim'

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set autoindent
set expandtab
set number
set showmode
set showcmd
set ruler
set hidden
set noswapfile
set incsearch
set hlsearch
set encoding=utf-8
set mouse=a

let mapleader=","

set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
set wildignore+=*/node_modules/*,*/bower_components/*,*/acceptance_tests/*
set wildignore+=.git/*,.hg/*,.svn/*

set completeopt+=noinsert
set completeopt-=preview
set completeopt+=menuone

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Key mapping
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-l> <C-\><C-N><C-w>l
inoremap <C-j> <C-\><C-N><C-w>j
inoremap <C-k> <C-\><C-N><C-w>k
inoremap <C-h> <C-\><C-N><C-w>h
inoremap <C-l> <C-\><C-N><C-w>l
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

tnoremap <Esc> <C-\><C-n>

inoremap <C-A> <Home>
inoremap <C-E> <End>
inoremap <C-B> <Left>
inoremap <C-F> <Right>


vnoremap <Leader>y "+y
nnoremap <Leader>y "+y
nnoremap <Leader>p "+p

nmap <silent> <Leader>/ :silent noh<CR>

map <Leader>f :Ack!<Space>

nnoremap <Leader>n :NERDTreeToggle<CR>
nnoremap <Leader>s <C-w>v<C-w>l
nnoremap <Leader>v <C-w>s<C-w>j
noremap <Leader>q :q<cr>
noremap <Leader>w :w<cr>
noremap <Leader>wq :wq<cr>

nnoremap <Leader>t :call MonkeyTerminalToggle()<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set backspace=2
set tabstop=2
set softtabstop=2
set shiftwidth=2

" Load plugins according to detected filetype
filetype plugin indent on  
syntax on

autocmd FileType c          set shiftwidth=4
autocmd FileType python     set shiftwidth=4
autocmd FileType php        set shiftwidth=4
autocmd FileType javascript set shiftwidth=2
autocmd FileType css        set shiftwidth=2
autocmd FileType scss       set shiftwidth=2
autocmd FileType sass       set shiftwidth=2
autocmd FileType html       set shiftwidth=4
autocmd FileType go         set shiftwidth=4 tabstop=4 softtabstop=4

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Function
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! HTerminal()
  sp
  wincmd j
  resize 20
	terminal
endfunction

let s:monkey_terminal_window = -1
let s:monkey_terminal_buffer = -1
let s:monkey_terminal_job_id = -1

function! MonkeyTerminalOpen()
  " Check if buffer exists, if not create a window and a buffer
  if !bufexists(s:monkey_terminal_buffer)
    " Creates a window call monkey_terminal
    new monkey_terminal
    " Moves to the window the right the current one
    wincmd j
    resize 30
    let s:monkey_terminal_job_id = termopen($SHELL, { 'detach': 1 })

     " Change the name of the buffer to "Terminal 1"
     silent file Terminal\ 1
     " Gets the id of the terminal window
     let s:monkey_terminal_window = win_getid()
     let s:monkey_terminal_buffer = bufnr('%')

    " The buffer of the terminal won't appear in the list of the buffers
    " when calling :buffers command
    set nobuflisted
  else
    if !win_gotoid(s:monkey_terminal_window)
    sp
    " Moves to the window below the current one
    wincmd j
    resize 30
    buffer Terminal\ 1
     " Gets the id of the terminal window
     let s:monkey_terminal_window = win_getid()
    endif
  endif
endfunction

function! MonkeyTerminalClose()
  if win_gotoid(s:monkey_terminal_window)
    " close the current window
    hide
  endif
endfunction

function! MonkeyTerminalToggle()
  if win_gotoid(s:monkey_terminal_window)
    call MonkeyTerminalClose()
  else
    call MonkeyTerminalOpen()
  endif
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin Setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" [nerdtree] 
" display hidden files
let NERDTreeShowHidden=1

" [vim-go]
let g:go_fmt_command = "goimports"
let g:go_auto_type_info = 1

autocmd FileType go nmap <leader>b <Plug>(go-build)
autocmd FileType go nmap <leader>r <Plug>(go-run)
autocmd FileType go nmap <leader>t <Plug>(go-test)
autocmd FileType go nmap <leader>i <Plug>(go-info)

" [coc-vim]
" use return to confirm completion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" [vista] 
" set tag view width
let g:vista_sidebar_width = 48
" disable tag view icon
let g:vista#renderer#enable_icon = 0

