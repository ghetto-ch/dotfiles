" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')

" Theme related
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'chriskempson/base16-vim'
Plug 'arcticicestudio/nord-vim'

" Usability
Plug 'tpope/vim-sensible'
Plug '/usr/bin/fzf'
Plug 'junegunn/fzf'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'haya14busa/incsearch.vim'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-repeat'

" General for programming
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'tpope/vim-surround'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neco-vim'
Plug 'autozimu/LanguageClient-neovim', {
			\ 'branch': 'next',
			\ 'do': 'bash install.sh',
			\ }
Plug 'w0rp/ale'
"Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle }
"Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Clang
Plug 'Shougo/deoplete-clangx'

" Python
Plug 'zchee/deoplete-jedi'

" Julia
Plug 'JuliaEditorSupport/julia-vim'

" Initialize plugin system
call plug#end()

"############################################################
" CUSTOM FUNCTIONS
"############################################################

" Strip all trailing spaces on write
function! StripTrailing()
	let l = line(".")
	let c = col(".")
	%s/\s\+$//e
	call cursor(l, c)
endfun

"############################################################
" GENERAL SETTINGS
"############################################################
"
" Tell vim to use zsh instead of bash
set shell=/bin/zsh

" Tabs and folding
set tabstop=4
set softtabstop=4
set shiftwidth=4
set foldmethod=indent
set foldlevelstart=99

" Enable persistent undo
set undofile

"############################################################
" THEME AND GUI RELATED SETTINGS
"############################################################

" Set colors
set background=dark
set t_Co=256

" iPad terminal emulator doesn't like base16
" therefore I check if the terminal is xterm.
" It's not a nice solution but I don't know other...
if &term=~'xterm'
	colorscheme nord
	let g:airline_theme='nord'
else
	" Load Base16 theme
	set termguicolors
	if filereadable(expand("~/.vimrc_background"))
		source ~/.vimrc_background
	endif
endif

" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

"############################################################
" USABILITY SETTINGS
"############################################################

" Split in the correct way
set splitbelow
set splitright

" Highlight current line and show relative line numbers
set cursorline
set number relativenumber

" Keep some lines for context
set scrolloff=3

" Search
set ignorecase
set smartcase

" Use mouse
set mouse+=a

" Highlight unuseful whitespaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

"############################################################
" PROGRAMMING SETTINGS
"############################################################

" Python indentation
autocmd FileType python setlocal expandtab

"############################################################
" PLUGINS SETTINGS
"############################################################

"##### FZF #####

" FZF commands prefix
"let g:fzf_command_prefix = 'Fzf'

" This is the default extra key bindings
let g:fzf_action = {
			\ 'ctrl-t': 'tab split',
			\ 'ctrl-x': 'split',
			\ 'ctrl-v': 'vsplit'
			\ }

" Customize fzf colors to match your color scheme
let g:fzf_colors = {
			\ 'fg':      ['fg', 'Normal'],
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
			\ 'header':  ['fg', 'Comment']
			\ }

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

"##### GOYO / LIMELIGHT #####
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

"##### DEOPLETE #####
" Use deoplete
let g:deoplete#enable_at_startup = 1
" Use <tab> to complete common part of the string
imap <expr><tab> pumvisible() ? deoplete#complete_common_string() : "\<tab>"
imap <expr><silent><CR> pumvisible() ? deoplete#close_popup() : "\<CR>"

"##### ALE #####
" let g:ale_completion_enabled = 1

"##### LANGUAGE SERVER #####
let g:LanguageClient_serverCommands = {
			\ 'julia': ['/usr/bin/julia', '--startup-file=no', '--history-file=no',
			\ '-e', "using SymbolServer; using LanguageServer;
			\ server = LanguageServer.LanguageServerInstance(
			\ stdin, stdout, false, \"~/.julia/environments/v1.0\", \"\", Dict());
			\ server.runlinter = true; run(server);"],
			\ }

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>


"##### ULTISNIPS #####
" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"

"##### INCSEARCH #####
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

"############################################################
" KEY BINDINGS
"############################################################

let mapleader = ' '
set timeoutlen=2000

" Search
nnoremap <Esc><Esc> :<C-u>nohlsearch<CR>
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" Buffers
nnoremap <C-n> :bnext!<CR>
vnoremap <C-n> :bnext!<CR>
nnoremap <C-p> :bprevious!<CR>
vnoremap <C-p> :bprevious!<CR>

" Windows
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Replace selected text pressing C-r
vnoremap <C-r> "hy:%s/<C-r>h//g<left><left>


