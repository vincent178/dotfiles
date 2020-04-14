call plug#begin('~/.vim/autoload/plugged')

Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'

" Engine with full language server protocol 
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Project tree
Plug 'scrooloose/nerdtree'

" Git
Plug 'tpope/vim-fugitive'

" Fuzzy finder
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

" View and search LSP symbols, tags
Plug 'liuchengxu/vista.vim'

" Focus writing mode
Plug 'junegunn/goyo.vim'

" Colortheme
Plug 'junegunn/seoul256.vim'
Plug 'mhartington/oceanic-next'

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let mapleader=","

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

set completeopt+=noinsert
set completeopt-=preview
set completeopt+=menuone

if (has("termguicolors"))
  set termguicolors
endif

colorscheme OceanicNext

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

nnoremap <Leader>s <C-w>v<C-w>l
nnoremap <Leader>v <C-w>s<C-w>j
noremap <Leader>q :q<cr>
noremap <Leader>w :w<cr>
noremap <Leader>wq :wq<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Load plugins according to detected filetype
filetype plugin indent on  
syntax enable

" set width of a hard tabstop measured in spaces
set tabstop=4
" set size of an indent measured in spaces
set shiftwidth=4

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Function
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <Leader>0 :call MonkeyTerminalToggle()<CR>

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
nnoremap <Leader>n :NERDTreeToggle<CR>

" [coc-vim]
" use return to confirm completion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" auto go import and fmt when save
autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')

" [vista] 
" set tag view width
let g:vista_sidebar_width = 48
" disable tag view icon
let g:vista#renderer#enable_icon = 0

" [fzf.vim]
map <C-t> :Files<CR>
map <Leader>f :Rg<Space>

command! -bang -nargs=? Rg
    \ call fzf#vim#grep(RgCommand(<f-args>), 1, fzf#vim#with_preview(), <bang>0)

function! RgCommand(...)
  " not sure why f-args won't split argument by spaces  
  " this is a hack implementation
  return printf("rg --column --line-number --no-heading --color=always --smart-case %s", a:1)
endfunction

