packadd! matchit
lua require('settings')

"############################################################
" PLUGINS
"############################################################
"{{{
" Load settings from plugins.lua
lua require('plugins')

" FZF #######################################################
let g:fzf_preview_window = ['right:50%:nohidden', 'ctrl-/']

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
nnoremap <leader>dn <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <leader>dp <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>

" completion-nvim ###########################################
set shortmess+=c
set signcolumn=yes
set completeopt=menuone,noselect,noinsert

let g:completion_enable_auto_popup = 1
let g:completion_enable_snippet = 'vim-vsnip'
let g:completion_auto_change_source = 0
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
let g:completion_trigger_keyword_length = 2

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

" vim-vsnip #################################################
imap <expr> <c-j> vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<Tab>'
smap <expr> <c-j> vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<Tab>'
imap <expr> <c-l> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'
smap <expr> <c-l> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'

"}}}
"############################################################
" USABILITY SETTINGS
"############################################################
"{{{
" Populate the statusline
source ~/.config/nvim/statusline.vim

" Higlight yanked text
augroup highlight_yank
	autocmd!
	autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END

"}}}
"############################################################
" FORMATTING AND PROGRAMMING SETTINGS
"############################################################
"{{{
" Add included files to completion
set complete+=i

augroup filetypes
	autocmd!
	" Vim
	autocmd FileType vim setlocal foldmethod=marker foldlevel=0
	" sh
	autocmd FileType sh setlocal ts=2 sts=2 sw=2
	" html
	autocmd FileType html setlocal ts=2 sts=2 sw=2
	" Python
	autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab
	" C
	autocmd FileType c,cpp setlocal ts=2 sts=2 sw=2 formatprg=astyle
				\ foldmethod=syntax foldlevel=1
	" go
	autocmd FileType go setlocal formatprg=gofmt
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
noremap <Plug>NohAfter zzzo

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
nnoremap <leader>f :Files<CR>
nnoremap <leader>h :History<CR>

" Ripgrep
nnoremap <leader>g :Rg<CR>

" Export asciidoc to html and open a preview
nnoremap <leader>a :silent !export DISPLAY:=0 &
			\ asciidoctor -o ~/.var/tmp/surf-preview.html % && surf-preview<CR>

" cd in the directory of the current file
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" Add semicolon at the end of the line
nnoremap <leader>; :normal! mqA;<Esc>`q
" Add comma at the end of the line
nnoremap <leader>, :normal! mqA,<Esc>`q

" Move lines
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" Add blank lines
nnoremap <silent>]<Space> :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent>[<Space> :set paste<CR>m`O<Esc>``:set nopaste<CR>

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

