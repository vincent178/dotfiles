"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Dein Scripts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/Users/i312714/.vim/bundles/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/Users/i312714/.vim/bundles')
  call dein#begin('/Users/i312714/.vim/bundles')

  " Let dein manage dein
  " Required:
  call dein#add('/Users/i312714/.vim/bundles/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('fatih/vim-go')
  call dein#add('jodosha/vim-godebug')
  call dein#add('scrooloose/nerdtree')
  call dein#add('mileszs/ack.vim')
  call dein#add('kristijanhusak/vim-hybrid-material')
  call dein#add('kien/ctrlp.vim')
  call dein#add('zchee/deoplete-go', {'build': 'make'})
  call dein#add('sebdah/vim-delve')
  call dein#add('tpope/vim-commentary')
  call dein#add('tpope/vim-fugitive')
  call dein#add('jiangmiao/auto-pairs')
  call dein#add('ervandew/supertab')
  call dein#add('mattn/emmet-vim')
  call dein#add('vim-ruby/vim-ruby')



  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')
  call dein#add('StanAngeloff/php.vim')


  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif



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

highlight Pmenu ctermbg=238 gui=bold

set background=dark
colorscheme hybrid_reverse
let g:airline_theme = "hybrid"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Key mapping
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <C-t> <C-p>

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

let mapleader=","

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


function! HTerminal()
  sp
  wincmd j
  resize 10
	terminal
endfunction

nnoremap <Leader>t :call HTerminal()<CR>

au FileType go nmap <leader>gt :GoDeclsDir<cr>
au Filetype go nmap <leader>ga <Plug>(go-alternate-edit)
au Filetype go nmap <leader>gah <Plug>(go-alternate-split)
au Filetype go nmap <leader>gav <Plug>(go-alternate-vertical)
au FileType go nmap <F10> :GoTest -short<cr>
au FileType go nmap <F9> :GoCoverageToggle -short<cr>
au FileType go nmap <F12> <Plug>(go-def)


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set backspace=2
set tabstop=2
set softtabstop=2
set shiftwidth=2

au FileType c setlocal sw=4 sts=4 et
au FileType python setlocal sw=4 sts=4 et
au FileType php setlocal sw=4 sts=4 et
au FileType javascript setlocal sw=2 sts=2 et
au FileType css setlocal sw=2 sts=2 et
au FileType scss setlocal sw=2 sts=2 et
au FileType sass setlocal sw=2 sts=2 et
au FileType html setlocal sw=4 sts=4 et
au FileType go set shiftwidth=4
au FileType go set softtabstop=4
au FileType go set tabstop=4


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Customazation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <F2> :set invpaste paste?<CR>
imap <F2> <C-O>:set invpaste paste?<CR>
set pastetoggle=<F2>

autocmd BufLeave,FocusLost * silent! wall

let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_auto_sameids = 1
let g:go_fmt_command = "goimports"

let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'
let g:airline#extensions#ale#enabled = 1


let g:go_addtags_transform = "snakecase"
let g:go_snippet_engine = "neosnippet"



let g:go_auto_type_info = 1

if has('nvim')
    " Enable deoplete on startup
    let g:deoplete#enable_at_startup = 1
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Function
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin Setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let NERDTreeShowHidden=1

set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn|bower_components|acceptance_tests|node_modules|public)$',
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


set completeopt+=noinsert
set completeopt-=preview
set completeopt+=menuone


imap <expr><CR> neosnippet#expandable() ? "\<Plug>(neosnippet_expand)" : pumvisible() ?
			\ "\<C-y>" : "\<CR>"
