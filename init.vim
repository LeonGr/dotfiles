set nocompatible " be iMproved, required
filetype off     " required

" Plugins
call plug#begin()
"Tweaks
Plug 'tpope/vim-surround'
Plug 'bling/vim-airline'
Plug 'bling/vim-bufferline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mattn/emmet-vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'jiangmiao/auto-pairs'
Plug 'digitaltoad/vim-jade'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'scrooloose/nerdcommenter'
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-obsession'
"Plug 'mkitt/tabline.vim'
Plug 'christoomey/vim-tmux-navigator'
"Plug 'airblade/vim-gitgutter'
Plug 'Valloric/YouCompleteMe'
Plug 'unblevable/quick-scope'

" Syntax specific
Plug 'pangloss/vim-javascript'
Plug 'ap/vim-css-color'
Plug 'darthmall/vim-vue'
Plug 'cakebaker/scss-syntax.vim'
Plug 'leafgarland/typescript-vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'scrooloose/syntastic'
Plug 'marijnh/tern_for_vim'

" Themes
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'flazz/vim-colorschemes'
Plug 'altercation/vim-colors-solarized'
Plug 'jdkanani/vim-material-theme'
Plug 'nanotech/jellybeans.vim'
Plug 'morhetz/gruvbox'
Plug 'marcopaganini/termschool-vim-theme'
call plug#end()

" scrolling
set mouse=a

" Show commands as they're typed
set showcmd

" Current line
set cursorline

" Color configurations
syntax enable
set t_Co=256
set background=dark
let g:solarized_termcolors=256
colorscheme gruvbox

" Line numbers
set number
"highlight LineNr cterm=none ctermfg=31 ctermbg=none
"highlight CursorLineNR cterm=none ctermfg=white
hi CursorLine ctermfg=NONE

" Indentguide settings
set ts=4 sw=4 et
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 1
let g:indent_guides_auto_colors = 0
hi IndentGuidesOdd  ctermbg=grey
hi IndentGuidesEven ctermbg=darkgrey
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
vnoremap <Leader>c :'<,'>w !pbcopy<CR><CR>
nnoremap <Leader>s :vertical resize 120<CR>
map <Leader>n <plug>NERDTreeTabsToggle<CR>
nnoremap <Leader>f :CtrlP<CR>

" Commands and shortcuts
inoremap jk <ESC>
inoremap jj <ESC>

" settings for airline
set guifont=Inconsolata\ for\ Powerline:h15
set laststatus=2
set termencoding=utf-8
let g:airline_powerline_fonts=1
let g:airline_theme='leontheme'

" Hide buffers
set showtabline=0
let g:bufferline_echo = 0

let g:airline_section_b = ''
let g:airline_section_y = ''
let g:airline_left_sep = ' '
let g:airline_right_sep = ' '
" settings for syntastic
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*


let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" CtrlP settings
set wildignore+=*/tmp/*,*.so,*.swp,*.zip " Ignore these filetypes
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git' " Ignore these dirs

" Show just the filename
"let g:airline#extensions#tabline#fnamemod = ':t'

" change size of tab
" set tabstop=2 softtabstop=0 noexpandtab shiftwidth=4
" use backspace
set backspace=2

" STOP USING ARROWS
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

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
