set nocompatible " be iMproved, required
filetype off     " required

" Vim-Plug
call plug#begin()

"Tweaks
Plug 'tpope/vim-surround'              " Wrap text easily
"Plug 'vim-airline/vim-airline-themes'  " More themes for airline
Plug 'mattn/emmet-vim'                 " html autocomplete
Plug 'scrooloose/nerdtree'             " File browser in vim
Plug 'jistr/vim-nerdtree-tabs'         " Keep nerdtree open across tabs
Plug 'scrooloose/nerdcommenter'        " Easy commenting and uncommenting
"Plug 'kien/ctrlp.vim'                  " Great file browser
Plug 'tpope/vim-obsession'             " Save vim sessions
Plug 'christoomey/vim-tmux-navigator'  " Navigate tmux windows using hjkl
Plug 'unblevable/quick-scope'          " Higlight words when you press f or t
Plug 'chip/vim-fat-finger'             " Series of abbreviations for vim
Plug 'tpope/vim-repeat'                " Repeat more than one command
Plug 'godlygeek/tabular'               " Easy text align
Plug 'tpope/vim-endwise'               " Auto close stuff
"Plug 'rking/ag.vim'                    " Search through files and directories
Plug 'takac/vim-hardtime'              " Help me to stop using jjjj
Plug 'airblade/vim-gitgutter'          " Show git changes
Plug 'jiangmiao/auto-pairs'            " Auto pairs
"Plug 'majutsushi/tagbar'               " Show tags
Plug 'roxma/ncm2'                      " Completion
    Plug 'roxma/nvim-yarp'                        " requirement ncm2
    Plug 'gaalcaras/ncm-R'                        " ncm2 R completion
    Plug 'ncm2/ncm2-bufword'                      " ncm2 word in buffer completion
    Plug 'ncm2/ncm2-path'                         " ncm2 path completion
    Plug 'ncm2/ncm2-jedi'                         " ncm2 Python completion
    Plug 'ncm2/ncm2-pyclang'                      " ncm2 C/C++ completion
    Plug 'ncm2/ncm2-cssomni'                      " ncm2 CSS completion
    Plug 'ncm2/ncm2-tern',  {'do': 'npm install'} " ncm2 JavaScript Completion
    Plug 'ncm2/ncm2-racer'                        " ncm2 Rust completion
    Plug 'ncm2/ncm2-cssomni'                      " ncm2 CSS completion
    Plug 'autozimu/LanguageClient-Neovim', {'branch': 'next', 'do': 'bash install.sh' } " Language Server Protocol support

    " based on ultisnips
    Plug 'ncm2/ncm2-ultisnips'         " ncm2 ultisnips integration
    Plug 'SirVer/ultisnips'            " Snippets engine
    Plug 'honza/vim-snippets'          " Snippets themselves
"Plug 'davidhalter/jedi-vim'            " Python completion
Plug 'othree/csscomplete.vim'          " CSS completion
Plug 'KabbAmine/vCoolor.vim'           " Colour picker (Alt-Z)
Plug 'yaroot/vissort'                  " Sort by visual block
Plug 'dense-analysis/ale'              " Async Lint Engine
Plug 'junegunn/fzf.vim'                " Fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Syntax specific
Plug 'pangloss/vim-javascript'         " Javascript support
Plug 'ap/vim-css-color'                " Show css colors in files
"Plug 'digitaltoad/vim-jade'            " Jade support
Plug 'cakebaker/scss-syntax.vim'       " SCSS support
Plug 'nathanaelkane/vim-indent-guides' " Indentation guides
"Plug 'scrooloose/syntastic'            " Syntax checker
Plug 'keith/swift.vim'                 " Swift syntax and indent styles
Plug 'posva/vim-vue'                   " Vue syntax
Plug 'leafgarland/typescript-vim'      " TypeScript support
Plug 'jalvesaq/nvim-r'                 " R support
Plug 'chrisbra/csv.vim'                " Browse csv files
Plug 'neovimhaskell/haskell-vim'       " Better Haskell support

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
Plug 'chriskempson/base16-vim'
call plug#end()

" Scrolling
set mouse=a
"set guicursor=

" Show commands as they're typed
set showcmd

" Highlight current line
set cursorline

" Hide file name
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
syntax on
"set t_Co=256
colorscheme molokai
" cthulhian preto molokai
"set background=dark

" Make line nr and background fit terminal background
hi Normal guibg=NONE ctermbg=NONE
hi LineNr guibg=NONE

" Line numbers
set number
highlight CursorLineNR guibg=NONE guifg=NONE

" Stop automatic new line of comment
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Searching improvements
set incsearch       "Lookahead as search pattern is specified
set ignorecase      "Ignore case in all searches...
set smartcase       " ...unless uppercase letters used

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
map <Leader>n <plug>NERDTreeTabsToggle<CR>
nnoremap <Leader>p :Files<CR>
nnoremap <Leader>f :Lines<CR>
nnoremap <Leader>/ :BLines<CR>
nnoremap <Leader>v :call TrimWhiteSpace()<CR>

" Removes trailing spaces
function TrimWhiteSpace()
  %s/\s*$//
  ''
endfunction

" Syntastic settings
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" CtrlP settings
"set wildignore+=*/tmp/*,*.so,*.swp,*.zip " Ignore these filetypes
"let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git' " Ignore these dirs

