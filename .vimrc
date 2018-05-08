"
"Plugins
"
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'tomtom/tcomment_vim'
Plug 'itchyny/lightline.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/syntastic'
Plug 'chriskempson/base16-vim'
Plug 'jszakmeister/vim-togglecursor'

call plug#end()


if !has('gui_running')
    set t_Co=256
endif


if filereadable(expand("~/.vimrc_background"))
    let base16colorspace=256
    source ~/.vimrc_background
endif


"
" Syntastic config
"
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['flake8']


let g:lightline = { 'colorscheme': 'materia', }


let g:togglecursor_leave = 'blinking_line'
let g:togglecursor_replace = 'blinking_underline'


fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

fun! <SID>SetColorColumn()
    execute "set colorcolumn=" . join(map(range(1,254), '"+" . v:val'), ',')
endfun


"
" misc settings
"
set nocompatible
set expandtab
set encoding=utf-8
set shiftwidth=4
set softtabstop=4
set number
set backspace=indent,eol,start
set laststatus=2
set noshowmode
set cursorline
set textwidth=100
set hlsearch
set incsearch

let mapleader = " "
let maplocalleader = "\\"

au BufWritePre * :call <SID>StripTrailingWhitespaces()
au BufRead,BufNewFile *.template set filetype=yaml
au FileType rb setlocal shiftwidth=2 softtabstop=2
au FileType yaml setlocal shiftwidth=2 softtabstop=2
au FileType py setlocal textwidth=79
au BufRead,BufNewFile * :call <SID>SetColorColumn()


"
" mappings
"

" easier escape
inoremap jk <esc>
cnoremap jk <esc>
" make myself use it
inoremap <esc> <nop>
cnoremap <esc> <nop>
" arrow keys are borked in insert mode due to the above mapping, so disable them altogether
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>


" undo diff hunk
nnoremap <Leader>hr <Plug>GitGutterUndoHunk

" remove search highlights
nnoremap <Leader><space> :noh<cr>

" toggle line numbers
nnoremap <Leader>nu :set nu!<cr>

" edit .vimrc in new window
nnoremap <Leader>ev :vsplit $MYVIMRC<cr>

" source .vimrc
nnoremap <Leader>sv :source $MYVIMRC<cr>

