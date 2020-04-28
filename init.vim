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

" Colortheme
Plug 'junegunn/seoul256.vim'
Plug 'mhartington/oceanic-next'
Plug 'morhetz/gruvbox'

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let mapleader=","

set spell " spell check
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
set mouse=a
set cursorline

set completeopt+=noinsert
set completeopt-=preview
set completeopt+=menuone

" Load plugins according to detected filetype
filetype plugin indent on  
syntax enable


if (has("termguicolors"))
  set termguicolors
endif

colorscheme gruvbox

" Remove background
hi Normal guibg=NONE ctermbg=NONE

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Key mapping
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map <C-s> :source ~/.config/nvim/init.vim<CR>

nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

" move entire line in visual mode 
xnoremap K :move '<-2<CR>gv-gv
xnoremap J :move '>+1<CR>gv-gv

nnoremap <Up> :resize +2<CR>
nnoremap <Down> :resize -2<CR>
nnoremap <Left> :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>

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

set shiftwidth=4
set tabstop=4
set softtabstop=4

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Function
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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
" use coc-vim
let g:vista_default_executive = 'coc'

" toggle Vista view
nnoremap gv :Vista!!<CR>

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

