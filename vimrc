" --- snipmate ---
let g:snips_author = 'Leandro Vital <leandro.vital@yahoo.com.br>'

" -----------------------------------------------------------------------------
" BEHAVIOR
" -----------------------------------------------------------------------------

set nocompatible            " Disable vi compatibility
syntax on                   " Enable themas
filetype on
set guioptions-=m           " Remove menu bar
set guioptions-=T           " Remove toolbar

" set autocomplete
filetype plugin on
set omnifunc=syntaxcomplete#Complete

" PHP autocomplete
autocmd FileType php set omnifunc=phpcomplete#CompletePHP

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

" vundle initialization
" This loads all the plugins specified in ~/.vim/vundles.vim
" Use Vundle plugin to manage all other plugins
if filereadable(expand("~/.vim/vundles.vim"))
  source ~/.vim/vundles.vim
endif

" -----------------------------------------------------------------------------
" PLUGINS
" -----------------------------------------------------------------------------

" ctrlsh.vim search paramters
nmap <silent> <C-S-f> :call SearchAllFiles()<CR>

function! SearchAllFiles()
  let curline = getline('.')
  call inputsave()
  let params = input('search: ')
  if(empty(params)) | return | endif 
  call inputrestore()
  :execute "CtrlSFQuickfix " . "'".params."'"
endfunction

" ctrlsh.vim enable ack depends
let g:ctrlsf_ackprg='ack'

" --- AutoSave ---
let g:auto_save = 0

" --- NERDTree ----

let NERDTreeIgnore=['.DS_Store']
let NERDTreeShowBookmarks=0         "show bookmarks on startup
let NERDTreeHighlightCursorline=1   "Highlight the selected entry in the tree
let NERDTreeShowLineNumbers=0
let NERDTreeMinimalUI=1
let NERDTreeWinSize=32
let NERDTreeAutoDeleteBuffer=1

nmap <silent> <C-t> :NERDTreeToggle<CR>

" NERDTree open automatically
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

let NERDTreeMapActivateNode='<space>'

" --- NERDCommenter ---
let NERDSpaceDelims=1               " space around delimiters
let NERDRemoveExtraSpaces=1
let g:NERDCustomDelimiters = {
    \ 'scss': { 'left': '//' }
\ }

" --- autocomplete / supertab / jscomplete ---
set infercase
set completeopt=longest,menuone
set omnifunc=syntaxcomplete#Complete
set completefunc=syntaxcomplete#Complete
set complete=.,w,b,u,U,t,i,d


" --- EasyMotion ---
let g:EasyMotion_leader_key = '<Leader>m'
" lets make <leader>F and <leader>f use easymotion by default
let g:EasyMotion_mapping_f = '<leader>f'
let g:EasyMotion_mapping_F = '<leader>F'

" --- Strip trailing whitespace ---
function! StripWhitespace ()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    :%s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfunction

" Trailing white space (strip spaces)
noremap <leader>ss :call StripWhitespace()<CR>

" --- vim-css-color ---
let g:cssColorVimDoNotMessMyUpdatetime = 1

" --- Command-T ---
let g:CommandTMaxFiles=2000
let g:CommandTMaxHeight=12
noremap <silent> <leader>tt :CommandT<CR>
noremap <silent> <leader>bt :CommandTBuffer<CR>
noremap <silent> <leader>tf :CommandTFlush<CR>

" --- toggle indentation mode ---
function! ToggleExpandTab()
    if &et
        set noet softtabstop=0
    else
        execute "set et softtabstop=". &tabstop
    endif
endfunction

" --- vim-airline ---
    
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='hybrid'
let g:airline_powerline_fonts=1
let g:airline_detect_paste=1
let g:airline_detect_spell=1
let g:airline_section_a = '%{getcwd()}'
let g:airline#extensions#tagbar#enabled = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" display open buffers in tabline
let g:airline#extensions#tabline#enabled = 1

