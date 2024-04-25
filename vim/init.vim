"     __                     _          _       _ __        _
"    / /   ___  ____  ____  /_/_____   (_)___  (_) /__   __(_)___ ___
"   / /   / _ \/ __ \/ __ \   / ___/  / / __ \/ / __/ | / / / __ `__ \
"  / /___/  __/ /_/ / / / /  (__  )  / / / / / / /__| |/ / / / / / / /
" /_____/\___/\____/_/ /_/  /____/  /_/_/ /_/_/\__(_)___/_/_/ /_/ /_/

if (has("termguicolors"))
    set termguicolors
endif

let mapleader = "\<Space>"

" (require checks file in ~/.config/nvim/lua)
lua require('init')

" Color settings
syntax enable
syntax on
let g:gruvbox_italic=1 " alacritty supports italics, enable it
colorscheme gruvbox

" LSP settings
lua require('lsp')
" DAP settings
lua require('dap_settings')

" Scrolling
set mouse=a
" Blinking cursors and styles
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
		  \,i-ci-cr-ve-r:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
		  \,sm:block-blinkwait175-blinkoff150-blinkon175

" Show substitute in real time
set inccommand=nosplit

" Set shell
set shell=/usr/bin/bash

" Turn of swap files
set noswapfile

" Show commands as they're typed
set showcmd

" Enable file type identification, plugin and indenting
filetype plugin indent on

" Hide(0)/Only for more than 1 window(1)/Show(2) statusline
set laststatus=2

" Use wal colors for statusline
if isdirectory(expand("~") . "/.cache/wal/")
    source ~/.cache/wal/colors-wal.vim
endif

if filereadable("/opt/theme_colorscheme")
    execute 'set bg=' . readfile("/opt/theme_colorscheme")[0]
else
    set bg=dark
endif

highlight StatusLine   gui=none            " guibg=none
highlight StatusLineNC gui=none cterm=bold " guibg=grey guifg=#000000

" Highlight current line
set cursorline
" Set color based on colorscheme
if &bg == "dark"
    highlight CursorLine guibg=#212020
else
    highlight CursorLine guibg=#DEDEDE
endif

" Make line nr and background fit terminal background
highlight Normal guibg=NONE ctermbg=NONE
highlight LineNr guibg=NONE

"highlight FloatBorder guifg=#FFFFFF
highlight link FloatBorder Normal

" Line numbers
set number relativenumber

highlight CursorLineNR guibg=NONE guifg=NONE

" SideLine
set signcolumn=yes                       " always show (to prevent jump from git/lint)
highlight SignColumn guibg=NONE gui=bold " Make background transparent

" Hide vertical split background color
highlight VertSplit guibg=NONE

" Enable spelling check
set spell

" Change color of squiggly line to red
highlight SpellBad guisp=#FF0000

" See :help 'fo-table'/'formatoptions'
" Stop automatic new line of comment after CTRL-O
autocmd FileType * setlocal formatoptions-=o

" Searching improvements
set incsearch       " Lookahead as search pattern is specified
set ignorecase      " Ignore case in all searches...
set smartcase       " ...unless uppercase letters used
" Note: add \C to the query to enable case sensitivity when only typing lowercase

set hlsearch        " Highlight all matches
nmap <silent> <BS> :nohlsearch<CR> " Backspace to turn of highlight Searching

" Use undofile for persistent undo
set undofile
" set a directory to store the undo history
set undodir=~/.vimundo/

" use backspace
set backspace=2

" Leader commands

" General

