set nocompatible

" prevent annoying behavior of some keys in selection mode
"vunmap p
" vunmap d
" vunmap u

" CTRL-Z undoes even in visual/selection mode
vnoremap <C-Z> <C-C>u

"inoremap <C-S-Left> <C-O>gh<C-O>b

" F7 runs make
nnoremap <F7> :w<CR>:make<CR>
inoremap <F7> <C-O>:w<CR><C-O>:make<CR>
vnoremap <F7> <C-C>:w<CR><C-C>:make<CR>

" F7 runs make run
nnoremap <F5> :w<CR>:make run<CR>
inoremap <F5> <C-O>:w<CR><C-O>:make run<CR>
vnoremap <F5> <C-C>:w<CR><C-C>:make run<CR>

" Make cursor keys ignore wrapping
nnoremap <Up> gk
inoremap <Up> <C-O>gk
nnoremap <Down> gj
inoremap <Down> <C-O>gj
nnoremap <Home> g0
inoremap <Home> <C-O>g0
nnoremap <End> g$
inoremap <End> <C-O>g$

" CTRL-T and CTRL-D indent and unindent blocks
inoremap <C-D> <C-O><LT><LT>
nnoremap <C-D> <LT><LT>
vnoremap <C-T> >
vnoremap <C-D> <LT>

" CTRL-TAB inserts a tab character (i.e., does not replace tab with spaces)
inoremap <C-Tab> <C-V><Tab>

" CTRL-R reloads the ~/.vimrc file
nnoremap <C-R> :source ~/.vimrc
inoremap <C-R> <C-O>:source ~/.vimrc
vnoremap <C-R> <C-C>:source ~/.vimrc

" CTRL-F does Find dialog instead of page forward
noremap <C-F> :promptfind<CR>
vnoremap <C-F> y:promptfind <C-R>"<CR>
onoremap <C-F> <C-C>:promptfind<CR>
inoremap <C-F> <C-O>:promptfind<CR>
cnoremap <C-F> <C-C>:promptfind<CR>

" CTRL-H does Replace dialog instead of character left
noremap <C-H> :promptrepl<CR>
vnoremap <C-H> y:promptrepl <C-R>"<CR>
onoremap <C-H> <C-C>:promptrepl<CR>
inoremap <C-H> <C-O>:promptrepl<CR>
cnoremap <C-H> <C-C>:promptrepl<CR>

set number
set ruler
set showcmd
"set co=80
"set lines=25

set showmatch       " show matching braces

set history=500

set expandtab
set tabstop=4
set autoindent
set smartindent
set shiftwidth=4

"if has("vms")
"  set nobackup
"else
"  set backup
"endif

set incsearch   " incremental search
set ignorecase  " search ignores case

" turn off error beep/flash
set noerrorbells
set visualbell 
set t_vb=   
if has('autocmd')
    autocmd GUIEnter * set vb t_vb=
endif 

if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
  nohlsearch
endif

colorscheme darkblue
