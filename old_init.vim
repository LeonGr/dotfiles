set nocompatible  " be iMproved, required
filetype off      " required

"########################= Plugins =###############################
call plug#begin()
"Tweaks
Plug 'tpope/vim-surround'               " Wrap text easily
Plug 'bling/vim-airline'                " Good looking information bar
Plug 'mattn/emmet-vim'                  " html autocomplete
Plug 'terryma/vim-multiple-cursors'     " Sublime text like cursors
Plug 'jiangmiao/auto-pairs'             " auto pair brackets and quotes
Plug 'scrooloose/nerdtree'              " File browser in vim
Plug 'jistr/vim-nerdtree-tabs'          " Keep nerdtree open across tabs
Plug 'scrooloose/nerdcommenter'         " Easy commenting and uncommenting
Plug 'kien/ctrlp.vim'                   " Great file browser
Plug 'tpope/vim-obsession'              " Save vim sessions
Plug 'mkitt/tabline.vim'                " Show tabs vim
Plug 'christoomey/vim-tmux-navigator'   " Navigate tmux windows using hjkl
Plug 'Valloric/YouCompleteMe'           " Vim autocomplete
Plug 'unblevable/quick-scope'           " Highlight words when you press f or t
Plug 'chip/vim-fat-finger'              " Series of abbreviations for vim
Plug 'tpope/vim-repeat'                 " Repeat more than one command
Plug 'godlygeek/tabular'                " Easy text align

" Syntax specific
Plug 'pangloss/vim-javascript'          " Javascript support
Plug 'ap/vim-css-color'                 " Show css colors in files
Plug 'digitaltoad/vim-jade'             " Jade support
Plug 'darthmall/vim-vue'                " VueJS support
Plug 'cakebaker/scss-syntax.vim'        " SCSS support
Plug 'nathanaelkane/vim-indent-guides'  " Indentation guides
Plug 'scrooloose/syntastic'             " Syntax checker
Plug 'marijnh/tern_for_vim'             " Javascript completion for YouCompleteme

" Themes
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'flazz/vim-colorschemes'
Plug 'altercation/vim-colors-solarized'
Plug 'jdkanani/vim-material-theme'
Plug 'nanotech/jellybeans.vim'
Plug 'morhetz/gruvbox'
Plug 'marcopaganini/termschool-vim-theme'
call plug#end()

"########################= Settings =###############################
set mouse=a                                          " Enable scrolling
set showcmd                                          " Show commands as they're typed
set cursorline                                       " Current line

" Color configurations
syntax enable                                        " Enable syntax highlighting
set t_Co=256                                         " Set 256 color support
set background=dark                                  " Set background
colorscheme preto                                    " Set colorscheme

" Line number configurations
set number                                           " Show line numbers
highlight LineNr cterm=none ctermfg=31 ctermbg=none  " Give current line a color
highlight CursorLineNR cterm=none ctermfg=white      " Give current line number a color
hi CursorLine ctermfg=NONE                           " Keep syntax highlighting in current line

" Commands and shortcuts
inoremap jk <ESC>
inoremap jj <ESC>

" Searching improvements
set incsearch                                        " Lookahead as search pattern is specified
set ignorecase                                       " Ignore case in all searches...
set smartcase                                        " ...unless uppercase letters used

set hlsearch                                         " Highlight all matches
highlight clear Search
highlight       Search    ctermfg=White
nmap <silent> <BS> :nohlsearch<CR>                   " Backspace to turn of highlight Searching

set undofile                                         " Enable persistent undo
set undodir=/home/leon/.vimundo/                     " set a directory to store the undo history

set backspace=2                                      " Use backspace

set autoindent                                       " Retain indentation on next line
set smartindent                                      " Turn on autoindenting of blocks

" STOP USING ARROWS
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

"########################= Leader commands =###############################
let mapleader = " \<Space>"
nnoremap <Leader>w :w<CR>
" Leader w to save
nnoremap <Leader>q :q!<CR>
" Leader q to force quit
nnoremap <Leader>x :x<CR>
" Leader x to save and quit
nnoremap <Leader>t <C-w><C-w>
" Leader t to go to next tab
nnoremap <Leader>n <plug>NERDTreeTabsToggle<CR>
" Leader n to toggle nerdtree
nnoremap <Leader>f :CtrlP<CR>
" Leader f to open CtrlP

"########################= Plugin specific Settings =###############################
" Indentguide settings
set ts=4 sw=4 et
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 1
let g:indent_guides_auto_colors = 0
hi IndentGuidesOdd  ctermbg=grey
hi IndentGuidesEven ctermbg=darkgrey
let g:indent_guides_color_change_percent = 50

" Quickscope settings
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
let g:qs_second_occurrence_highlight_color = 81
let g:qs_first_occurrence_highlight_color = 155

" settings for airline
set guifont=Inconsolata\ for\ Powerline:h15
set laststatus=2
set termencoding=utf-8
let g:airline_powerline_fonts=1
let g:airline_theme='murmur'
let g:airline#extensions#tabline#enabled = 1               " Enable the list of buffers
let g:airline#extensions#tabline#fnamemod = ':t'           " Show just the filename

" settings for syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" CtrlP settings
set wildignore+=*/tmp/*,*.so,*.swp,*.zip                   " Ignore these filetypes
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'  " Ignore these dirs

" Auto-pairs settings
let g:AutoPairsMultilineClose = 0
let g:AutoPairsFlyMode = 0

" autocompile .scss file
" autocmd BufNewFile,BufRead *.scss autocmd BufWritePost * !scss -t uncompressed style.scss style.css
if has("unix")
    let s:uname = system("uname -s")
    if s:uname == " Darwin"
        " Do Mac stuff here
        augroup reload_vimrc " {
            autocmd!
            autocmd BufWritePost $MYVIMRC source $MYVIMRC
        augroup END " }
    endif
endif
