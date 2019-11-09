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
inoremap <expr> <plug>(fzf-complete-mypath) fzf#vim#complete#path("fd -H --exclude .git .")
imap <c-x><c-f> <plug>(fzf-complete-mypath)
inoremap <expr> <plug>(fzf-complete-myfile) fzf#vim#complete#path("fd -H --exclude .git --type f .")
imap <c-x><c-j> <plug>(fzf-complete-myfile)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Neosnippets ###############################################
imap <C-j> <Plug>(neosnippet_expand_or_jump)
smap <C-j> <Plug>(neosnippet_expand_or_jump)
xmap <C-j> <Plug>(neosnippet_expand_target)

smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
			\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" Use preview when Files runs in fullscreen
command! -nargs=? -bang -complete=dir Files
      \ call fzf#vim#files(<q-args>, <bang>0 ? fzf#vim#with_preview('up:60%') : {}, <bang>0)

" Use preview when History runs in fullscreen
command! -nargs=? -bang -complete=dir History
      \ call fzf#vim#history(<bang>0 ? fzf#vim#with_preview('up:60%') : {}, <bang>0)

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" ALE #######################################################
let g:ale_enabled=0
let g:ale_c_parse_makefile=1
let g:ale_c_parse_compile_commands=1

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
set t_Co=256
set termguicolors

" Load Base16 theme
if filereadable(expand("~/.vimrc_background"))
	source ~/.vimrc_background
endif

" Some customization of the theme
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

" Add included files to completion
set complete+=i

"############################################################
" SOME AUTOCOMMANDS
"############################################################

augroup indentation
	autocmd!
	" Python
	autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab
	" Ruby
	autocmd FileType ruby setlocal ts=2 sts=2 sw=2 expandtab
	" C
	autocmd FileType c,go setlocal ts=2 sts=2 sw=2
	" asciidoc
	autocmd FileType plaintext,markdown,asciidoc setlocal ts=2 sts=2 sw=2 noautoindent
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
" nnoremap <leader>f :Files<CR>
nnoremap <leader>f :Files!<CR>
nnoremap <leader>h :History!<CR>

" Ripgrep with preview
nnoremap <leader>g :Rg!<CR>

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

" Export asciidoc to html and open a preview
nmap <leader>a :silent !export DISPLAY=:0 & asciidoctor -o ~/.var/tmp/surf-preview.html % && surf-preview<CR>

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