" Tern for vim settings
let g:tern_show_argument_hints='on_hold'
let g:tern_map_keys=1

" Nerd Tree settings
let g:nerdtree_tabs_open_on_gui_startup = 0

" Auto pairs settings
let g:AutoPairsShortcutToggle = '<M-p>'
"let g:AutoPairsMapCR=0

"vCoolor settings
let g:vcoolor_map = '<M-z>'

" HardTime settings
let g:hardtime_default_on = 0
let g:list_of_normal_keys = ["h", "j", "k", "l", "-", "+", "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>", "w", "b", "e"]
let g:list_of_visual_keys = ["h", "j", "k", "l", "-", "+", "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
let g:list_of_insert_keys = ["<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
let g:list_of_disabled_keys = []

"Retain indentation on next line
set autoindent
"Turn on autoindenting of blocks
set smartindent

" Clear trailing whitespace in selected file types on save
"autocmd BufWritePre * :%s/\s\+$//e

" Show trailing whitespace
set list listchars=tab:»·,trail:-

" Some css complete thing I guess is needed
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS noci

" ncm2 settings
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

" IMPORTANT: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect

" ncm2 path to libclang
let g:ncm2_pyclang#library_path = '/usr/lib64/libclang.so'

" set ultisnips/snippets expansion key
let g:UltiSnipsExpandTrigger       = "<c-s>"
let g:UltiSnipsJumpForwardTrigger  = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"
"autocmd BufNewFile,BufRead * inoremap <silent> <buffer> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')

" LSP settings
let g:LanguageClient_serverCommands = {
            \ 'rust'    : ['rust-analyzer'],
            \ 'haskell' : ['haskell-language-server-wrapper', '--lsp'],
            \ }

function LC_maps()
    if has_key(g:LanguageClient_serverCommands, &filetype)
        "nnoremap <buffer> <silent> K :call LanguageClient#textDocument_hover()<CR>
        "nnoremap <buffer> <silent> gd :call LanguageClient#textDocument_definition()<CR>
        "nnoremap <buffer> <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
        nnoremap <F5> :call LanguageClient_contextMenu()<CR>
        map <Leader>lk :call LanguageClient#textDocument_hover()<CR>
        map <Leader>ld :call LanguageClient#textDocument_definition()<CR>
        map <Leader>lr :call LanguageClient#textDocument_rename()<CR>
        map <Leader>lf :call LanguageClient#textDocument_formatting()<CR>
        map <Leader>lb :call LanguageClient#textDocument_references()<CR>
        map <Leader>la :call LanguageClient#textDocument_codeAction()<CR>
        map <Leader>ls :call LanguageClient#textDocument_documentSymbol()<CR>
    endif
endfunction

autocmd FileType * call LC_maps()

" ALE - Asynchronous Linter Engine settings

"hi link ALEError Error
"hi Warning term=underline cterm=underline ctermfg=Yellow gui=undercurl guisp=Gold
"hi link ALEWarning Warning
"hi link ALEInfo SpellCap

nnoremap <Leader>e :call ale#cursor#ShowCursorDetail()<CR>
nnoremap <silent> <Leader>j :ALENextWrap<CR>
nnoremap <silent> <Leader>k :ALEPreviousWrap<CR>

let g:ale_linters = {
            \ 'python'  : ['flake8', 'mypy', 'bandit'],
            \ 'rust'    : ['rustc', 'rls', 'analyzer', 'cargo'],
            \ 'haskell' : ['cabal_ghc', 'ghc-mod', 'hdevtools', 'hie', 'hlint', 'stack_build', 'stack_ghc'],
            \ }

let g:ale_rust_rustc_options = ''

"let g:ale_lint_on_text_changed = 'never'
"let g:ale_lint_on_save = 'never'
"let g:ale_lint_on_insert_leave = 0
"let g:ale_lint_on_enter = 0

function JavaAbbrs()
    " Java Abbrs
    abbr Sout System.out.println("
    abbr SOut System.out.print("
    abbr fori for(int i = 0, x = .length; i < x; i++)
    abbr psv public static void main(String[] args)
endfunction

function JsAbbrs()
    " Java Abbrs
    abbr fori for(let i = 0, x = .length; i < x; i++)
    abbr clog console.log
endfunction

autocmd FileType java call JavaAbbrs()
autocmd FileType vue call JsAbbrs()
autocmd FileType javascript call JsAbbrs()

" xkcd scroll through time instead of space
"set mouse=a
"nnoremap <ScrollWheelUp> u
"nnoremap <ScrollWheelDown> <C-R>

"let g:syntastic_mode_map = { 'passive_filetypes': ['asm', 'python'] }

autocmd FileType vue syntax sync fromstart

" settings :: Nvim-R plugin
" R output is highlighted with current colorscheme
let g:rout_follow_colorscheme = 1

" R commands in R output are highlighted
let g:Rout_more_colors = 1

let R_in_buffer = 0
let R_applescript = 0
"let R_tmux_split = 1

let R_source = '~/.config/nvim/plugged/nvim-r/R/tmux_split.vim'

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
highlight QuickScopePrimary guifg='#5af78e' gui=underline
highlight QuickScopeSecondary guifg='#57c7ff' gui=underline
