" Searching improvements
set incsearch       "Lookahead as search pattern is specified
set ignorecase      "Ignore case in all searches...
set smartcase       "...unless uppercase letters used

set hlsearch        "Highlight all matches
"highlight clear Search
highlight       Search    guifg=#000000 guibg=#FFFFFF
nmap <silent> <BS> :nohlsearch<CR> " Backspace to turn of highlight Searching

" Line numbers
set number relativenumber

" Scrolling
set mouse=a

" Show commands as they're typed
set showcmd

" Highlight current line
set cursorline

" Turn of swap files
set noswapfile

" Show substitute in real time
set inccommand=nosplit

" Color configurations
if (has("termguicolors"))
    set termguicolors
endif

" Enable file type identification, plugin and indenting
filetype plugin indent on


