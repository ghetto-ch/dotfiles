" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')
Plug 'junegunn/vim-plug'

" Usability
Plug '/usr/bin/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-unimpaired'
Plug 'christoomey/vim-tmux-navigator'
Plug 'jesseleite/vim-noh'
Plug 'moll/vim-bbye'
Plug 'junegunn/vim-peekaboo'

" General for programming
Plug 'tpope/vim-surround' | Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise' | Plug 'rstacruz/vim-closer'
Plug 'ajh17/VimCompletesMe'
Plug 'ghetto-ch/vim-minisnip', { 'branch': 'testing' }

" Debug with gdb etc...
Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh \| UpdateRemotePlugins' }

" Testing for vim script
Plug 'junegunn/vader.vim'

" Initialize plugin system
call plug#end()

"############################################################
" PLUGIN SETTINGS
"############################################################

" FZF #######################################################

" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Insert mode completion
" imap <c-x><c-k> <plug>(fzf-complete-word)
inoremap <expr> <plug>(fzf-complete-mypath)
			\ fzf#vim#complete#path("fd -H --exclude .git .")
imap <c-x><c-f> <plug>(fzf-complete-mypath)
inoremap <expr> <plug>(fzf-complete-myfile)
			\ fzf#vim#complete#path("fd -H --exclude .git --type f .")
imap <c-x><c-j> <plug>(fzf-complete-myfile)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Use preview when Files runs in fullscreen
command! -nargs=? -bang -complete=dir Files
      \ call fzf#vim#files(
			\   <q-args>, <bang>0 ? fzf#vim#with_preview('up:60%') : {}, <bang>0)

" Use preview when History runs in fullscreen
command! -nargs=? -bang -complete=dir History
      \ call fzf#vim#history(
			\   <bang>0 ? fzf#vim#with_preview('up:60%') : {}, <bang>0)

command! -bang -nargs=* Rg
			\ call fzf#vim#grep(
			\   'rg --column --line-number --no-heading --color=always --smart-case
			\   '.shellescape(<q-args>), 1,
			\   <bang>0 ? fzf#vim#with_preview('up:60%')
			\           : fzf#vim#with_preview('right:50%:hidden', '?'),
			\   <bang>0)

" Peekaboo ##################################################
let g:peekaboo_window = 'vert bo 50new'

" minisnip ##################################################
let g:minisnip_trigger = '<c-j>'
let g:minisnip_backreffirst = 1

"############################################################
" GENERAL SETTINGS
"############################################################
"
" Tell vim to use zsh instead of bash
set shell=/bin/zsh

" Spell check settings
set spelllang=it,en

" Tabs and folding
set tabstop=2
set softtabstop=2
set noexpandtab
set shiftwidth=0
set foldmethod=indent
set foldlevelstart=99

" Enable persistent undo
set undofile

" Search for subdirs as well
set path+=**

"############################################################
" THEME AND GUI RELATED SETTINGS
"############################################################

" Set colors
set background=dark
set termguicolors

source ~/dotfiles/.config/nvim/base16-default-dark-custom.vim

" Should customize the file above... but for now :)
hi Comment guifg=#999999
hi LineNr guifg=lightgrey
hi CursorLineNr guifg=darkorange

" Text width and column highlight
set textwidth=80
command! Col set colorcolumn=+1
command! Nocol set colorcolumn=0

"############################################################
" USABILITY SETTINGS
"############################################################

" Split in the correct way
set splitbelow
set splitright
set diffopt+=vertical

" Highlight current line and show relative line numbers
set cursorline
set number relativenumber

" Keep some lines for context
set scrolloff=5

" Search
set ignorecase
set smartcase
set inccommand=nosplit

" Ex completion
set wildmenu
set wildmode=full

" Use mouse
set mouse+=a

" Set clipboard
set clipboard+=unnamedplus

" Don't redraw the screen while executing macros
set lazyredraw

" Populate the statusline
source ~/.config/nvim/statusline.vim

" Highlight trailng spaces
highlight ExtraWhitespace ctermbg=darkred guibg=darkred
match ExtraWhitespace /\s\+$/
augroup whitespace
	autocmd!
	autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
	autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
	autocmd InsertLeave * match ExtraWhitespace /\s\+$/
	autocmd BufWinLeave * call clearmatches()
augroup END

" Stop complaining about modified buffers
set hidden

"############################################################
" PROGRAMMING SETTINGS
"############################################################

" Ebable file types plugin and omnifunction
filetype plugin indent on

" Add included files to completion
set complete+=i

"############################################################
" SOME AUTOCOMMANDS
"############################################################

augroup indentation
	autocmd!
	" Python
	autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab
	" C
	autocmd FileType c,go setlocal ts=2 sts=2 sw=2
	" asciidoc
	autocmd FileType plaintext,markdown,asciidoc
				\ setlocal ts=2 sts=2 sw=2 noautoindent
augroup END

augroup linting
	autocmd!
	autocmd FileType python setlocal makeprg=pylint\ --output-format=parseable
	autocmd BufWritePost *.py silent make! <afile> | silent redraw!
	autocmd BufWritePost *.c silent make | silent redraw!
	autocmd QuickFixCmdPost [^l]* cwindow
augroup END

"############################################################
" KEY BINDINGS
"############################################################

let mapleader = ' '
set timeoutlen=2000

" Search
nnoremap <Esc><Esc> :<C-u>nohlsearch<CR>
noremap <Plug>NohAfter zz

" Buffers
nnoremap <C-n> :bnext!<CR>
vnoremap <C-n> :bnext!<CR>
nnoremap <C-p> :bprevious!<CR>
vnoremap <C-p> :bprevious!<CR>
nnoremap <M-d> :Bdelete<CR>

" Replace selected text pressing C-r, use very nomagic
vnoremap <C-r> "hy:%s/\V<C-r>h

" Fuzzy find files
nnoremap <leader>f :Files!<CR>
nnoremap <leader>h :History!<CR>

" Ripgrep
nnoremap <leader>g :Rg!<CR>

" Export asciidoc to html and open a preview
nmap <leader>a :silent !export DISPLAY:=0 &
			\ asciidoctor -o ~/.var/tmp/surf-preview.html % && surf-preview<CR>

nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" Open help in vertical slpit
cabbrev vh vert h

"############################################################
" CUSTOM COMMANDS
"############################################################

command! StripTrailing :call StripTrailing()
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
