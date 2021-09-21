lua require('settings')
lua require('plugins')

" preset clipboard to speedup sourcing clipboard.vim
let g:clipboard = {
        \   'name': 'xsel - bin',
        \   'copy': {
        \      '+': '/bin/xsel -i -b',
        \      '*': '/bin/xsel -i -p',
        \    },
        \   'paste': {
        \      '+': '/bin/xsel -b',
        \      '*': '/bin/xsel -p',
        \   },
        \   'cache_enabled': 0,
\ }

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
