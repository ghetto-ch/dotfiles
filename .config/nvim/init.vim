lua require('settings')
lua require('plugins')

" vim-slime #################################################
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}
let g:slime_dont_ask_default = 1
let g:slime_no_mappings = 1
xmap gs <Plug>SlimeRegionSend
nmap gss <Plug>SlimeLineSend
nmap gs <Plug>SlimeMotionSend

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

" Populate the statusline
source ~/.config/nvim/statusline.vim

" Higlight yanked text
augroup highlight_yank
	autocmd!
	autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END

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

" Open help in vertical slpit
cabbrev vh vert h

command! TrimWhitspaces :call TrimWhitspaces()
command! Col set colorcolumn=81
command! Nocol set colorcolumn=0

" Strip all trailing spaces on write
function! TrimWhitspaces()
	let l = line(".")
	let c = col(".")
	%s/\s\+$//e
	call cursor(l, c)
endfun
