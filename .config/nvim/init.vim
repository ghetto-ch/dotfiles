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
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-abolish'
" Plug 'tpope/vim-eunuch'
" Plug 'tpope/vim-speeddating'
" Plug 'kana/vim-textobj-user'
" Plug 'kana/vim-textobj-entire'

" General for programming
Plug 'tpope/vim-surround' | Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-endwise' | Plug 'rstacruz/vim-closer'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neco-vim'
Plug 'Shougo/neoinclude.vim'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'dense-analysis/ale'

" Golang
Plug 'fatih/vim-go'
", { 'do': ':GoUpdateBinaries' }
Plug 'deoplete-plugins/deoplete-go', { 'do': 'make'}

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
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Neosnippets ###############################################
imap <C-j> <Plug>(neosnippet_expand_or_jump)
smap <C-j> <Plug>(neosnippet_expand_or_jump)
xmap <C-j> <Plug>(neosnippet_expand_target)

smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
			\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" ALE #######################################################
let g:ale_enabled=0
let g:ale_c_parse_makefile=1
let g:ale_c_parse_compile_commands=1
" let g:ale_linters = {
" 			\ 'cpp': ['clangd'] ,
" 			\ 'c': ['clangd'] ,
" 			\ }

"############################################################
" GENERAL SETTINGS
"############################################################
"
" Tell vim to use zsh instead of bash
set shell=/bin/zsh

" Spell check settings
set spelllang=it,en
" highlight SpellBad cterm=Reverse ctermbg=Red
" highlight SpellCap ctermbg=Yellow
" highlight SpellRare ctermbg=DarkYellow
" highlight SpellLocal ctermbg=Magenta

" Tabs and folding
set tabstop=2
set softtabstop=2
set shiftwidth=0
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
set termguicolors

" Load Base16 theme
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
set inccommand=nosplit
" nnoremap / /\v
" cnoremap s/ s/\v

" Ex completion
set wildmenu
set wildmode=full

" Use mouse
set mouse+=a

" Don't redraw the screen while executing macros
set lazyredraw

" Populate the statusline
source ~/.config/nvim/statusline.vim

" Highlight unuseful whitespaces
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

" Display as tree when browsing directories
let g:netrw_liststyle=3

"############################################################
" PROGRAMMING SETTINGS
"############################################################

" Ebable file types plugin and omnifunction
filetype plugin indent on
" set omnifunc=syntaxcomplete#Complete
" Add included files to completion
set complete+=i

augroup indentation
	autocmd!
	" Python indentation
	autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab
	" Ruby
	autocmd FileType ruby setlocal ts=2 sts=2 sw=2 expandtab
	" C
	autocmd FileType c,go setlocal ts=2 sts=2 sw=2
augroup END

"############################################################
" SOME AUTOCOMMANDS
"############################################################

augroup adoc
	autocmd!
	" Need to set DISPLAY in case tmux deleted the variable
	autocmd BufWritePost *.md :silent !export DISPLAY=:0 & markdown -o ~/.var/tmp/surf-preview.html % && surf-preview
	autocmd BufWritePost *.adoc :silent !export DISPLAY=:0 & asciidoctor -o ~/.var/tmp/surf-preview.html % && surf-preview
augroup END

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
nnoremap <M-d> :bd!<CR>

" Windows
nnoremap <C-j> <C-W><C-j>
nnoremap <C-k> <C-W><C-k>
nnoremap <C-l> <C-W><C-l>
nnoremap <C-h> <C-W><C-h>

" Rerun the last executed macro
nnoremap Q @@

" Replace selected text pressing C-r, use very nomagic
vnoremap <C-r> "hy:%s/\V<C-r>h
" //g<left><left>

" Fuzzy find files
nnoremap <leader>f :FZF<CR>

" Generate CTAGS with F5
nnoremap <f5> :!ctags

" Use TAB in insert mode to go through choices
inoremap <expr><tab> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><s-tab> pumvisible() ? "\<C-p>" : "\<TAB>"

" Enable completion
nmap <leader>c :call deoplete#toggle()<CR>

" Enable linting
nmap <silent> <leader>l <Plug>(ale_toggle)

" Go to next/previous lint
nmap <silent> <leader>n <Plug>(ale_next)
nmap <silent> <leader>p <Plug>(ale_previous)

" Get lint info
nmap <silent> <leader>i <Plug>(ale_info)

" Search for selection in visual mode
xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>

" Open help in vertical slpit
cabbrev vh vert h

"############################################################
" CUSTOM COMMANDS
"############################################################

command! StripTrailing :call StripTrailing()
command! ST :call StripTrailing()
command! -nargs=* Z :call Z(<f-args>)
command! Args :call SetArgumentListByFzf()
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

" Search for selection in visual mode
function! s:VSetSearch(cmdtype)
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

" Z - cd to recent / frequent directories
function! Z(...)
  let cmd = 'fasd -d -e printf'
  for arg in a:000
    let cmd = cmd . ' ' . arg
  endfor
  let path = system(cmd)
  if isdirectory(path)
    echo path
    exec 'cd' fnameescape(path)
  endif
endfunction

" Add files to arglist with FZF
function! SetArgumentListByFzf()
    " Clear argument list
    execute "%argdelete"
    " Run fzf with preview and select files.
    " Run argadd command passing seleted files as argument.
    call fzf#run(fzf#wrap({'sink': 'argadd', 'options': '--multi' }))
endfunction
