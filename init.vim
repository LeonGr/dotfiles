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
Plug 'Valloric/YouCompleteMe'
Plug 'digitaltoad/vim-jade'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'

" Syntax specific
Plug 'pangloss/vim-javascript'
Plug 'darthmall/vim-vue'
Plug 'cakebaker/scss-syntax.vim'
Plug 'leafgarland/typescript-vim'

" Themes
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'flazz/vim-colorschemes'
Plug 'altercation/vim-colors-solarized'
Plug 'jdkanani/vim-material-theme'
Plug 'nanotech/jellybeans.vim'
Plug 'morhetz/gruvbox'
call plug#end()

" scrolling
set mouse=a

" Color configurations
set t_Co=256
syntax enable
set background=dark
colorscheme gruvbox
" Line numbers
set number

" Leader commands
let mapleader = "\<Space>"
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q!<CR>
nnoremap <Leader>x :x<CR>
nnoremap <Leader>t <C-w><C-w>
vnoremap <Leader>c : !pbcopy<CR><CR>
nnoremap <Leader>s :vertical resize 120<CR>
nnoremap <Leader>n :NERDTreeToggle<CR>

function! TabResize()
	<C-w><C-w>
	:vertical resize 120
endfunction

nnoremap <Leader>r TabResize()<CR>

" Commands and shortcuts
inoremap jk <ESC>
"imap { {<C-O>o<C-O>o}<up><tab>

function! BreakHere()
    s/\(.\{-}\)\(\s*\)\(\%#\)\(\s*\)\(.*\)/\1\r\3\5
    call histdel("/", -1)
endfunction

nnoremap S :call BreakHere()<CR>

" settings for airline
set guifont=Inconsolata\ for\ Powerline:h15
set laststatus=2
set termencoding=utf-8
let g:airline_powerline_fonts=1
let g:airline_theme='murmur'

" change size of tab
set tabstop=4 softtabstop=0 noexpandtab shiftwidth=4
" use backspace
set backspace=2

" autocompile .scss file
" autocmd BufNewFile,BufRead *.scss autocmd BufWritePost * !scss -t uncompressed style.scss style.css

augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

" tab settings
set t_ts=^[]1;
set t_fs=^G
