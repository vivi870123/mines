augroup text_obj
	autocmd!
	autocmd FileType text call pencil#init()
	autocmd FileType text call textobj#sentence#init()
  autocmd FileType text call textobj#quote#init({'educate': 0})
augroup END

augroup wordchipper
	autocmd!
	autocmd FileType markdown,mkd,text
					\   inoremap <buffer> <expr> <C-e> wordchipper#chipWith('de')
					\ | inoremap <buffer> <expr> <C-w> wordchipper#chipWith('dB')
					\ | inoremap <buffer> <expr> <C-y> wordchipper#chipWith('d)')
augroup END

augroup prosemappingd
	autocmd!
	autocmd FileType markdown,mkd,text
					\   inoremap <buffer> <leader>gc wordchipper#chipWith('de')
					\ | inoremap <buffer> <expr> <C-w> wordchipper#chipWith('dB')
					\ | inoremap <buffer> <expr> <C-y> wordchipper#chipWith('d)')
augroup END



