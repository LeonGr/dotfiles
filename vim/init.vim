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

" Highlight current line
set cursorline
highlight CursorLine guibg=#212020

" Enable file type identification, plugin and indenting
filetype plugin indent on

" Make line nr and background fit terminal background
highlight Normal guibg=NONE ctermbg=NONE
highlight LineNr guibg=NONE

"highlight FloatBorder guifg=#FFFFFF
highlight link FloatBorder Normal

" Hide(0)/Only for more than 1 window(1)/Show(2) statusline
set laststatus=2

"" Statusline
" function! LspStatus() abort
    " if luaeval('#vim.lsp.buf_get_clients() > 0')
        " try
            " return luaeval("vim.lsp.buf_get_clients()[1].name")
        " catch
            " return 'LSP: '
        " endtry
    " endif

    " return ''
" endfunction

" Statusline for when it is visible
" set statusline=\ %{FugitiveHead()}\ \ %0.50F\ %=%l,%c\ \ %p%%\ %{StatusLineLsp()}\  " comment so we don't have trailing whitespace
" set statusline=\ %{FugitiveHead()}\ \ %0.50F\ %=%l,%c\ \ %p%%\ %{StatusLineLsp()}\  " comment so we don't have trailing whitespace

" function! StatusLineLsp()
    " let l:ls = LspStatus()
    " return strlen(l:ls) > 0 ? '  「'.l:ls.'」' : ''
" endfunction

highlight StatusLine   gui=none            " guibg=none
highlight StatusLineNC gui=none cterm=bold " guibg=grey guifg=#000000

" Use wal colors for statusline
source ~/.cache/wal/colors-wal.vim
" execute 'highlight StatusLine guifg='   . background
" execute 'highlight StatusLine guibg='   . color2
" execute 'highlight StatusLineNC guifg=' . color2
" execute 'highlight StatusLineNC guibg=' . background

" execute 'highlight StatusLine guibg='   . background
" execute 'highlight StatusLineNC guibg=' . color2

" Line numbers
set number relativenumber

highlight CursorLineNR guibg=NONE guifg=NONE

" SideLine
set signcolumn=yes                       " always show (to prevent jump from git/lint)
highlight SignColumn guibg=NONE gui=bold " Make background transparent

" Hide vertical split background color
highlight VertSplit guibg=NONE

" See :help 'fo-table'/'formatoptions'
" Stop automatic new line of comment after CTRL-O
autocmd FileType * setlocal formatoptions-=o
"autocmd FileType * setlocal formatoptions-=r
"autocmd FileType * setlocal formatoptions-=c

" Searching improvements
set incsearch       " Lookahead as search pattern is specified
set ignorecase      " Ignore case in all searches...
set smartcase       " ...unless uppercase letters used

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
nnoremap <Leader>w     :w<CR>
nnoremap <Leader><tab> :b#<CR>
vnoremap <Leader>c     :'<,'>w !pbcopy<CR>  <CR>
nnoremap <Leader>v     :call TrimWhiteSpace()<CR>
nnoremap <Leader>q     :copen<CR>
     map <Leader>m     :ExpSel<CR>
