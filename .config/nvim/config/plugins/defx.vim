" Defx plugin {{{
" -----------
let g:defx_ignore_filtype = ['denite', 'defx', 'vista', 'vista_kind', 'coc']

call defx#custom#option('_', {
	\ 'buffer_name': 'explorer',
	\ 'columns': 'marks:indent:icons:filename',
	\ 'show_ignored_files': 0,
	\ 'root_marker': ' ',
	\ 'ignored_files':
	\     '.mypy_cache,.pytest_cache,.git,.hg,.svn,.stversions'
	\   . ',__pycache__,.sass-cache,*.egg-info,.DS_Store,*.pyc'
	\ })

call defx#custom#column('icon', {
      \ 'directory_icon': '▸',
      \ 'opened_icon': '▾',
      \ 'root_icon': ' ',
      \ })

" defx-icons plugin
let g:defx_icons_column_length = 2
let g:defx_icons_mark_icon = ''


augroup netrw_mapping_for_defx
  autocmd!
  autocmd FileType netrw call mines#plugins#defx#netrw_mapping_for_defx()
augroup END

let [g:defx_width, g:defx_height] = mines#float#get_default_size()
let [g:defx_left, g:defx_top] = mines#float#calculate_pos(g:defx_width, g:defx_height)
let g:defx_resume_options = '-listed -resume'
let g:defx_win_options = '-buffer-name=win-%d'
let g:defx_tab_options = '-buffer-name=tab-%d'
let g:defx_float_options = '-buffer-name=float-%d -winwidth='.g:defx_width.' -winheight='.g:defx_height.' -wincol='.g:defx_left.' -winrow='.g:defx_top

augroup defx_mappings
  autocmd!
  autocmd FileType defx call mines#plugins#defx#mappings()
augroup END

augroup defx_detect_folder
  autocmd!
  " Disable netrw autocmd
  autocmd VimEnter * autocmd! FileExplorer
  autocmd BufEnter * call mines#plugins#defx#detect_folder(expand('<afile>'))
augroup END
