set ruler " Ruler on
set nu " Line numbers on
set nocompatible " no vi compatibility (more features)
set nowrap " Disable line wrap. Will set on per-file basis
set clipboard+=unnamed " Yanks go to clipboard.
set history=256 " Number of things to remember in history.
set timeoutlen=220 " recommended. Otherwise there's a delay when you press escape

set expandtab
set tabstop=2
set bs=2
set shiftwidth=2
set autoindent
set smarttab

colorscheme delek

" Switch to the directory of open file
" autocmd BufEnter * lcd %:p:h
"
" " These two remove annoying blinking and noise
" set novisualbell
" set noerrorbells
