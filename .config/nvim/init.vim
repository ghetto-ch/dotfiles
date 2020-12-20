" Map leader key
let mapleader = ' '
set termguicolors
packadd! matchit

"############################################################
" THEME AND GUI RELATED SETTINGS
"############################################################
"{{{
" Set colors
set background=dark
colorscheme base16-ghetto

" Text width and column highlight
set textwidth=0
set nowrap

"}}}
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
Plug 'ghetto-ch/vim-noh'

" General for programming
Plug 'tpope/vim-surround' | Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise' | Plug 'rstacruz/vim-closer'
Plug 'jpalardy/vim-slime'
Plug 'tjdevries/nlua.nvim'

" Debug with gdb etc...
Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh \| UpdateRemotePlugins' }

" Text objects
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'wellle/targets.vim'

" Completion and snippets
Plug 'neovim/nvim-lspconfig'
Plug 'haorenW1025/completion-nvim'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

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
inoremap <c-x><c-f> <plug>(fzf-complete-mypath)
inoremap <expr> <plug>(fzf-complete-myfile)
			\ fzf#vim#complete#path("fd -H --exclude .git --type f .")
inoremap <c-x><c-j> <plug>(fzf-complete-myfile)
inoremap <c-x><c-l> <plug>(fzf-complete-line)

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
lua require 'colorizer'.setup()

" quick-scope ###############################################
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" vim-slime #################################################
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}
let g:slime_dont_ask_default = 1
let g:slime_no_mappings = 1
xmap gs <Plug>SlimeRegionSend
nmap gss <Plug>SlimeLineSend
nmap gs <Plug>SlimeMotionSend

" nvim-lsp ##################################################
lua << EOF
local on_attach_vim = function(client)
  require'completion'.on_attach(client)
end

require'lspconfig'.clangd.setup{on_attach=on_attach_vim}
require'lspconfig'.bashls.setup{on_attach=on_attach_vim}
require'lspconfig'.vimls.setup{on_attach=on_attach_vim}
require'lspconfig'.gopls.setup{on_attach=on_attach_vim}
require('nlua.lsp.nvim').setup(require('lspconfig'), {
  on_attach = on_attach_vim,
  globals = {
    -- Colorbuddy
    "Color", "c", "Group", "g", "s",
  }
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = {
      spacing = 4,
      prefix = ' ',
    },
  }
)
EOF

nnoremap <leader>dn <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <leader>dp <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>

" completion-nvim ###########################################
set shortmess+=c
set signcolumn=yes
set completeopt=menuone,noselect,noinsert

let g:completion_enable_auto_popup = 1
let g:completion_enable_snippet = 'vim-vsnip'
let g:completion_auto_change_source = 0
let g:completion_matching_strategy_list = ['fuzzy', 'substring', 'exact']
let g:completion_trigger_keyword_length = 3

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ completion#trigger_completion()

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'vert h '.expand('<cword>')
	elseif (index(['c','sh'], &filetype) >=0)
		execute 'vert Man '.expand('<cword>')
	else
		lua vim.lsp.buf.hover()
  endif
endfunction

nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     :call <SID>show_documentation()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> gt    <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> <F2>  <cmd>lua vim.lsp.buf.rename()<CR>

let g:endwise_no_mappings = 1
let g:completion_confirm_key = ""
imap <expr> <cr>  pumvisible() ?
			\ complete_info()["selected"] != "-1" ?
				\ "\<Plug>(completion_confirm_completion)" :
				\ get(b:, 'closer') ?
					\ "\<c-e>\<CR>\<Plug>DiscretionaryEnd\<Plug>CloserClose"
					\ : "\<c-e>\<CR>\<Plug>DiscretionaryEnd"
			\ : get(b:, 'closer') ?
				\ "\<CR>\<Plug>DiscretionaryEnd\<Plug>CloserClose"
				\ : "\<CR>\<Plug>DiscretionaryEnd"

" nvim-treesitter ###########################################
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  indent = {
    enable = true
  },
}
EOF

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
set tabstop=4
set softtabstop=4
set noexpandtab
set shiftwidth=0
set foldnestmax=1

" Enable persistent undo
set undofile

" Search for subdirs as well
set path+=**
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

" Stop complaining about modified buffers
set hidden
" Tree style for directories navigation
let g:netrw_liststyle= 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 20

" Show non printable chars
set list
set listchars=tab:→\ ,trail:░,extends:…,precedes:…,conceal:┊,nbsp:␣

"}}}
"############################################################
" FORMATTING AND PROGRAMMING SETTINGS
"############################################################
"{{{
" Ebable file types plugin and omnifunction
filetype plugin indent on

" Add included files to completion
set complete+=i

augroup filetypes
	autocmd!
	" Vim
	autocmd FileType vim setlocal foldmethod=marker foldlevel=0
	" sh
	autocmd FileType sh setlocal ts=4 sts=4 sw=4
	" Python
	autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab
	" C
	autocmd FileType c setlocal ts=4 sts=4 sw=4 formatprg=astyle
				\ foldmethod=syntax foldlevel=1
	" asciidoc and others
	autocmd FileType text,plaintext,markdown,asciidoc,help
				\ setlocal ts=2 sts=2 sw=2 noautoindent textwidth=80
				\ nonumber norelativenumber
				\ signcolumn=no
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
nnoremap <C-q> :quit<CR>

" Replace selected text pressing C-r, use very nomagic
vnoremap <C-r> "hy:%s/\V<C-r>h

" Replace visual selection with yanked text
" TODO: fix bug when the text to be replaced is at the end of the line.
vnoremap <M-r> dh"0p

" Fuzzy find files
nnoremap <leader>f :Files!<CR>
nnoremap <leader>h :History!<CR>

" Ripgrep
nnoremap <leader>g :Rg!<CR>

" Export asciidoc to html and open a preview
nnoremap <leader>a :silent !export DISPLAY:=0 &
			\ asciidoctor -o ~/.var/tmp/surf-preview.html % && surf-preview<CR>

" cd in the directory of the current file
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" Add semicolon at the end of the line
nnoremap <leader>; :normal! mqA;<Esc>`q
" Add comma at the end of the line
nnoremap <leader>, :normal! mqA,<Esc>`q

" Use nterw to explore directories
nnoremap <leader>e :Lexplore<CR>

" Open help in vertical slpit
cabbrev vh vert h
"}}}
"############################################################
" CUSTOM COMMANDS
"############################################################
"{{{
command! TrimWhitspaces :call TrimWhitspaces()
command! Col set colorcolumn=81
command! Nocol set colorcolumn=0
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