" Save
nnoremap <Leader>w     :w<CR>
" Toggle between current and last buffer
nnoremap <Leader><tab> :b#<CR>
" Close current buffer
nnoremap <Leader>x :bdelete<CR>
" Remove training whitespace
nnoremap <Leader>v     :call TrimWhiteSpace()<CR>
" Toggle case of first letter of current word
nnoremap <Leader>u     m`viw<ESC>b~``

" Telescope leader commands
nnoremap <Leader>f     :Telescope current_buffer_fuzzy_find<CR>
nnoremap <Leader>b     :Telescope buffers<CR>
nnoremap <Leader>o     :Telescope find_files no_ignore=true<CR>
nnoremap <Leader>p     :Telescope git_files<CR>
nnoremap <Leader>l     :Telescope buffers<CR>
nnoremap <Leader>m     :Telescope keymaps<CR>
" nnoremap <Leader>r     :Telescope live_grep<CR>
nnoremap <Leader>r     :Telescope egrepify<CR>
     map <Leader>n     :Telescope man_pages sections=1,2,3,4,5,6,7,8,9<CR>

" Instead of going to next occurrence of word on *, stay on current
nnoremap * *N

" Use escape to leave terminal mode
tnoremap <Esc> <C-\><C-n>

" Removes trailing spaces
function TrimWhiteSpace()
  %s/\s*$//
  ''
endfunction

" Tern for vim settings
let g:tern_show_argument_hints='on_hold'
let g:tern_map_keys=1

" Nerd Tree settings
let g:nerdtree_tabs_open_on_gui_startup = 0
let NERDTreeShowHidden = 1

" Auto pairs settings
let g:PairsOn = 1
function ToggleAutoPairs()
    if g:PairsOn == 1
        lua require('nvim-autopairs').disable()
        let g:PairsOn = 0
        echo("Disabled AutoPairs")
    else
        lua require('nvim-autopairs').enable()
        let g:PairsOn = 1
        echo("Enabled AutoPairs")
    endif
endfunction

nnoremap <M-p> <cmd>call ToggleAutoPairs()<CR>

" vCoolor settings
let g:vcoolor_map = '<M-z>'

" Number of spaces that a Tab is
set tabstop=4
" Number of spaces for indent (>>, <<)
set shiftwidth=4
" Pressing tab creates number of spaces
set expandtab

" Show trailing whitespace
set list listchars=tab:»·,trail:-

" Some css complete thing I guess is needed
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS noci

highlight link CmpDocumentation Pmenu
highlight link CmpDocumentationBorder Pmenu

" Change color popup menu
" highlight Pmenu ctermbg=gray guibg=#202020 guifg=#FFFFFF
" highlight NormalFloat ctermbg=gray guibg=none

" Set completeopt to have a better completion experience (:help completeopt)
    " menuone: popup even when there's only one match
    " noinsert: Do not insert text until a selection is made
    " noselect: Do not select, force user to select one from the menu
"set completeopt=noinsert,menuone,noselect
" set completeopt=menuone,noselect
set completeopt=menu,menuone,noselect

""" Set vsnip snippets keys
" Expand
imap <expr> <C-s>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : ''
smap <expr> <C-s>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : ''

" Expand or jump
" imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : ''
" smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : ''

" Jump forward or backward
imap <expr> <C-l>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : ''
smap <expr> <C-l>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : ''
imap <expr> <C-k>   vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : ''
smap <expr> <C-k>   vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : ''

""" LSP mappings

" Jump to definition
" nnoremap gf    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap gf    :Telescope lsp_definitions<CR>

" Displays hover information in floating window
nnoremap K     <cmd>lua vim.lsp.buf.hover()<CR>

" Lists implementations in quickfix window
" nnoremap gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap gD    :Telescope lsp_implementations<CR>

" Displays signature information in floating window
nnoremap gs    <cmd>lua vim.lsp.buf.signature_help()<CR>

" Jump to definition of type
nnoremap 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>

" Lists all the references in quickfix window
" nnoremap gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap gr    :Telescope lsp_references<CR>

" Lists all symbols current buffer in quickfix window
" nnoremap gt    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap gt    :Telescope lsp_document_symbols<CR>

" Lists all symbols current workspace in quickfix window
" nnoremap gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap gw    :Telescope lsp_dynamic_workspace_symbols<CR>

" Jump to declaration
nnoremap gd    <cmd>lua vim.lsp.buf.declaration()<CR>

" Jump to implementation
nnoremap gi    <cmd>lua vim.lsp.buf.implementation()<CR>

" Selects a code action from input list available
nnoremap ga    <cmd>lua vim.lsp.buf.code_action()<CR>

" Goto previous/next diagnostic warning/error
nnoremap gj <cmd>lua vim.diagnostic.goto_next()<CR>
nnoremap gk <cmd>lua vim.diagnostic.goto_prev()<CR>

" Show diagnostic popup
nnoremap <Leader>d <cmd>lua vim.diagnostic.open_float(0, { scope = "line", border = "single" })<CR>

" Rename
nnoremap ge <cmd>lua vim.lsp.buf.rename()<CR>

" Show runnables (Rust)
nnoremap <silent>gu :RustRunnables<CR>

" Show debuggables (Rust)
nnoremap <silent>gy :RustDebuggables<CR>


" Avoid showing extra messages when using completion
set shortmess+=c

" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
set updatetime=300

" ALE - Asynchronous Linter Engine settings
nnoremap <Leader>e :call ale#cursor#ShowCursorDetail()<CR>
nnoremap <silent> <Leader>j :ALENextWrap<CR>
nnoremap <silent> <Leader>k :ALEPreviousWrap<CR>

let g:ale_linters = {
            \ 'python'  : ['flake8', 'mypy', 'bandit'],
            \ 'haskell' : ['cabal_ghc', 'ghc-mod', 'hdevtools', 'hie', 'hlint', 'stack_build', 'stack_ghc'],
            \ 'rust'    : [],
            \ }

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_rust_rustc_options = ''

" make :Q work as :q
cabbr Q q

" Vim-vue settings
autocmd FileType vue syntax sync fromstart
" Only try scss
let g:vue_pre_processors = ['scss', 'typescript']

" Indentguide settings
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 1
let g:indent_guides_auto_colors = 0
highlight IndentGuidesOdd  ctermbg=white
highlight IndentGuidesEven ctermbg=blue

highlight IndentGuidesOdd  guibg=#FFFFFF
highlight IndentGuidesEven guibg=#CCCCCC
let g:indent_guides_color_change_percent = 50

" QuickScope settings
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
highlight QuickScopePrimary guifg=#5af78e gui=underline,bold
highlight QuickScopeSecondary guifg=#57c7ff gui=underline,bold
" Set highlight priority to override nvim-cursorword highlight
let g:qs_hi_priority = 10

" Emmet settings
let g:user_emmet_mode='i'

" NERDCommenter: <Leader> + c<space> = comment, cs = pretty block, cm = multiline
let g:NERDAltDelims_c = 1 " Use // for C
let g:NERDSpaceDelims = 1 " Add space after comment delimiter

" vim-test
let test#strategy = "neovim"
let test#neovim#term_position = "vertical"
nnoremap <Leader>tt :TestNearest<CR>
nnoremap <Leader>tf :TestFile<CR>
nnoremap <Leader>ts :TestSuite<CR>
nnoremap <Leader>tl :TestLast<CR>

" nvim-dap
nnoremap <Leader>s_ :lua require'dap'.clear_breakpoints()<CR>
nnoremap <Leader>sr :lua require'dap'.run_last()<CR>
nnoremap <Leader>sc :lua require'dap'.continue()<CR>
nnoremap <Leader>sb :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <Leader>sB :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <Leader>sl :lua require'telescope'.extensions.dap.list_breakpoints()<CR>
nnoremap <Leader>sv :lua require'telescope'.extensions.dap.variables()<CR>
nnoremap <Leader>sh :lua require'dap'.run_to_cursor()<CR>
nnoremap <Leader>so :lua require'dap'.step_out()<CR>
nnoremap <Leader>si :lua require'dap'.step_into()<CR>
nnoremap <Leader>sn :lua require'dap'.step_over()<CR>
nnoremap <Leader>sw :lua require'dap.ui.widgets'.hover()<CR>
nnoremap <Leader>sg :lua require'dapui'.toggle()<CR>
nnoremap <Leader>s  <NOP>

" nvim-cursorword
let g:cursorword_min_width = 2

" set color of highlighted instances of word under cursor
if &bg == "dark"
    highlight CursorWord guibg=#423F3C gui=none
    autocmd InsertLeave * highlight CursorWord guibg=#423F3C gui=none
else
    highlight CursorWord guibg=#FFE4C9 gui=none
    autocmd InsertLeave * highlight CursorWord guibg=#FFE4C9 gui=none
endif

autocmd InsertEnter * highlight clear CursorWord

" git-blame.nvim

" Disable by default (toggle with :GitBlameToggle)
let g:gitblame_enabled = 0

" Change highlight group (from default Comment)
let g:gitblame_highlight_group = "Question"


" lewis6991/gitsigns.nvim

" remove sign column background for gitsigns
highlight GruvboxRedSign guibg=none
highlight GruvboxGreenSign guibg=none
highlight GruvboxYellowSign guibg=none
highlight GruvboxBlueSign guibg=none
highlight GruvboxPurpleSign guibg=none
highlight GruvboxAquaSign guibg=none
highlight GruvboxOrangeSign guibg=none

augroup ConfigureKitty
    au!
    au VimEnter * silent !kitty @ --to $KITTY_LISTEN_ON set-spacing margin-bottom=8 margin-left=0 margin-right=0
    au VimLeave * silent !kitty @ --to $KITTY_LISTEN_ON set-spacing margin=8
augroup END

" Redirect command output to a scratch buffer
" Source: https://gist.github.com/romainl/eae0a260ab9c135390c30cd370c20cd7
" Usage:
" - show output of vim command
" :Redir nmap
" - show output of shell command
" :Redir !ls -la ()
" - Evaluate line(s) using shell command and show output
" current line: console.log('test')
" :.Redit !node
function! Redir(cmd, rng, start, end)
    for win in range(1, winnr('$'))
        if getwinvar(win, 'scratch')
            execute win . 'windo close'
        endif
    endfor
    if a:cmd =~ '^!'
        let cmd = a:cmd =~' %'
                    \ ? matchstr(substitute(a:cmd, ' %', ' ' . shellescape(escape(expand('%:p'), '\')), ''), '^!\zs.*')
                    \ : matchstr(a:cmd, '^!\zs.*')
        if a:rng == 0
            let output = systemlist(cmd)
        else
            let joined_lines = join(getline(a:start, a:end), '\n')
            let cleaned_lines = substitute(shellescape(joined_lines), "'\\\\''", "\\\\'", 'g')
            let output = systemlist(cmd . " <<< $" . cleaned_lines)
        endif
    else
        redir => output
        execute a:cmd
        redir END
        let output = split(output, "\n")
    endif
    vnew
    let w:scratch = 1
    setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
    call setline(1, output)
endfunction

" This command definition includes -bar, so that it is possible to "chain" Vim commands.
" Side effect: double quotes can't be used in external commands
command! -nargs=1 -complete=command -bar -range Redir call Redir(<q-args>, <range>, <line1>, <line2>)

" This command definition doesn't include -bar, so that it is possible to use double quotes in external commands.
" Side effect: Vim commands can't be "chained".
command! -nargs=1 -complete=command -range Redir call Redir(<q-args>, <range>, <line1>, <line2>)

" context.nvim
highlight link TreesitterContext Pmenu
highlight link TreesitterContextBottom TreesitterContext
highlight link TreesitterContextLineNumber TreesitterContext

" Highlight yanked area for 200 milliseconds
autocmd TextYankPost * silent! lua vim.highlight.on_yank({timeout=200})

" Make comments more obvious
highlight Comment gui=reverse
