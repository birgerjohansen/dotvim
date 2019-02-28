filetype off
set nocompatible

" VUNDLE
" ======
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'fholgado/minibufexpl.vim'
Plugin 'nvie/vim-flake8'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'dhruvasagar/vim-table-mode'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdcommenter'
"Plugin 'scrooloose/nerdtree'
Plugin 'davidhalter/jedi-vim'
Plugin 'ervandew/supertab'
Plugin 'jnurmine/Zenburn'
Plugin 'vim-python/python-syntax'
Plugin 'ctrlpvim/ctrlp.vim'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins

set statusline=%<%f\ %h%m%r%=%-20.(line=%l,col=%c%V,totlin=%L%)\%h%m%r%=%-40(,bytval=0x%B,%n%Y%)\%P

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
nnoremap <leader>7 :SyntasticCheck<CR> :SyntasticToggleMode<CR>

""NERDTree
"map <C-n> :NERDTreeToggle<CR>
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" BASIC
set encoding=utf-8
set modelines=0
set autoindent
set showmode
set showcmd
set hidden
set visualbell
set ttyfast
set ruler
set backspace=indent,eol,start
set nonumber
set norelativenumber
set laststatus=2
set history=1000

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.

set undodir=~/.vim/tmp/undo
set undofile
set backup
set backupdir=~/.vim/tmp/backup

set list
" set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
set listchars=tab:▸\ ,extends:❯,precedes:❮
set shell=/bin/bash\ --login
set lazyredraw
set matchtime=3
set showbreak=↪
" set splitbelow
" set splitright
set fillchars=diff:⣿,vert:│
set autowrite
set autoread
set shiftround
set title
set linebreak
set dictionary=/usr/share/dict/words
set spellfile=~/.vim/custom-dictionary.utf-8.add
" set colorcolumn=+1

" Resize splits when the window is resized
au VimResized * :wincmd =

" Time out on key codes but not mappings.
" Basically this makes terminal Vim work sanely.
"set notimeout
"set ttimeout
"set ttimeoutlen=10

" Copying text to the system clipboard.
set clipboard=unnamed

" SWAP
set noswapfile
set nobackup
set nowb

" LEADER
let mapleader = ","
let maplocalleader = "\\"

" MAPPINGS
noremap j gj
noremap k gk
noremap gj j
noremap gk k

" Easy buffer navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

noremap <leader>v <C-w>v

" Spell
map  :w!<CR>:!aspell check %<CR>:e! %<CR>

" SUPERTAB
let g:SuperTabDefaultCompletionType = "<c-n>"
let g:SuperTabLongestHighlight = 1
let g:SuperTabCrMapping = 1

"TABLE MODE
let g:table_mode_corner = '|'

"ULTISNIPS
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:ultisnips_python_style="numpy"

" COMPLETION
set complete=.,w,b,u,t
"set completeopt=longest,menuone,preview

" TABS, SPACES, WRAPPING
set tabstop=8
set shiftwidth=4
set softtabstop=4
set expandtab
set wrap
set textwidth=80
set formatoptions=qrn1

" COLORS
set background=dark
syntax on
hi SpellBad ctermfg=015 ctermbg=160
colorscheme solarized
let g:python_highlight_all = 1

" FOLDING
set foldmethod=indent
set foldlevel=99

" RUNTIME
runtime macros/matchit.vim

" FILETYPES
augroup ft_python
    au!
    "au FileType python set omnifunc=pythoncomplete#Complete

    au FileType python setlocal define=^\s*\\(def\\\\|class\\)
    au FileType python setlocal formatprg=autopep8\ -
    au FileType man nnoremap <buffer> <cr> :q<cr>

    " Jesus tapdancing Christ, built-in Python syntax, you couldn't let me
    " override this in a normal way, could you?
    au FileType python if exists("python_space_error_highlight") | unlet python_space_error_highlight | endif

    " Jesus, Python.  Five characters of punctuation for a damn string?
    au FileType python inoremap <buffer> <c-g> _(u'')<left><left>

    au FileType python inoremap <buffer> <c-b> """"""<left><left><left>

    au FileType python iabbrev <buffer> afo assert False, "Okay"
augroup END

augroup ft_epub
    au BufReadCmd   *.epub      call zip#Browse(expand("<amatch>"))
augroup END

" augroup ft_vim
"     au!
" 
"     au FileType vim setlocal foldmethod=marker
"     au FileType help setlocal textwidth=78
"     au BufWinEnter *.txt if &ft == 'help' | wincmd L | endif
" augroup END

augroup ft_markdown
    au!

    au BufNewFile,BufRead *.m*down setlocal filetype=markdown
    au BufNewFile,BufRead *.md setlocal filetype=markdown

    " Use <localleader>1/2/3 to add headings.
    au Filetype markdown nnoremap <buffer> <localleader>1 yypVr=:redraw<cr>
    au Filetype markdown nnoremap <buffer> <localleader>2 yypVr-:redraw<cr>
    au Filetype markdown nnoremap <buffer> <localleader>3 mzI###<space><ESC>`zllll
augroup END

augroup ft_taskjuggler
    au BufNewFile,BufRead *.tjp,*.tji               setf tjp
augroup END

" QUICK EDITING
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>ed :e ~/.vim/custom-dictionary.utf-8.add<cr>
nnoremap <leader>em :e ~/.mutt/muttrc<cr>
nnoremap <leader>eb :e ~/.bashrc<cr>

" AT THE END
filetype on                          " try to detect file types
