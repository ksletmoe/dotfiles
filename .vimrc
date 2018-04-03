set expandtab
set shiftwidth=4
set softtabstop=4
set number
set backspace=indent,eol,start
set laststatus=2

fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

au BufWritePre * :call <SID>StripTrailingWhitespaces()
au BufRead,BufNewFile *.template set filetype=yaml
au FileType rb setlocal shiftwidth=2 softtabstop=2
au FileType yaml setlocal shiftwidth=2 softtabstop=2

if !has('gui_running')
  set t_Co=256
endif

" Plugins
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
call plug#end()

" mappings
nmap <Leader>hr <Plug>GitGutterUndoHunk