" --- vim-php-namespace ---
inoremap <Leader>u <C-O>:call PhpInsertUse()<CR>
noremap <Leader>u :call PhpInsertUse()<CR>

" --- ctrlp ---
set runtimepath^=~/.vim/bundle/ctrlp.vim

" --- syntastic ---
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_javascript_checkers = ['jslint']
let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']
let g:syntastic_python_checkers = ['pylint']

let g:syntastic_enable_perl_checker = 1
let g:syntastic_aggregate_errors = 1


" -----------------------------------------------------------------------------
" UI
" -----------------------------------------------------------------------------

set t_Co=256                " 256 colors terminal
let g:molokai_original = 0
colorscheme molokai
" make 'var' keyword easier to spot
hi link javascriptType Keyword
" default ColorColumn is too distractive
hi clear ColorColumn
hi link ColorColumn FoldColumn
" defaul line number is too distractive
hi clear LineNr
hi link LineNr Comment
set binary
set noeol

"Enable coffescript
au BufNewFile,BufRead *.coffee set filetype=coffee

" File types
au BufNewFile,BufRead *.ctp set filetype=php shiftwidth=4 softtabstop=4 tabstop=4
au BufNewFile,BufRead *.phpt set filetype=php shiftwidth=4 softtabstop=4 tabstop=4
au BufNewFile,BufRead *.php set shiftwidth=4 softtabstop=4 tabstop=4
au BufNewFile,BufRead *.html set filetype=html.php shiftwidth=2 softtabstop=2 tabstop=2
au BufNewFile,BufRead *.twig set filetype=html.php shiftwidth=2 softtabstop=2 tabstop=2
au BufNewFile,BufRead *.phtml set filetype=html.php shiftwidth=2 softtabstop=2 tabstop=2
au BufNewFile,BufRead *.js set shiftwidth=2 softtabstop=2 tabstop=2
au BufNewFile,BufRead *.css set shiftwidth=2 softtabstop=2 tabstop=2

set cursorline cursorcolumn " Highlight current line and column
set laststatus=2            " Always show status line
set number                  " Enable line numbers.
set numberwidth=5           " width of numbers line (default on gvim is 4)
set report=0                " Show all changes.
set showmode                " Show the current mode.
set showcmd                 " show partial command on last line of screen.
set showmatch               " show matching parenthesis
set splitbelow splitright   " how to split new windows.
set title                   " Show the filename in the window title bar.

set encoding=utf-8   
set fileencoding=utf-8
set fillchars+=stl:\ ,stlnc:\
set rop=type:directx,gamma:1.0,contrast:0.5,level:1,geom:1,renmode:4,taamode:1

if has("gui_running")
   set lines=53 columns=122
   let s:uname = system("uname")
   set guifont=Monospace\ 11 
endif

