" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')

" Theme related
Plug 'chriskempson/base16-vim'

" Usability
Plug '/usr/bin/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-unimpaired'
" Plug 'tpope/vim-eunuch'

" General for programming
Plug 'tpope/vim-surround' | Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-endwise' | Plug 'rstacruz/vim-closer'
" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" Initialize plugin system
call plug#end()

"############################################################
" PLUGIN SETTINGS
"############################################################

" FZF #######################################################

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Ultisnips #################################################

" let g:UltiSnipsExpandTrigger="<c-j>"
" let g:UltiSnipsJumpForwardTrigger="<c-j>"
" let g:UltiSnipsJumpBackwardTrigger="<c-z>"

"############################################################
" GENERAL SETTINGS
"############################################################
"
" Tell vim to use zsh instead of bash
set shell=/bin/zsh

" Spell check settings
set spelllang=it,en_us

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

" Load Base16 theme
set termguicolors
if filereadable(expand("~/.vimrc_background"))
	source ~/.vimrc_background
endif

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
set scrolloff=5

" Search
set ignorecase
set smartcase

" Ex completion
set wildmenu
set wildmode=full

" Use mouse
set mouse+=a

" Populate the statusline
source ~/.config/nvim/statusline.vim

" Highlight unuseful whitespaces
highlight ExtraWhitespace ctermbg=darkred guibg=darkred
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
" autocmd BufWinLeave * call clearmatches()

" Stop complaining about modified buffers
set hidden

"############################################################
" PROGRAMMING SETTINGS
"############################################################

" Ebable file types plugin and omnifunction
:filetype plugin indent on
set omnifunc=syntaxcomplete#Complete
" Python indentation
autocmd FileType python setlocal expandtab

"############################################################
" SOME AUTOCOMMANDS
"############################################################

" Need to set DISPLAY in case tmux deleted the variable
autocmd BufWritePost *.md :silent !export DISPLAY=:0 & markdown -o ~/.var/tmp/surf-preview.html % & surf-preview
autocmd BufWritePost *.adoc :silent !export DISPLAY=:0 & asciidoctor -o ~/.var/tmp/surf-preview.html % && surf-preview

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
nnoremap <C-j> <C-W><C-j>
nnoremap <C-k> <C-W><C-k>
nnoremap <C-l> <C-W><C-l>
nnoremap <C-h> <C-W><C-h>

" Replace word or selected text pressing C-r
nnoremap <C-M-r> :%s/<C-r><C-w>//g<left><left>
vnoremap <C-r> "hy:%s/<C-r>h//g<left><left>

" Fuzzy find files
nnoremap <leader>f :FZF<CR>

" Generate CTAGS with F5
nnoremap <f5> :!ctags -R --exclude=.git --languages=-sql<CR>

" Use TAB in insert mode to go through choices
inoremap <expr><tab> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><s-tab> pumvisible() ? "\<C-p>" : "\<TAB>"


"############################################################
" CUSTOM COMMANDS
"############################################################

command! StripTrailing :call StripTrailing()
command! ST :call StripTrailing()
"
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

