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
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdtree'
Plug 'chriskempson/base16-vim'
Plug 'jszakmeister/vim-togglecursor'
Plug 'ambv/black'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'tpope/vim-jdaddy'
Plug 'lifepillar/vim-mucomplete'
Plug 'davidhalter/jedi-vim'
Plug 'cespare/vim-toml'
Plug 'terryma/vim-multiple-cursors'
Plug 'easymotion/vim-easymotion'
Plug 'vim-scripts/repeatable-motions.vim'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'ntpeters/vim-better-whitespace'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

call plug#end()

" pull in my 'global' vim settings
if filereadable(expand("~/.vimrc_global"))
    source $HOME/.vimrc_global
endif


if !has('gui_running')
    set t_Co=256
endif


if filereadable(expand("~/.vimrc_background"))
    let g:base16colorspace=256
    source ~/.vimrc_background
endif


" Completions
filetype plugin on
set omnifunc=syntaxcomplete#Complete


"
" Mucomplete config
"
set completeopt-=preview
set completeopt+=menu,menuone,noinsert,noselect

set shortmess+=c
set belloff+=ctrlg
let g:mucomplete#enable_auto_at_startup = 1


augroup omni_completion_setup
    autocmd!
    autocmd FileType c          set omnifunc=ccomplete#Complete
    autocmd FileType python     set omnifunc=jedi#completions
    autocmd FileType ruby       set omnifunc=rubycomplete#Complete
    autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType html       set omnifunc=htmlcomplete#CompleteTags
    autocmd FileType css        set omnifunc=csscomplete#CompleteCSS
    autocmd FileType xml        set omnifunc=xmlcomplete#CompleteTags
augroup END


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


" lightline
let g:lightline = { 'colorscheme': 'materia', }


let g:togglecursor_leave = 'blinking_line'
let g:togglecursor_replace = 'blinking_underline'

" Black
let g:black_linelength = 79

" better-whitespace
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1

" Goyo
let g:goyo_width = 120

" NERDTree
nnoremap <Leader>nt :NERDTreeToggle<CR>

fun! <SID>SetColorColumn()
    execute "set colorcolumn=" . join(map(range(1,254), '"+" . v:val'), ',')
endfun


"
" misc settings
"
set textwidth=100
set spelllang=en_us
set spellfile=~/.vim/spell/en.utf-8.add
set spell

set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:¬
set list

highlight NonText guifg=#4a4a59 ctermfg=18
highlight SpecialKey guifg=#4a4a59 ctermfg=18


augroup ksletmoe_general
    autocmd!
    autocmd BufRead,BufNewFile * :call <SID>SetColorColumn()
    autocmd FileType markdown setlocal nolist
    autocmd BufRead,BufNewFile *.md :Goyo
    autocmd User GoyoEnter Limelight0.8
    autocmd User GoyoLeave Limelight!
augroup END

augroup filetype_overrides
    autocmd!
    autocmd BufRead,BufNewFile *.template setlocal filetype=yaml
augroup END

augroup shiftwidth_settings
    autocmd!
    autocmd FileType rb setlocal shiftwidth=2 softtabstop=2
    autocmd FileType yaml setlocal shiftwidth=2 softtabstop=2
    autocmd FileType py setlocal textwidth=79
augroup END


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

" run black on file
nnoremap <Leader>bk :Black<cr>


" toggle Mucomplete auto completions
nnoremap <Leader>ac :MUcompleteAutoToggle<cr>


"
" Abbreviations
"

" PEP-263 encoding string for UTF-8
iabbrev encutf8 # -*- coding: utf-8 -*-
iabbrev pyignore .idea<cr><cr>*.egg-info<cr>*.pyc<cr>build<cr>dist<cr>.coverage<cr>.pytest_cache

