set nocompatible " be iMproved, required
filetype off     " required

" Plugins YOU'RE USING VIMPLUG YOU DUMBASS
call plug#begin()

"Tweaks
Plug 'tpope/vim-surround'              " Wrap text easily
Plug 'vim-airline/vim-airline-themes'  " More themes for airline
Plug 'mattn/emmet-vim'                 " html autocomplete
Plug 'scrooloose/nerdtree'             " File browser in vim
Plug 'jistr/vim-nerdtree-tabs'         " Keep nerdtree open across tabs
Plug 'scrooloose/nerdcommenter'        " Easy commenting and uncommenting
Plug 'kien/ctrlp.vim'                  " Great file browser
Plug 'tpope/vim-obsession'             " Save vim sessions
Plug 'christoomey/vim-tmux-navigator'  " Navigate tmux windows using hjkl
Plug 'unblevable/quick-scope'          " Higlight words when you press f or t
Plug 'chip/vim-fat-finger'             " Series of abbreviations for vim
Plug 'tpope/vim-repeat'                " Repeat more than one command
Plug 'godlygeek/tabular'               " Easy text align
Plug 'tpope/vim-endwise'               " Auto close stuff
Plug 'rking/ag.vim'                    " Search through files and directories
Plug 'takac/vim-hardtime'              " Help me to stop using jjjj
Plug 'airblade/vim-gitgutter'          " Show git changes
Plug 'jiangmiao/auto-pairs'            " Auto pairs
Plug 'majutsushi/tagbar'               " Show tags
Plug 'roxma/nvim-completion-manager'   " Completion
Plug 'davidhalter/jedi-vim'            " Python completion
Plug 'othree/csscomplete.vim'          " CSS completion
Plug 'roxma/nvim-cm-tern',  {'do': 'npm install'} " JS completion
Plug 'takac/vim-hardtime'              " Don't repeat yourself
Plug 'KabbAmine/vCoolor.vim'           " Colour picker
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'                " Fuzzy finder

" Syntax specific
Plug 'pangloss/vim-javascript'         " Javascript support
Plug 'ap/vim-css-color'                " Show css colors in files
Plug 'digitaltoad/vim-jade'            " Jade support
Plug 'cakebaker/scss-syntax.vim'       " SCSS support
Plug 'nathanaelkane/vim-indent-guides' " Indentation guides
Plug 'scrooloose/syntastic'            " Syntax checker
Plug 'keith/swift.vim'                 " Swift syntax and indent styles
Plug 'posva/vim-vue'                   " Vue syntax


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
Plug 'endel/vim-github-colorscheme'
Plug 'larsbs/vimterial'
Plug 'bcicen/vim-vice'
Plug 'dylanaraps/wal.vim'
call plug#end()

" scrolling
set mouse=a
set guicursor=

" Show commands as they're typed
set showcmd

" Current line
set cursorline

" Hide ugly file name thing
set laststatus=0

" Show substitute in real time
set inccommand=nosplit

" Color configurations
if (has("termguicolors"))
 set termguicolors
endif

" Enable true color in neovim
let $NVIM_TUI_ENABLE_TRUE_COLOR = 1

" Color settings
syntax enable
set t_Co=256
set background=light
colorscheme molokai


" Line numbers
set number
highlight CursorLineNR guibg=NONE guifg=#BB1B46

" Indentguide settings
set ts=4 sw=4 et
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 1
let g:indent_guides_auto_colors = 0
hi IndentGuidesOdd  ctermbg=white
hi IndentGuidesEven ctermbg=blue

hi IndentGuidesOdd  guibg=#FFFFFF
hi IndentGuidesEven guibg=#CCCCCC
let g:indent_guides_color_change_percent = 50

let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
let g:qs_second_occurrence_highlight_color = '#57c7ff'
let g:qs_first_occurrence_highlight_color = '#5af78e'


" Leader commands
let mapleader = "\<Space>"

nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q!<CR>
nnoremap <Leader>x :x<CR>
nnoremap <Leader>t :b#<CR>
vnoremap <Leader>c :'<,'>w !pbcopy<CR><CR>
nnoremap <Leader>s :vertical resize 120<CR>
nnoremap <Leader>; g;
nnoremap <Leader>, g,
nnoremap <Leader>e :TagbarToggle<cr>
map <Leader>n <plug>NERDTreeTabsToggle<CR>
nnoremap <Leader>p :Files<cr>
nnoremap <Leader>f :Lines<cr>
nnoremap <Leader>/ :BLines<cr>


" Commands and shortcuts
inoremap jk <ESC>
inoremap jj <ESC>

map w!! :w !sudo tee %<CR>

" Syntastic settings
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" CtrlP settings
set wildignore+=*/tmp/*,*.so,*.swp,*.zip " Ignore these filetypes
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git' " Ignore these dirs

" Tern for vim settings
let g:tern_show_argument_hints='on_hold'
let g:tern_map_keys=1

" Searching improvements
set incsearch       "Lookahead as search pattern is specified
set ignorecase      "Ignore case in all searches...
set smartcase       "...unless uppercase letters used

set hlsearch        "Highlight all matches
"highlight clear Search
highlight       Search    guifg=#000000 guibg=#FFFFFF
nmap <silent> <BS> :nohlsearch<CR> " Backspace to turn of highlight Searching

" Use undofile for persistent undo
set undofile
" set a directory to store the undo history
set undodir=~/.vimundo/

" use backspace
set backspace=2

" Nerd Tree settings
let g:nerdtree_tabs_open_on_gui_startup = 0

" Auto pairs settings
let g:AutoPairsShortcutToggle = ''

"vCoolor settings
let g:vcoolor_map = '<M-z>'

" HardTime settings
let g:hardtime_default_on = 0
let g:list_of_normal_keys = ["h", "j", "k", "l", "-", "+", "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>", "w", "b", "e"]
let g:list_of_visual_keys = ["h", "j", "k", "l", "-", "+", "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
let g:list_of_insert_keys = ["<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
let g:list_of_disabled_keys = []


set autoindent "Retain indentation on next line
set smartindent "Turn on autoindenting of blocks

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

" Some css complete thing I guess is needed
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS noci

" nvim completion manager settings
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Java Abbrs
abbr Sout System.out.println("
abbr SOut System.out.print("
abbr fori for(int i = 0, x = .length; i < x; i++)
abbr psv public static void main(String[] args)

" xkcd scroll through time instead of space
"set mouse=a
"nnoremap <ScrollWheelUp> u
"nnoremap <ScrollWheelDown> <C-R>


autocmd FileType vue syntax sync fromstart