" --- command completion ---
set wildmenu                " Hitting TAB in command mode will
set wildchar=<TAB>          "   show possible completions.
set wildmode=list:longest
set wildignore+=*.DS_STORE,*.db,node_modules/**,*.jpg,*.png,*.gif

" --- Tabular.vim ---
vmap <silent> <leader>t: :Tabularize /:<CR>
nmap <silent> <leader>t: :Tabularize /:<CR>
vmap <silent> <leader>t= :Tabularize /=<CR>
nmap <silent> <leader>t= :Tabularize /=<CR>
vmap <silent> <leader>t, :Tabularize /,<CR>
nmap <silent> <leader>t, :Tabularize /,<CR>
vmap <silent> <leader>t{ :Tabularize /{<CR>
nmap <silent> <leader>t{ :Tabularize /{<CR>
vmap <silent> <leader>t" :Tabularize /"<CR>
nmap <silent> <leader>t" :Tabularize /"<CR>
vmap <silent> <leader>t' :Tabularize /'<CR>
nmap <silent> <leader>t' :Tabularize /'<CR>
vmap <silent> <leader>t[ :Tabularize /[<CR>
nmap <silent> <leader>t[ :Tabularize /[<CR>
vmap <silent> <leader>t/ :Tabularize /\/\/<CR>
nmap <silent> <leader>t/ :Tabularize /\/\/<CR>
vmap <silent> <leader>t\| :Tabularize /\|<CR>
nmap <silent> <leader>t\| :Tabularize /\|<CR>

" -----------------------------------------------------------------------------
" KEY MAPPINGS
" -----------------------------------------------------------------------------

" no replace past
xnoremap p pgvy

" avoid mistyping commands
command! W w
command! Wq wq
command! Bd bd

" hotkey to close window
nnoremap q :q<enter>


" Split line (sister to [J]oin lines)
" The normal use of S is covered by cc, so don't worry about shadowing
nnoremap S i<cr><esc><right>

" movement by screen line instead of file line (for text wrap)
nnoremap j gj
nnoremap <down> gj
nnoremap k gk
nnoremap <up> gk

" next and previus tab
nnoremap <C-Tab> :tabn<CR>
nnoremap <C-S-Tab> :tabp<CR>

" automatic esc, really uncommon to type jj,jk
inoremap jj <ESC>
inoremap jk <Esc>

" Faster scrolling
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Bubble single lines, similar to Eclipse (requires unimpaired.vim)
nmap <C-Up> [e
nmap <C-Down> ]e

" Bubble multiple lines, similar to Eclipse (requires unimpaired.vim)
vmap <C-Up> [egv
vmap <C-Down> ]egv

" Duplicate lines, similar to Eclipse
noremap <C-S-Up> YP
noremap <C-S-Down> YP

" activate visual mode in normal mode
nmap <S-Up> V
nmap <S-Down> V

" these are mapped in visual mode
vmap <S-Up> k
vmap <S-Down> j

" Move between splits (windows)
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" tagbar
nmap <silent> <C-g> :TagbarToggle<CR>

" Tab buffers navigation like Firefox.
nmap <silent> <C-Tab> :bnext<CR>
nmap <silent> <C-S-Tab> :bprevious<CR>

" Remap code completion to Ctrl+Space
inoremap <C-Space> <C-x><C-o>

if has('nvim')
    let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
" Hack to get C-h working in neovim
    nmap <BS> <C-W>h
    tnoremap <Esc> <C-\><C-n>
endif

" Use CTRL-S for saving, also in Insert mode
noremap <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <C-O>:update<CR>


" -----------------------------------------------------------------------------
"  INDENTATION AND TEXT-WRAP
" -----------------------------------------------------------------------------

set expandtab                   " Expand tabs to spaces
set autoindent smartindent      " auto/smart indent
set copyindent                  " copy previous indentation on auto indent
set softtabstop=4               " Tab key results in # spaces
set tabstop=4                   " Tab is # spaces
set shiftwidth=4                " The # of spaces for indenting.
set smarttab                    " At start of line, <Tab> inserts shift width spaces, <Bs> deletes shift width spaces.
set nowrap                      " don't break lines
set textwidth=79
set colorcolumn=+1              " Show large lines
set formatoptions=qrn1          " automatic formating.
set formatoptions-=o            " don't start new lines w/ comment leader on pressing 'o'
set nomodeline                  " don't use modeline (security)
set pastetoggle=<leader>p       " paste mode: avoid auto indent, treat chars as literal.

set incsearch                   " Search text in real time, while and ' keyboard
set ic                          " No difference plus / Tiny
set magic                       " uses ' magic ' to search for text =)
set bs=indent,eol,start
set ruler                       " shows the row and column in the statusbar
set title                       " shows the file name in the terminal title
set smartindent
set autoindent
set ts=4                        " Tab = 4 white

set sm                          " It shows the last couple of closed parenthesis
set wildmode=longest,list       " Show completions when using the TAB
set showmode
set showcmd                     " shows incomletos command (mark character , etc. )
set shortmess=atI               " abbreviated messages
set et sm js

