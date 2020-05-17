"############################################################
" PLUGINS
"############################################################
"{{{
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
Plug '/usr/bin/fzf' | Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-unimpaired'
Plug 'christoomey/vim-tmux-navigator'
Plug 'moll/vim-bbye'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'unblevable/quick-scope'

" General for programming
Plug 'tpope/vim-surround' | Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'

" Debug with gdb etc...
Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh \| UpdateRemotePlugins' }

" Text objects
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'

" Completion and snippets
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Initialize plugin system
call plug#end()
"}}}
"############################################################
" PLUGIN SETTINGS
"############################################################
"{{{
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

" colorizer #################################################
set termguicolors "Required by colorizer setup
lua require 'colorizer'.setup()

" quick-scope ###############################################
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" UltiSnips #################################################
let g:UltiSnipsExpandTrigger="<c-k>"

" coc.nvim ##################################################
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
" unmap <expr>gd
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'vert h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <F2> <Plug>(coc-rename)

" Formatting selected code.
xmap <F3>  <Plug>(coc-format-selected)
nmap <F3>  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap keys for applying codeAction to the current line.
nmap <F4>  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <F6>  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

"}}}
"############################################################
" GENERAL SETTINGS
"############################################################
"{{{
" VIM runtime path
set runtimepath += "~/.local/share/nvim/runtime/"
" Tell vim to use zsh instead of bash
set shell=/bin/zsh

" Spell check settings
set spelllang=it,en

" Tabs and folding
set tabstop=2
set softtabstop=2
set noexpandtab
set shiftwidth=0
set foldnestmax=1

" Enable persistent undo
set undofile

" Search for subdirs as well
set path+=**
"}}}
"############################################################
" THEME AND GUI RELATED SETTINGS
"############################################################
"{{{
" Set colors
set background=dark
colorscheme base16-ghetto

" Text width and column highlight
set textwidth=0
command! Col set colorcolumn=81
command! Nocol set colorcolumn=0
set nowrap

"}}}
"############################################################
" USABILITY SETTINGS
"############################################################
"{{{
" Split in the correct way
set splitbelow
set splitright
set diffopt+=vertical

" Highlight current line and show relative line numbers
set cursorline
set number relativenumber numberwidth=5

" Keep some lines for context
set scrolloff=5

" Search
set ignorecase
set smartcase
set inccommand=nosplit

" Ex completion
set wildmenu
set wildmode=longest:full,full

" Use mouse
set mouse+=a

" Set clipboard
set clipboard+=unnamedplus

" Don't redraw the screen while executing macros
set lazyredraw

" Populate the statusline
source ~/.config/nvim/statusline.vim

" Highlight trailing spaces
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
" Tree style for directories navigation
let g:netrw_liststyle= 3

"}}}
"############################################################
" FORMATTING AND PROGRAMMING SETTINGS
"############################################################
"{{{
" Ebable file types plugin and omnifunction
filetype plugin indent on

" Add included files to completion
set complete+=i

" Disable annoying preview window!
set completeopt-=preview

augroup filetypes
	autocmd!
	" Vim
	autocmd FileType vim setlocal foldmethod=marker foldlevel=0
	" sh
	autocmd FileType sh setlocal ts=2 sts=2 sw=2
				" \ omnifunc=syntaxcomplete#Complete
	" Python
	autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab
	" C
	autocmd FileType c setlocal ts=2 sts=2 sw=2 formatprg=astyle
				\ foldmethod=syntax foldlevel=1
	" asciidoc
	autocmd FileType plaintext,markdown,asciidoc,help
				\ setlocal ts=2 sts=2 sw=2 noautoindent textwidth=80
				\ nonumber norelativenumber
				\ foldcolumn=2
				\ | highlight! link FoldColumn Normal
augroup END

"}}}
"############################################################
" KEY BINDINGS
"############################################################
"{{{
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

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

" Replace visual selection with yanked text
vnoremap <M-r> dh"0p

" Fuzzy find files
nnoremap <leader>f :Files!<CR>
nnoremap <leader>h :History!<CR>

" Ripgrep
nnoremap <leader>g :Rg!<CR>

" Export asciidoc to html and open a preview
" nnoremap <leader>a :silent !export DISPLAY:=0 &
" 			\ asciidoctor -o ~/.var/tmp/surf-preview.html % && surf-preview<CR>

" cd in the directory of the current file
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" Add semicolon at the end of the line
nnoremap <leader>; :normal! mqA;<Esc>`q

" Open help in vertical slpit
cabbrev vh vert h
"}}}
"############################################################
" CUSTOM COMMANDS
"############################################################
"{{{
command! TrimWhitspaces :call TrimWhitspaces()
"}}}
"############################################################
" CUSTOM FUNCTIONS
"############################################################
"{{{
" Strip all trailing spaces on write
function! TrimWhitspaces()
	let l = line(".")
	let c = col(".")
	%s/\s\+$//e
	call cursor(l, c)
endfun

"}}}
