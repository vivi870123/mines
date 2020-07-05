let g:coc_force_debug = 1
let g:coc_auto_open = v:false
let coc_disable_transparent_cursor = 1

augroup user_plugin_load_autocommands
	autocmd!
	autocmd VimEnter * call s:load_coc()
augroup END

" Packages {{{
function! s:load_coc() abort
	let g:coc_global_extensions = [
					\ 'coc-actions',
					\ 'coc-calc',
					\ 'coc-css',
					\ 'coc-diagnostic',
					\ 'coc-docthis',
					\ 'coc-emmet',
					\ 'coc-explorer',
					\ 'coc-eslint',
					\ 'coc-git',
					\ 'coc-gitignore',
					\ 'coc-highlight',
					\ 'coc-html',
					\ 'coc-lists',
					\ 'coc-jest',
					\ 'coc-json',
					\ 'coc-markdownlint',
					\ 'coc-marketplace',
					\ 'coc-pairs',
					\ 'coc-phpls',
					\ 'coc-postfix',
					\ 'coc-prettier',
					\ 'coc-project',
					\ 'coc-python',
					\ 'coc-sh',
					\ 'coc-snippets',
					\ 'coc-spell-checker',
					\ 'coc-sql',
					\ 'coc-syntax',
					\ 'coc-tsserver',
					\ 'coc-ultisnips',
					\ 'coc-vimlsp',
					\ 'coc-word',
					\ 'coc-yaml',
					\ 'coc-yank',
					\ ]
	" }}}

	augroup user_plugin_coc
		autocmd!

		autocmd CursorHold * silent call CocActionAsync('highlight')

		autocmd BufWritePost coc.vim source % | CocRestart

		autocmd FileType python,rust call s:map_function_objects()
		autocmd FileType python let b:coc_root_patterns = ['pyproject.toml', '.git', '.env']

		" Setup formatexpr specified filetype(s).
		autocmd FileType typescript,json setl formatexpr=CocActionAsync('formatSelected')

		autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
		autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

		"python lsp config
		if dein#tap('python-syntax')
				let g:python_highlight_all = 1
		endif
	augroup END
endfunction


" Mappings {{{
" --------
inoremap <silent><expr> <TAB>
	\ pumvisible() ? "\<C-n>" :
	\ mines#insert#check_back_space() ? "\<TAB>" :
	\ coc#refresh()

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" use enter to accept snippet expansion
inoremap <expr> <cr> pumvisible() ? "\<c-y>" : "\<c-g>u\<cr>"

" use <c-space>for trigger completion
inoremap <silent> <expr> <c-space> coc#refresh()

" <c-x><c-g>: start ultisnips completion
inoremap <silent> <C-X><C-G> <C-R>=coc#start({ 'source': 'ultisnips' })<CR>


" Define mapping for diff mode to avoid recursive mapping
" use `[g` and `]g` to navigate diagnostics
nnoremap <silent> <Plug>(diff-prev) [g
nnoremap <silent> <Plug>(diff-next) ]g
nmap <silent><expr> [g &diff ? "\<Plug>(diff-prev)" : "\<Plug>(coc-diagnostic-prev)"
nmap <silent><expr> ]g &diff ? "\<Plug>(diff-next)" : "\<Plug>(coc-diagnostic-next)"

nmap <silent><expr> <leader>k &diff ? "\<Plug>(diff-prev)" : "\<Plug>(coc-diagnostic-prev)"
nmap <silent><expr> <leader>j &diff ? "\<Plug>(diff-next)" : "\<Plug>(coc-diagnostic-next)"

" remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gY <Plug>(coc-type-definition)
nmap <silent> gY <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gn <Plug>(coc-rename)

nmap <silent> <leader>a :CocCommand actions.open<cr>
xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@

" remap for do codeaction of current line
nmap <leader>ac  <Plug>(coc-codeaction)

" fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" use K to show documentation in preview window
nnoremap <silent> K mines#coc#show_documentation()<CR>


nnoremap <silent> <leader>g :echo get(b:, 'coc_current_function', '')<CR>

" }}}
" Extensions {{{
" ----------

" coc-git
" -------
nmap <silent> <expr> [c &diff ? '[c' : '<Plug>(coc-git-prevchunk)'
nmap <silent> <expr> ]c &diff ? ']c' : '<Plug>(coc-git-nextchunk)'
nmap <leader>hi <Plug>(coc-git-chunkinfo)
nnoremap <leader>hs :CocCommand git.chunkStage<cr>
nnoremap <leader>hu :CocCommand git.chunkUndo<cr>

" coc-snippet
" -----------
let g:coc_snippet_next = '<c-j>'
let g:coc_snippet_prev = '<c-k>'

" }}}
" Helper Functions {{{
" ----------------
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction

" }}}
" Commands {{{
" --------
" Use `:Format` to format current buffer
command! -nargs=0 Prettier	:CocCommand prettier.formatFile
" Use `:Fold` to fold current buffer
command! -nargs=? Fold			:call CocActionAsync('fold', <f-args>)
" use `:OR` for organize import of current buffer
command! -nargs=0 OR				:call CocActionAsync('runCommand', 'editor.action.organizeImport')

" }}}

" vim: set foldmethod=marker ts=2 sw=2 tw=80 noet :
