let g:loaded_fzf=1
let mapleader=" "

" other stuff ###############################################
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
	execute 'vert h '.expand('<cword>')
	elseif (index(['c','sh'], &filetype) >=0)
		execute 'vert Man '.expand('<cword>')
	else
		lua vim.lsp.buf.hover()
  endif
endfunction

nnoremap <silent> K :call <SID>show_documentation()<CR>

" Populate the statusline
source ~/.config/nvim/statusline.vim

" Higlight yanked text
augroup highlight_yank
	autocmd!
	autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END

augroup filetypes
	autocmd!
	" asciidoc and others
	autocmd FileType text,plaintext,markdown,asciidoc,help
				\ setlocal noautoindent textwidth=80
				\ nonumber norelativenumber
				\ wrap
				\ foldcolumn=2
				\ | highlight! link FoldColumn Normal
	" Python
	autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab
augroup END

" Open help in vertical slpit
cabbrev vh vert h

command! TrimWhitspaces :call TrimWhitspaces()
command! Col set colorcolumn=81
command! Nocol set colorcolumn=0

function! TrimWhitspaces()
	let l = line(".")
	let c = col(".")
	%s/\s\+$//e
	call cursor(l, c)
endfun
