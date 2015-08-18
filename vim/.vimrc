set nocompatible              " Don't be compatible with vi
filetype on                   " try to detect filetypes

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'ervandew/supertab'
Bundle 'scrooloose/syntastic'
Bundle 'jistr/vim-nerdtree-tabs'
Bundle 'msanders/snipmate.vim'
Bundle 'tpope/vim-surround'
Bundle 'vim-scripts/Gundo'
Bundle 'phleet/vim-mercenary'
Bundle 'hynek/vim-python-pep8-indent'
Bundle 'saltstack/salt-vim'
Bundle "wookiehangover/jshint.vim"
Plugin 'flazz/vim-colorschemes'



" Reload Vimrc
map <silent> <F5> :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>


" ctrl-jklm  changes to that split
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h


" ==========================================================
" Basic Settings
" ==========================================================
syntax enable                     " syntax highlighing
filetype plugin indent on     " enable loading indent file for filetype
filetype indent on
set numberwidth=1             " using only 1 column (and 1 space) while possible
set background=dark           " We are using dark background in vim
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
set cursorline              " have a line indicate the cursor location
set ruler                   " show the cursor position all the time
set nostartofline           " Avoid moving cursor to BOL when jumping around
set virtualedit=block       " Let cursor move past the last char in <C-v> mode
set scrolloff=3             " Keep 3 context lines above and below the cursor
set backspace=2             " Allow backspacing over autoindent, EOL, and BOL
set showmatch               " Briefly jump to a paren once it's balanced
set nowrap                  " don't wrap text
set linebreak               " don't wrap textin the middle of a word
set autoindent              " always set autoindenting on
set smartindent             " use smart indent if there is no indent file
set tabstop=4               " <tab> inserts 4 spaces
set shiftwidth=4            " but an indent level is 2 spaces wide.
set softtabstop=4           " <BS> over an autoindent deletes both spaces.
set expandtab               " Use spaces, not tabs, for autoindent/tab key.
set shiftround              " rounds indent to a multiple of shiftwidth
set matchpairs+=<:>         " show matching <> (html mainly) as well
set foldmethod=syntax       " allow us to fold on indents
set foldlevel=10            " don't fold by default
set number                  " show line numbers

" don't outdent hashes
"inoremap # #

"""" Reading/Writing
set noautowrite             " Never write a file unless I request it.
set noautowriteall          " NEVER.
set noautoread              " Don't automatically re-read changed files.
set modeline                " Allow vim options to be embedded in files;
set modelines=5             " they must be within the first or last 5 lines.
set encoding=utf8           " Set utf8 as standard encoding.
set ffs=unix,dos,mac        " Try recognizing dos, unix, and mac line endings.

" displays tabs with :set list & displays when a line runs off-screen
set listchars=tab:>-,eol:$,trail:-,precedes:<,extends:>
set nolist

""" Searching and Patterns
set ignorecase              " Default to using case insensitive searches,
set smartcase               " unless uppercase letters are used in the regex.
set smarttab                " Handle tabs more intelligently
set hlsearch                " Highlight searches by default.
set incsearch               " Incrementally search while typing a /regex
set magic                   " For regular expressions turn magic on

colorscheme default

" Paste from clipboard
map <leader>p "+p

" Quit window on <leader>q
nnoremap <leader>q :q<CR>
"
" hide matches on space
nnoremap <space> :nohlsearch<cr>

" Remove trailing whitespace on <leader>S
nnoremap <leader>S :%s/\s\+$//<cr>:let @/=''<CR>

" Add the virtualenv's site-packages to vim path
python << EOF
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

hi Pmenu guifg=green guibg=darkgray gui=NONE ctermfg=green ctermbg=darkgray cterm=NONE
hi PmenuSel guifg=green guibg=black gui=NONE ctermfg=green ctermbg=black cterm=NONE
hi DiffAdd term=reverse cterm=bold ctermbg=darkgreen ctermfg=black
hi DiffChange term=reverse cterm=bold ctermbg=darkblue ctermfg=black
hi DiffText term=reverse cterm=bold ctermbg=lightgray ctermfg=black
hi DiffDelete term=reverse cterm=bold ctermbg=darkred ctermfg=black
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/
set colorcolumn=80
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+\%#\@<!$/

nnoremap th  :tabfirst<CR>
nnoremap tj  :tabnext<CR>
nnoremap tk  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap tt  :tabedit<Space>
nnoremap tn  :tabnext<Space>
nnoremap tm  :tabm<Space>
nnoremap td  :tabclose<CR>
map <F2> :NERDTreeToggle<CR>
set rtp+=/usr/lib/python2.7/site-packages/powerline/bindings/vim
" Always show statusline
set laststatus=2

set t_Co=256
autocmd FileType java setlocal shiftwidth=2 tabstop=2
autocmd FileType cpp setlocal shiftwidth=2 tabstop=2
