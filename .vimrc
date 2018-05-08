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

" pull in my 'global' vim settings
source $HOME/.vimrc_global


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
set textwidth=100

au BufWritePre * :call <SID>StripTrailingWhitespaces()
au BufRead,BufNewFile *.template set filetype=yaml
au FileType rb setlocal shiftwidth=2 softtabstop=2
au FileType yaml setlocal shiftwidth=2 softtabstop=2
au FileType py setlocal textwidth=79
au BufRead,BufNewFile * :call <SID>SetColorColumn()


"
" mappings
"

" undo diff hunk
nnoremap <Leader>hr <Plug>GitGutterUndoHunk

" toggle line numbers
nnoremap <Leader>nu :set nu!<cr>

" edit .vimrc in new window
nnoremap <Leader>ev :vsplit $MYVIMRC<cr>

" source .vimrc
nnoremap <Leader>sv :source $MYVIMRC<cr>