" Toggle case of first letter of current word
nnoremap <Leader>u     m`viw<ESC>b~``
" nnoremap <Leader>b     :Buffers<CR>
" nnoremap <Leader>f     :Lines<CR>
" nnoremap <Leader>g     :GFiles?<CR>
" nnoremap <Leader>p     :GFiles<CR>
" nnoremap <Leader>r     :Rg<CR>
" nnoremap <Leader>/     :BLines<CR>

" Telescope leader commands
nnoremap <Leader>f     :Telescope current_buffer_fuzzy_find<CR>
nnoremap <Leader>b     :Telescope buffers<CR>
nnoremap <Leader>o     :Telescope find_files no_ignore=true<CR>
nnoremap <Leader>p     :Telescope git_files<CR>
nnoremap <Leader>r     :Telescope live_grep<CR>
     map <Leader>n     :Telescope man_pages sections=1,2,3,4,5,6,7,8,9<CR>

" Instead of going to next occurrence of word on *, stay on current
nnoremap * *N

" Enter/Return creates a new line
nnoremap <CR> o<ESC>

" Use escape to leave terminal mode
tnoremap <Esc> <C-\><C-n>

" Removes trailing spaces
function TrimWhiteSpace()
  %s/\s*$//
  ''
endfunction

" Make alt-<hjkl> act as arrows in fzf window
function ArrowMap()
    tnoremap <M-h> <left>
    tnoremap <M-j> <down>
    tnoremap <M-k> <up>
    tnoremap <M-l> <right>
endfunction

autocmd! FileType fzf call ArrowMap()

" Enable per-command history
" - History files will be stored in the specified directory
" - When set, CTRL-N and CTRL-P will be bound to 'next-history' and
"   'previous-history' instead of 'down' and 'up'.
let g:fzf_history_dir = '~/.local/share/fzf-history'

" Let FZF be a floating window
let $FZF_DEFAULT_OPTS='--layout=reverse'
let g:fzf_layout = { 'window': 'call FloatingFZF()' }

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
highlight Pmenu ctermbg=gray guibg=#202020 guifg=#FFFFFF
highlight NormalFloat ctermbg=gray guibg=none

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
"let g:ale_lint_on_text_changed = 'never'
"let g:ale_lint_on_save = 'never'
"let g:ale_lint_on_insert_leave = 0
"let g:ale_lint_on_enter = 0

" make :Q work as :q
cabbr Q q

" xkcd scroll through time instead of space
"set mouse=a
"nnoremap <ScrollWheelUp> u
"nnoremap <ScrollWheelDown> <C-R>

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

" GitGutter settings
let g:gitgutter_sign_removed = '—'
" Put this in gruvbox.vim to remove signcolumn background
    "call s:HL('GruvboxRedSign', s:red, s:none, s:bold)
    "call s:HL('GruvboxGreenSign', s:green, s:none, s:bold)
    "call s:HL('GruvboxYellowSign', s:yellow, s:none, s:bold)
    "call s:HL('GruvboxBlueSign', s:blue, s:none, s:bold)
    "call s:HL('GruvboxPurpleSign', s:purple, s:none, s:bold)
    "call s:HL('GruvboxAquaSign', s:aqua, s:none, s:bold)
    "call s:HL('GruvboxOrangeSign', s:orange, s:none, s:bold)

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
highlight CursorWord guibg=#423F3C gui=none

autocmd InsertEnter * highlight clear CursorWord
autocmd InsertLeave * highlight CursorWord guibg=#423F3C gui=none

" wilder.nvim
call wilder#enable_cmdline_enter()
set wildcharm=<Tab>
cmap <expr> <Tab> wilder#in_context() ? wilder#next() : "\<Tab>"
cmap <expr> <S-Tab> wilder#in_context() ? wilder#previous() : "\<S-Tab>"

" Enable for search (/,? and commands :)
call wilder#set_option('modes', ['/', '?', ':'])

" Enable fuzzy searching
call wilder#set_option('pipeline', [
      \   wilder#branch(
      \     wilder#cmdline_pipeline({
      \       'fuzzy': 1,
      \     }),
      \     wilder#python_search_pipeline({
      \       'pattern': 'fuzzy',
      \     }),
      \   ),
      \ ])

" Set highlighters
let s:highlighters = [
        \ wilder#pcre2_highlighter(),
        \ wilder#basic_highlighter(),
        \ ]

call wilder#set_option('renderer', wilder#wildmenu_renderer({
      \   'highlighter': s:highlighters,
      \ }))

" git-blame.nvim

" Disable by default (toggle with :GitBlameToggle)
let g:gitblame_enabled = 0

augroup ConfigureKitty
    au!
    au VimEnter * silent !kitty @ --to $KITTY_LISTEN_ON set-spacing margin-bottom=8 margin-left=0 margin-right=0
    au VimLeave * silent !kitty @ --to $KITTY_LISTEN_ON set-spacing margin=8
augroup END

function! FloatingFZF()
    " With Border
    let height = &lines - 3
    let width = float2nr(&columns - (&columns * 2 / 10))
    let top = ((&lines - height) / 2) - 1
    let left = (&columns - width) / 2
    let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}

    let top = "╭" . repeat("─", width - 2) . "╮"
    let mid = "│" . repeat(" ", width - 2) . "│"
    let bot = "╰" . repeat("─", width - 2) . "╯"
    let lines = [top] + repeat([mid], height - 2) + [bot]
    let s:buf = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
    call nvim_open_win(s:buf, v:true, opts)
    set winhl=Normal:Floating
    let opts.row += 1
    let opts.height -= 2
    let opts.col += 2
    let opts.width -= 4
    call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
    au BufWipeout <buffer> exe 'bw '.s:buf
endfunction

let g:FloatingQFOpen = 0
function! FloatingQuickfix(timer)
    if g:FloatingQFOpen == 0
        " Because FloatingQuickfix calls cclose and copen it  would trigger the autocmd again,
        " so we set this variable to 1 to stop creating an infinite loop
        let g:FloatingQFOpen = 1

        let height = &lines - 3
        let width = float2nr(&columns - (&columns * 2 / 10))
        let top = ((&lines - height) / 2) - 1
        let left = (&columns - width) / 2
        let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}

        let top = "╭" . repeat("─", width - 2) . "╮"
        let mid = "│" . repeat(" ", width - 2) . "│"
        let bot = "╰" . repeat("─", width - 2) . "╯"
        " let top = "╔" . repeat("═", width - 2) . "╗"
        " let mid = "║" . repeat(" ", width - 2) . "║"
        " let bot = "╚" . repeat("═", width - 2) . "╝"
        let lines = [top] + repeat([mid], height - 2) + [bot]
        let s:buf = nvim_create_buf(v:false, v:true)
        call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
        call nvim_open_win(s:buf, v:true, opts)
        set winhl=Normal:Floating

        let buf = nvim_create_buf(v:false, v:true)
        call setbufvar(buf, '&signcolumn', 'no')

        " Close and open QF window so bn opens it instead of the file we're editing
        cclose | copen

        let opts.row += 1
        let opts.height -= 2
        let opts.col += 2
        let opts.width -= 4

        " Open floating window
        let win = nvim_open_win(buf, v:true, opts)
        " Set content to QF buffer | close original QF window
        bn | cclose

        " Make transparent
        set winhl=Normal:Floating
        set number
        " If we leave the buffer, close the floating window and reset the variable
        autocmd BufLeave * ++once :bd! | let g:FloatingQFOpen = 0 | echo '' | exe 'bw '.s:buf
        " After opening, show message in highlight style of ModeMsg
        echohl ModeMsg | echo ' -- QUICKFIX -- ' | echohl None
    endif
endfunction

" Call opening function after 1ms delay, otherwise neovim complains that we cannot use cclose yet
autocmd BufWinEnter quickfix call timer_start(1, 'FloatingQuickfix', {'repeat': 1})

" Close quickfix window on escape
nmap <silent><expr> <esc> (&buftype == "quickfix" ? ':bd<CR>' : '<esc>')
