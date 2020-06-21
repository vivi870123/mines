"javascript lsp config
autocmd FileType typescript, javascript call coc#add_extension('coc-tsserver','coc-eslint', 'coc-prettier' ,'coc-docthis', 'coc-postfix', 'coc-emmet', 'coc-jest')

" PHP config
autocmd FileType php call coc#add_extension('coc-phpls')

" YAML config
autocmd FileType yaml,yml call coc#add_extension('coc-yaml')

" Markdown config
autocmd FileType markdown,md call coc#add_extension('coc-markdownlint')

" HTML config
autocmd FileType html call coc#add_extension('coc-html')

" CSS,LESS,SCSS config
autocmd FileType css,less,scss call coc#add_extension('coc-css')

"shell lsp config
autocmd FileType sh,zsh,bash call coc#add_extension('coc-sh')

"sql lsp config
autocmd FileType sql call coc#add_extension('coc-sql')

"viml lsp config
autocmd FileType vim call coc#add_extension('coc-vimlsp')

"python lsp config
if dein#tap('python-syntax')
    let g:python_highlight_all = 1
    call coc#add_extension('coc-python')
endif


