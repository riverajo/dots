set nocompatible              " Don't be compatible with vi
filetype on                   " try to detect filetypes

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
Plugin 'tpope/vim-fugitive'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'ervandew/supertab'
Plugin 'scrooloose/syntastic'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'msanders/snipmate.vim'
Plugin 'tpope/vim-surround'
Plugin 'vim-scripts/Gundo'
Plugin 'phleet/vim-mercenary'
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'saltstack/salt-vim'
Plugin 'wookiehangover/jshint.vim'
Plugin 'flazz/vim-colorschemes'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'nvie/vim-flake8'
Plugin 'wikitopian/hardmode'


let g:HardMode_level = 'wannabe'
autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()


" ctrl-jklm  changes to that split
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h


" ==========================================================
" Basic Settings
" ==========================================================
syntax on                     " syntax highlighing
filetype indent plugin on     " enable loading indent file for filetype
set numberwidth=1             " using only 1 column (and 1 space) while possible
set title                     " show title in console title bar

set wildmenu                  " Menu completion in command mode on <Tab>
set wildmode=full             " <Tab> cycles between all matching choices.
let mapleader = ","
map <Leader>n <plug>NERDTreeTabsToggle<CR>

" don't bell or blink
set noerrorbells
set novisualbell
set vb t_vb=
" Don't redraw while executing macros (good performance config)
set lazyredraw

" Ignore these files when completing
set wildignore+=*.o,*.obj,.git,*.pyc
set wildignore+=eggs/**
set wildignore+=*.egg-info/**


" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>

""" Insert completion
" don't select first item, follow typing in autocomplete
set completeopt=menuone,longest,preview
set pumheight=6             " Keep a small completion window


""" Moving Around/Editing
set cursorline                 " have a line indicate the cursor location
set ruler                      " show the cursor position all the time
set nostartofline              " Avoid moving cursor to BOL when jumping around
set virtualedit=block          " Let cursor move past the last char in <C-v> mode
set scrolloff=3                " Keep 3 context lines above and below the cursor
set backspace=indent,eol,start " Allow backspacing over autoindent, EOL, and BOL
set showmatch                  " Briefly jump to a paren once it's balanced
set nowrap                     " don't wrap text
set linebreak                  " don't wrap text in the middle of a word
set autoindent                 " always set autoindenting on
set tabstop=4                  " <tab> inserts 4 spaces
set shiftwidth=4               " but an indent level is 2 spaces wide.
set softtabstop=4              " <BS> over an autoindent deletes both spaces.
set expandtab                  " Use spaces, not tabs, for autoindent/tab key.
set shiftround                 " rounds indent to a multiple of shiftwidth
set matchpairs+=<:>            " show matching <> (html mainly) as well
set foldmethod=syntax          " allow us to fold on indents
set foldlevel=10               " don't fold by default
set number                     " show line numbers
set relativenumber

"""" Reading/Writing
set noautowrite             " Never write a file unless I request it.
set noautowriteall          " NEVER.
set noautoread              " Don't automatically re-read changed files.
set modeline                " Allow vim options to be embedded in files;
set modelines=5             " they must be within the first or last 5 lines.
set encoding=utf8           " Set utf8 as standard encoding.
set ffs=unix,dos,mac        " Try recognizing dos, unix, and mac line endings.
set spell spelllang=en_us   " Spell checking
" displays tabs with :set list & displays when a line runs off-screen
set listchars=tab:>-,eol:$,trail:-,precedes:<,extends:>
set nolist
set pastetoggle=<F1>          " Use <F1> to toggle between 'paste' and 'nopaste'
map <silent> <F2> :NERDTreeToggle<CR>
" toggle line numbers for pasting out of vim.
map <silent> <F3> :set number!<CR>:set relativenumber!<CR>
map <silent> <F4> :setlocal spell! spelllang=en_us<CR>
" Reload Vimrc
map <silent> <F5> :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

""" Searching and Patterns
set ignorecase              " Default to using case insensitive searches,
set smartcase               " unless uppercase letters are used in the regex.
set smarttab                " Handle tabs more intelligently
set hlsearch                " Highlight searches by default.
set incsearch               " Incrementally search while typing a /regex
set magic                   " For regular expressions turn magic on


" Paste from clipboard
map <leader>p "+p

" Quit window on <leader>q
nnoremap <leader>q :q<CR>
"
" hide matches on space
nnoremap <space> :nohlsearch<cr>

" Remove trailing whitespace on <leader>S
nnoremap <leader>S :%s/\s\+$//<cr>:let @/=''<CR>

" python with virtualenv support

py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF

" Load up virtualenv's vimrc if it exists
if filereadable($VIRTUAL_ENV . '/.vimrc')
    source $VIRTUAL_ENV/.vimrc
endif

" dunno why I can't use matchadd for trailing whitespace....?
highlight ExtraWhitespace ctermbg=darkgreen ctermfg=white guibg=darkgreen
match ExtraWhitespace /\s\+\%#\@<!$/
highlight OverLength ctermbg=red ctermfg=white guibg=red
call matchadd('OverLength', '\%>80v.\+')
set colorcolumn=80
colorscheme badwolf
set background=dark

nnoremap th  :tabfirst<CR>
nnoremap tj  :tabnext<CR>
nnoremap tk  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap tt  :tabedit<Space>
nnoremap tn  :tabnext<Space>
nnoremap tm  :tabm<Space>
nnoremap td  :tabclose<CR>
set rtp+=/usr/lib/python2.7/site-packages/powerline/bindings/vim
" Always show statusline
" It's useful to show the buffer number in the status line.
set laststatus=2 statusline=%02n:%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P

set t_Co=256
autocmd FileType java setlocal shiftwidth=2 tabstop=2
autocmd FileType cpp setlocal shiftwidth=2 tabstop=2
let g:syntastic_aggregate_errors = 1

" Mappings to access buffers (don't use "\p" because a
" delay before pressing "p" would accidentally paste).
" \l       : list buffers
" \b \f \g : go back/forward/last-used
" \1 \2 \3 : go to buffer 1/2/3 etc
nnoremap <Leader>l :ls<CR>
nnoremap <Leader>b :bp<CR>
nnoremap <Leader>f :bn<CR>
nnoremap <Leader>g :e#<CR>
nnoremap <Leader>1 :1b<CR>
nnoremap <Leader>2 :2b<CR>
nnoremap <Leader>3 :3b<CR>
nnoremap <Leader>4 :4b<CR>
nnoremap <Leader>5 :5b<CR>
nnoremap <Leader>6 :6b<CR>
nnoremap <Leader>7 :7b<CR>
nnoremap <Leader>8 :8b<CR>
nnoremap <Leader>9 :9b<CR>
nnoremap <Leader>0 :10b<CR>
