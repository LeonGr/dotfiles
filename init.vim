set nocompatible " be iMproved, required
filetype off     " required

" Plugins YOU'RE USING VIMPLUG YOU DUMBASS
call plug#begin()
"Tweaks
Plug 'tpope/vim-surround'              " Wrap text easily
Plug 'bling/vim-airline'               " Good looking information bar
Plug 'bling/vim-bufferline'            " Buffers in airline
Plug 'vim-airline/vim-airline-themes'  " More themes for airline
Plug 'mattn/emmet-vim'                 " html autocomplete
Plug 'terryma/vim-multiple-cursors'    " Sublime text like cursors
Plug 'scrooloose/nerdtree'             " File browser in vim
Plug 'jistr/vim-nerdtree-tabs'         " Keep nerdtree open across tabs
Plug 'scrooloose/nerdcommenter'        " Easy commenting and uncommenting
Plug 'kien/ctrlp.vim'                  " Great file browser
Plug 'tpope/vim-obsession'             " Save vim sessions
Plug 'mkitt/tabline.vim'               " Show tabs vim
Plug 'christoomey/vim-tmux-navigator'  " Navigate tmux windows using hjkl
Plug 'Valloric/YouCompleteMe'          " Vim autocomplete
Plug 'unblevable/quick-scope'          " Higlight words when you press f or t
Plug 'chip/vim-fat-finger'             " Series of abbreviations for vim
Plug 'tpope/vim-repeat'                " Repeat more than one command
Plug 'godlygeek/tabular'               " Easy text align
Plug 'tpope/vim-endwise'               " Auto close stuff
Plug 'rking/ag.vim'                    " Search through files and directories
Plug 'takac/vim-hardtime'              " Help me to stop using jjjj

" Syntax specific
Plug 'pangloss/vim-javascript'         " Javascript support
Plug 'ap/vim-css-color'                " Show css colors in files
Plug 'digitaltoad/vim-jade'            " Jade support
Plug 'cakebaker/scss-syntax.vim'       " SCSS support
Plug 'nathanaelkane/vim-indent-guides' " Indentation guides
Plug 'scrooloose/syntastic'            " Syntax checker
Plug 'marijnh/tern_for_vim'            " Javascript completion for YouCompleteme

" Themes
Plug 'vim-airline/vim-airline-themes'
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'flazz/vim-colorschemes'
Plug 'altercation/vim-colors-solarized'
Plug 'jdkanani/vim-material-theme'
Plug 'nanotech/jellybeans.vim'
Plug 'morhetz/gruvbox'
Plug 'marcopaganini/termschool-vim-theme'
Plug 'godlygeek/csapprox'
Plug 'jacoborus/tender'
call plug#end()

" scrolling
set mouse=a

" Show commands as they're typed
set showcmd

" Current line
set cursorline

" Color configurations
if (has("termguicolors"))
 set termguicolors
endif

syntax enable
set t_Co=256
set background=dark
"let g:solarized_termcolors=256
colorscheme tender

" Line numbers
set number
highlight LineNr cterm=none ctermfg=239 ctermbg=235
highlight CursorLineNR cterm=none ctermfg=white ctermbg=032
hi CursorLine ctermfg=NONE

" Indentguide settings
set ts=4 sw=4 et
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 1
let g:indent_guides_auto_colors = 0
hi IndentGuidesOdd  ctermbg=white
hi IndentGuidesEven ctermbg=blue
let g:indent_guides_color_change_percent = 50

let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
let g:qs_second_occurrence_highlight_color = 81
let g:qs_first_occurrence_highlight_color = 155


" Leader commands
let mapleader = "\<Space>"
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q!<CR>
nnoremap <Leader>x :x<CR>
nnoremap <Leader>t :bnext<CR>
nnoremap <Leader>y :bprev<CR>
vnoremap <Leader>c :'<,'>w !pbcopy<CR><CR>
nnoremap <Leader>s :vertical resize 120<CR>
map <Leader>n <plug>NERDTreeTabsToggle<CR>
nnoremap <Leader>f :CtrlP<CR>
nnoremap <Leader>; g;
nnoremap <Leader>, g,

" Commands and shortcuts
inoremap jk <ESC>
inoremap jj <ESC>

map w!! :w !sudo tee %<CR>

" settings for airline
set guifont=Inconsolata\ for\ Powerline:h15
set laststatus=2
set termencoding=utf-8
let g:airline_powerline_fonts=1
let g:airline_theme='tender'

" Hide buffers
set showtabline=0
let g:bufferline_echo = 0

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" CtrlP settings
set wildignore+=*/tmp/*,*.so,*.swp,*.zip " Ignore these filetypes
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git' " Ignore these dirs

" Searching improvements
set incsearch       "Lookahead as search pattern is specified
set ignorecase      "Ignore case in all searches...
set smartcase       "...unless uppercase letters used

set hlsearch        "Highlight all matches
highlight clear Search
highlight       Search    ctermfg=Black ctermbg=White
nmap <silent> <BS> :nohlsearch<CR> " Backspace to turn of highlight Searching
let g:AutoPairsFlyMode = 0
" Use undofile for persistent undo
set undofile
" set a directory to store the undo history
set undodir=~/.vimundo/

" change size of tab
" use backspace
set backspace=2

" Auto-pairs settings
let g:AutoPairsMultilineClose = 0

set autoindent "Retain indentation on next line
set smartindent "Turn on autoindenting of blocks

" STOP USING ARROWS
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" scripts
" autocompile .scss file
" autocmd BufNewFile,BufRead *.scss autocmd BufWritePost * !scss -t uncompressed style.scss style.css
if has("unix")
    let s:uname = system("uname -s")
    if s:uname == "Darwin"
         augroup reload_vimrc " {
            autocmd!
            autocmd BufWritePost $MYVIMRC source $MYVIMRC
        augroup END " }   " Do Mac stuff here
    endif
endif

" Clear trailing whitespace in selected file types on save
autocmd BufWritePre * :%s/\s\+$//e
