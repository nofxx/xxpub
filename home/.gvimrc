"Note MiscFixed is not antialiased which is redundant for
"unscaled bitmap fonts in my opinion and just slows things down
"and makes it harder to read. It's a nice font also.
if has("gui_gtk2")
    set guifont=Monaco\ 12
else
    set guifont=-misc-fixed-medium-r-normal--10-100-75-75-c-60-iso8859-1
endif
set columns=100 lines=40
set guioptions-=T "hide toolbar
set wrap

filetype on  " Automatically detect file types.
set nocompatible  " We don't want vi compatibility.
 
" Add recently accessed projects menu (project plugin)
set viminfo^=!
 
" Minibuffer Explorer Settings
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1


set cf  " Enable error files & error jumping.
set clipboard+=unnamed  " Yanks go on clipboard instead.
set history=256  " Number of things to remember in history.
set autowrite  " Writes on make/shell commands
set ruler  " Ruler on
set nu  " Line numbers on
set nowrap  " Line wrapping off
set timeoutlen=250  " Time to wait after ESC (default causes an annoying delay)
" colorscheme vividchalk  " Uncomment this to set a default theme
 
" Formatting (some of these are for coding in C and C++)
set ts=2  " Tabs are 2 spaces
set bs=2  " Backspace over everything in insert mode
set shiftwidth=2  " Tabs under smart indent
set nocp incsearch
set cinoptions=:0,p0,t0
set cinwords=if,else,while,do,for,switch,case
set formatoptions=tcqr
set cindent
set autoindent
set smarttab
set expandtab
 
" Visual
set showmatch  " Show matching brackets.
set mat=5  " Bracket blinking.
set list
" Show $ at end of line and trailing space as ~
set lcs=tab:\ \ ,eol:$,trail:~,extends:>,precedes:<
set novisualbell  " No blinking .
set noerrorbells  " No noise.
set laststatus=2  " Always show status line.
 
" gvim specific
set mousehide  " Hide mouse after chars typed
set mouse=a  " Mouse in all modes

" alt+n or alt+p to navigate between entries in QuickFix
map <silent> <m-p> :cp <cr>
map <silent> <m-n> :cn <cr>
 
" Change which file opens after executing :Rails command
let g:rails_default_file='config/database.yml'
 
syntax enable
        " save selection registers

" Backups & Files
"set backup                     " Enable creation of backup file.
"set backupdir=~/.vim/backups " Where backups will go.
"set directory=~/.vim/tmp     " Where temporary files will go.


""
"Try to load happy hacking teal colour scheme
"I copy this to ~/.vim/colors/hhteal.vim
silent! colorscheme darkspectrum
if exists("colors_name") == 0
    "Otherwise modify the defaults appropriately

    "background set to dark in .vimrc
    "So pick appropriate defaults.
    hi Normal     guifg=gray guibg=black
    hi Visual     gui=none guifg=black guibg=yellow

    "The following removes bold from all highlighting
    "as this is usually rendered badly for me. Note this
    "is not done in .vimrc because bold usually makes
    "the colour brighter on terminals and most terminals
    "allow one to keep the new colour while turning off
    "the actual bolding.

    " Steve Hall wrote this function for me on vim@vim.org
    " See :help attr-list for possible attrs to pass
    function! Highlight_remove_attr(attr)
        " save selection registers
        new
        silent! put

        " get current highlight configuration
        redir @x
        silent! highlight
        redir END
        " open temp buffer
        new
        " paste in
        silent! put x

        " convert to vim syntax (from Mkcolorscheme.vim,
        "   http://vim.sourceforge.net/scripts/script.php?script_id=85)
        " delete empty,"links" and "cleared" lines
        silent! g/^$\| links \| cleared/d
        " join any lines wrapped by the highlight command output
        silent! %s/\n \+/ /
        " remove the xxx's
        silent! %s/ xxx / /
        " add highlight commands
        silent! %s/^/highlight /
        " protect spaces in some font names
        silent! %s/font=\(.*\)/font='\1'/

        " substitute bold with "NONE"
        execute 'silent! %s/' . a:attr . '\([\w,]*\)/NONE\1/geI'
        " yank entire buffer
        normal ggVG
        " copy
        silent! normal "xy
        " run
        execute @x

        " remove temp buffer
        bwipeout!

        " restore selection registers
        silent! normal ggVGy
        bwipeout!
    endfunction
    autocmd BufNewFile,BufRead * call Highlight_remove_attr("bold")
    " Note adding ,Syntax above messes up the syntax loading
    " See :help syntax-loading for more info
endif
highlight Pmenu guibg=yellow guifg=black
highlight PmenuSel guibg=white guifg=black


let g:explVertical=1 " Split vertically
let g:explSplitRight=1    " Put new window to the right of the explorer
map <C-f> gf
imap <C-f> <ESC>gf a
map <C-b> :bf<ENTER>
imap <C-b> <ESC>:bf<ENTER> a


imap <C-t> <esc>:tabe<enter> a
map <C-t> :tabe<enter> i

imap <C-s> <esc>:w<enter> a
map <C-s> :w<enter>

imap <C-e> <esc>:close<enter> a
map <C-e> :close<enter>

#imap <C-w> <esc>:close<enter> a
#map <C-w> :close<enter>

