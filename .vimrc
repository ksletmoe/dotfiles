"
"Plugins
"
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" https://github.com/vim/vim/issues/3117
if has('python3')
    silent! python3 1
endif

call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'tomtom/tcomment_vim'
Plug 'itchyny/lightline.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'chriskempson/base16-vim'
Plug 'jszakmeister/vim-togglecursor'
Plug 'psf/black'
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
Plug 'tpope/vim-surround'
Plug 'ntpeters/vim-better-whitespace'
Plug 'othree/xml.vim'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'fholgado/minibufexpl.vim'
Plug 'dkprice/vim-easygrep'
Plug 'majutsushi/tagbar'
Plug 'ludovicchabant/vim-gutentags'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'udalov/kotlin-vim'

call plug#end()

" pull in my 'global' vim settings
if filereadable(expand("~/.vimrc_global"))
    source $HOME/.vimrc_global
endif


" Base16
let base16colorspace=256
colorscheme base16-material

" Completions
filetype plugin on
set omnifunc=syntaxcomplete#Complete

"
" Gitgutter config
"
nnoremap <Leader>hr <Plug>GitGutterUndoHunk

"
" Mucomplete config
"
set completeopt-=preview
set completeopt+=menu,menuone,noinsert,noselect

set shortmess+=c
set belloff+=ctrlg
let g:mucomplete#enable_auto_at_startup = 1
" toggle Mucomplete auto completions
nnoremap <Leader>ac :MUcompleteAutoToggle<cr>

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

"
" lightline
"
let g:lightline = { 'colorscheme': 'materia', }

"
" Toggle-cursor config
"
let g:togglecursor_leave = 'blinking_line'
let g:togglecursor_replace = 'blinking_underline'

"
" Black config
"
let g:black_linelength = 100
let g:black_virtualenv="~/.virtualenvs/vim_black"
" run black on file
nnoremap <Leader>bk :Black<cr>

"
" better-whitespace
"
let g:better_whitespace_enabled = 1
let g:strip_whitespace_on_save = 1

"
" NERDTree
"
nnoremap <Leader>nt :NERDTreeToggle<CR>
let g:NERDTreeWinSize=60

augroup nerdtree_setup
    autocmd!
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
    autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | wincmd p | ene | exe 'NERDTree' argv()[0] | endif
    " quit if only window open is NERDTree
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | qall | endif
augroup end

"
" ultisnips
"
let g:UltiSnipsExpandTrigger = "<localleader><tab>"
let g:UltiSnipsListSnippets = "<localleader><tab>l"

"
" Minibufexpl
"
let g:miniBufExplorerAutoStart=1

nnoremap <Leader>mb :MBEToggle<cr>
nnoremap <Leader>bn :MBEbn<cr>
nnoremap <Leader>bp :MBEbp<cr>
nnoremap <Leader>bb :MBEbb<cr>
nnoremap <Leader>bf :MBEbf<cr>

"
" tagbar
"
nnoremap <Leader>tb :TagbarToggle<cr>

"
" easygrep
"
let g:EasyGrepRecursive = 1
let g:EasyGrepFilesToExclude = "*.swp,*~,.git,tags*,build/"

"
" ctrlp
"
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_map = '<c-p>'

"
" misc settings
"
set exrc
set secure

set colorcolumn=100

set spelllang=en_us
set spellfile=~/.vim/spell/en.utf-8.add
set spell
hi clear SpellBad
hi SpellBad cterm=undercurl

set listchars=tab:\|￫,space:·,nbsp:␣,trail:•,eol:¬
set list

highlight NonText guifg=#4a4a59 ctermfg=08
highlight SpecialKey guifg=#4a4a59 ctermfg=08

augroup ksletmoe_general
    autocmd!
    autocmd FileType markdown setlocal nolist wrap linebreak breakindent
    autocmd FileType text setlocal nolist wrap linebreak breakindent
    autocmd FileType nerdtree setlocal nolist
augroup END

augroup filetype_overrides
    autocmd!
    autocmd BufRead,BufNewFile *.template setlocal filetype=yaml
    autocmd BufRead,BufNewFile *.jinja setlocal filetype=jinja
augroup END

augroup shiftwidth_settings
    autocmd!
    autocmd FileType ruby setlocal shiftwidth=2 softtabstop=2
    autocmd FileType yaml setlocal shiftwidth=2 softtabstop=2
    autocmd FileType python setlocal colorcolumn=100
    autocmd FileType Makefile setlocal noexpandtab
    autocmd FileType xml setlocal shiftwidth=2 softtabstop=2
    autocmd FileType go setlocal noexpandtab
    autocmd FileType markdown setlocal shiftwidth=2 softtabstop=2 colorcolumn=0
    autocmd FileType text setlocal shiftwidth=2 softtabstop=2 colorcolumn=0
augroup END

"
" misc mappings
"
" toggle line numbers
nnoremap <Leader>nu :set nu!<cr>
" edit .vimrc in new window
nnoremap <Leader>ev :vsplit $MYVIMRC<cr>
" source .vimrc
nnoremap <Leader>sv :source $MYVIMRC<cr>
