" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
    set nobackup      " do not keep a backup file, use versions instead
else
    set backup        " keep a backup file (restore to previous version)
    if has('persistent_undo')
        set undofile    " keep an undo file (undo changes after closing)
    endif
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

    " Put these in an autocmd group, so that we can delete them easily.
    augroup vimrcEx
        au!

        " For all text files set 'textwidth' to 78 characters.
        autocmd FileType text setlocal textwidth=78

        " Strip all trailing spaces on write
        function! StripTrailing()
            let l = line(".")
            let c = col(".")
            %s/\s\+$//e
            call cursor(l, c)
        endfun
        autocmd BufWritePre * :call StripTrailing()

        " Code formatters (to be used with gq)
        autocmd FileType python setlocal formatprg=autopep8\ -

    augroup END

else

    set autoindent        " always set autoindenting on

endif " has("autocmd")

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
    packadd! matchit
endif

if has("gui")
    set guioptions-=L
    set guioptions-=r
    set guioptions-=m
    set guioptions-=T
    set guifont=Inconsolata\ 13
endif

"#####################################################################
" Use vundle to install plugins
set nocompatible              " be iMproved, required
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" " alternatively, pass a path where Vundle should install plugins
" "call vundle#begin('~/some/path/here')
"
" " let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Theme related
Plugin 'Solarized'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'ayu-theme/ayu-vim'
Plugin 'arcticicestudio/nord-vim'
Plugin 'chriskempson/base16-vim'

" General for programming
Bundle 'Valloric/YouCompleteMe'
Plugin 'Yggdroot/indentLine'
Plugin 'tpope/vim-surround'
Plugin 'majutsushi/tagbar'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'Chiel92/vim-autoformat'
Plugin 'vim-syntastic/syntastic'

" Python
Plugin 'Vimjas/vim-python-pep8-indent'
Plugin 'nvie/vim-flake8'

" Fuzzy finder
Plugin 'junegunn/fzf.vim'

" Usability
Plugin 'junegunn/goyo.vim'
Plugin 'haya14busa/incsearch.vim'
Plugin 'easymotion/vim-easymotion'

" File browsing
Plugin 'scrooloose/nerdtree'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
"#####################################################################

" Use UTF-8
set encoding=utf-8

" Tell vim to use zsh instead of bash
set shell=/bin/zsh
" Set shell interactive to have all custom aliases/functions available
" set shellcmdflag=-ic

" Replace selected text pressing C-r
vnoremap <C-r> "hy:%s/<C-r>h//g<left><left>

" Show relative line numbers
set cursorline
set number relativenumber
set scrolloff=3

" Disable all blinking:
set guicursor+=a:blinkon0

" Split in the correct way
set splitbelow
set splitright


" Folding
" set foldmethod=indent
"
" Set colors
set background=dark
set t_Co=256

if &term=~'xterm'
    colorscheme nord
    let g:airline_theme='nord'
    let g:nord_uniform_diff_background = 1
    let g:nord_cursor_line_number_background = 1
    "    hi! Normal ctermbg=NONE guibg=NONE
    "    hi! NonText ctermbg=NONE guibg=NONE
else
    " set Vim-specific sequences for RGB colors
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
    "let ayucolor="dark"
    "colorscheme ayu
    "let g:airline_theme='ayu'
    if filereadable(expand("~/.vimrc_background"))
        source ~/.vimrc_background
    endif
endif

"if has("gui_running")
"    hi! Normal ctermbg=NONE guibg=NONE
"    hi! NonText ctermbg=NONE guibg=NONE
"endif

" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" Hide mode in status line
set noshowmode
set noruler

set showcmd
set ignorecase
set smartcase

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set fileformat=unix
set foldmethod=indent
set foldlevelstart=99

" Highlight unuseful whitespaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" YouCompleteMe
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_key_list_select_completion = ['<TAB>', '<Down>']
" Python
function! YcmLoadVenv()
    let g:ycm_python_interpreter_path = ''
    let g:ycm_python_sys_path = []
    let g:ycm_extra_conf_vim_data = [
                \  'g:ycm_python_interpreter_path',
                \  'g:ycm_python_sys_path'
                \]
    let g:ycm_global_ycm_extra_conf = '~/global_extra_conf.py'
endfun
call YcmLoadVenv()

" Indent guides
let g:indentLine_char = '┆'
let g:indentLine_enabled = 0

" FZF
" This is the default extra key bindings
let g:fzf_action = {
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-x': 'split',
            \ 'ctrl-v': 'vsplit' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
            \ { 'fg':    ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'hl':      ['fg', 'Comment'],
            \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
            \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
            \ 'hl+':     ['fg', 'Statement'],
            \ 'info':    ['fg', 'PreProc'],
            \ 'border':  ['fg', 'Ignore'],
            \ 'prompt':  ['fg', 'Conditional'],
            \ 'pointer': ['fg', 'Exception'],
            \ 'marker':  ['fg', 'Keyword'],
            \ 'spinner': ['fg', 'Label'],
            \ 'header':  ['fg', 'Comment'] }

" Keybindings
let mapleader = ' '
set timeoutlen=2000
" Fuzzy finder
nnoremap <Leader>rf :History<CR>
nnoremap <Leader>rc :History:<CR>
nnoremap <Leader>ln :Lines<CR>
nnoremap <Leader>lb :BLines<CR>
" Buffers
nnoremap <Leader>bl :Buffers<CR>
nnoremap <Leader>bn :bnext!<CR>
nnoremap <Leader>bp :bprevious!<CR>
nnoremap <Leader>bd :bdelete<CR>
nnoremap <C-n> :bnext!<CR>
nnoremap <C-p> :bprevious!<CR>
" Windows
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <Leader>wv :vsplit<CR>
nnoremap <Leader>ws :split<CR>
nnoremap <Leader>wo :only<CR>
nnoremap <Leader>wr :wincmd r<CR>
nnoremap <Leader>wc :wincmd c<CR>
nnoremap <Leader>wx :wincmd x<CR>
nnoremap <Leader>w_ :wincmd _<CR>
nnoremap <Leader>w= :wincmd =<CR>
" NERDTree
nnoremap <Leader>tr :NERDTreeToggle<CR>
" Tagbar
nnoremap <Leader>tb :TagbarToggle<CR>

" Search highlight
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
" :h g:incsearch#auto_nohlsearch
set hlsearch
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)
nnoremap <Esc><Esc> :<C-u>nohlsearch<CR>
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"

" If you want :UltiSnipsEdit to split your window.
" let g:UltiSnipsEditSplit="vertical"

" EasyMotion
let g:EasyMotion_do_mapping = 0 " Disable default mappings
map <Leader><Leader> <Plug>(easymotion-prefix)
" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
map  <Leader>s <Plug>(easymotion-f2)
nmap <Leader>s <Plug>(easymotion-overwin-f2)

" Move to line
map  <Leader>gl <Plug>(easymotion-bd-jk)
nmap <Leader>gl <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>gw <Plug>(easymotion-bd-w)
nmap <Leader>gw <Plug>(easymotion-overwin-w)

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" Auto close parens etc...
"inoremap " ""<left>
"inoremap ' ''<left>
"inoremap ( ()<left>
"inoremap [ []<left>
"inoremap { {}<left>
"inoremap {<CR> {<CR>}<ESC>O
"inoremap {;<CR> {<CR>};<ESC>O

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
