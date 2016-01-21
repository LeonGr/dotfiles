set nocompatible " be iMproved, required
filetype off     " required

" Plugins
call plug#begin()
"Tweaks
Plug 'tpope/vim-surround'
Plug 'bling/vim-airline'
Plug 'mattn/emmet-vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'ap/vim-css-color'
Plug 'jiangmiao/auto-pairs'
Plug 'digitaltoad/vim-jade'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'scrooloose/nerdcommenter'
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-obsession'
Plug 'mkitt/tabline.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'airblade/vim-gitgutter'
Plug 'Valloric/YouCompleteMe'
Plug 'unblevable/quick-scope'

" Syntax specific
Plug 'pangloss/vim-javascript'
Plug 'darthmall/vim-vue'
Plug 'cakebaker/scss-syntax.vim'
Plug 'leafgarland/typescript-vim'
Plug 'nathanaelkane/vim-indent-guides'

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

set cursorline

" Color configurations
syntax enable
set t_Co=256
set background=dark
let g:solarized_termcolors=256
colorscheme preto
" Line numbers
set number
highlight LineNr ctermfg=white

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
nnoremap <Leader>t <C-w><C-w>
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
let g:airline_theme='murmur'
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

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
