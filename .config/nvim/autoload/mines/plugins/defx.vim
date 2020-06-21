" Utilities
" from @vim-vinegar
function! mines#plugins#defx#opendir(cmd) abort
  if expand('%') =~# '^$\|^term:[\/][\/]'
    let dir = '.'
  else
    let dir = expand('%:h')
  endif

  call mines#plugins#defx#opencmd(a:cmd.' '.dir)
endfunction

function! mines#plugins#defx#opencmd(cmd) abort
  let cmd = a:cmd =~# '%' ? mines#plugins#defx#fill_buffer_name(a:cmd) : a:cmd
  execute cmd
endfunction

function! mines#plugins#defx#fill_buffer_name(defx_option)
  return printf(a:defx_option, win_getid())
endfunction

function! mines#plugins#defx#get_current_path() abort
  return b:defx['paths'][0]
endfunction

" Mappings
function! mines#plugins#defx#netrw_mapping_for_defx()
  " Cannot override Vinegar '-' mapping, so use '+' instead
  nmap <silent><buffer> - :call mines#plugins#defx#opendir('Defx')<CR>
endfunction

function! mines#plugins#defx#mappings() abort " {{{
  " Define mappings
  if bufname('%') =~# 'tab'
    nnoremap <silent><buffer><expr> <CR> defx#async_action('open')
  elseif bufname('%') =~# 'float'
    nnoremap <silent><buffer><expr> <CR>
          \ defx#is_directory() ?
          \ defx#async_action('open') :
          \ defx#async_action('multi', ['drop', 'quit'])
  else
    nnoremap <silent><buffer><expr> <CR>
          \ defx#is_directory() ?
          \ defx#async_action('open') :
          \ defx#async_action('drop')
  endif

  nnoremap <silent><buffer><expr> cc defx#do_action('copy')
  nnoremap <silent><buffer><expr> ! defx#do_action('execute_command')
  nnoremap <silent><buffer><nowait><expr> m defx#do_action('move')
  nnoremap <silent><buffer><expr> p defx#do_action('paste')
  nnoremap <silent><buffer><expr> l defx#async_action('open')
  nnoremap <silent><buffer><expr> C defx#do_action('toggle_columns', 'mark:filename:type:size:time')
  nnoremap <silent><buffer><expr> S defx#do_action('toggle_sort', 'Time')

  nnoremap <silent><buffer><expr> sv defx#do_action('open', 'botright split')
  nnoremap <silent><buffer><expr> sg defx#do_action('open', 'vsplit')
	nnoremap <silent><buffer><expr> sp defx#do_action('open', 'pedit')
  nnoremap <silent><buffer><expr> st defx#do_action('open', 'tab split')

  nnoremap <silent><buffer><expr> o defx#async_action('open_tree', 'toggle')
  nnoremap <silent><buffer><expr> O defx#async_action('open_tree', 'recursive')

  nnoremap <silent><buffer><expr> K defx#do_action('new_directory')
  nnoremap <silent><buffer><expr> N defx#do_action('new_file')
  nnoremap <silent><buffer><expr> M defx#do_action('new_multiple_files')

  nnoremap <silent><buffer><nowait><expr> dd defx#do_action('remove_trash')
  nnoremap <silent><buffer><expr> r defx#do_action('rename')
  nnoremap <silent><buffer><expr> x defx#do_action('execute_system')
  nnoremap <silent><buffer><expr> . defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> yy defx#do_action('yank_path')
  nnoremap <silent><buffer><expr> h defx#async_action('cd', ['..'])
  nnoremap <silent><buffer><expr> <BS> defx#async_action('cd', ['..'])
  nnoremap <silent><buffer><expr> <C-H> defx#async_action('cd', ['..'])
  nnoremap <silent><buffer><expr> ~ defx#async_action('cd')

  nnoremap <silent><buffer><expr> gr defx#do_action('cd', '/')
  nnoremap <silent><buffer><expr> gl defx#do_action('cd', '/usr/lib/')
  nnoremap <silent><buffer><expr> gv defx#do_action('cd', $VIMRUNTIME)


  nnoremap <silent><buffer><expr> \ defx#do_action('cd', getcwd())
  nnoremap <silent><buffer><nowait><expr> \\ defx#do_action('cd', getcwd())

  nnoremap <silent><buffer><expr> cb defx#do_action('call', 'mines#plugins#defx#change_vim_buffer_cwd')
  nnoremap <silent><buffer><expr> cv defx#do_action('cd', expand(input('cd: ', '', 'dir')))

	nnoremap <silent><buffer><expr> w   defx#do_action('call', 'mines#plugins#defx#toggle_width')

  if bufname('%') =~# 'tab'
    nnoremap <silent><buffer><expr> q defx#do_action('quit') . ":quit<CR>"
  else
    nnoremap <silent><buffer><expr> q defx#do_action('quit')
  endif
  nnoremap <silent><buffer><nowait><expr> ` defx#do_action('toggle_select') . 'j'
  nnoremap <silent><buffer><expr> * defx#do_action('toggle_select_all')
  nnoremap <silent><buffer><expr> j line('.') == line('$') ? 'gg' : 'j'
  nnoremap <silent><buffer><expr> k line('.') == 1 ? 'G' : 'k'
  nnoremap <silent><buffer><expr> <C-L> defx#do_action('redraw')
  xnoremap <silent><buffer><expr> <CR> defx#do_action('toggle_select_visual')
  nnoremap <silent><buffer><expr> <C-G> defx#do_action('print')
endfunction " }}}

function! mines#plugins#defx#change_vim_buffer_cwd(context) abort
  let path = mines#plugins#defx#get_current_path()

  execute 'lcd '.fnameescape(path)
endfunction

" Defx detect folder
function! mines#plugins#defx#detect_folder(path)
  if a:path !=# '' && isdirectory(a:path)
    execute 'silent! Defx '.a:path
  endif
endfunction

let s:original_width = get(get(defx#custom#_get().option, '_'), 'winwidth')
function! mines#plugins#defx#toggle_width(context) abort
	" Toggle between defx window width and longest line
	let l:max = 0
	for l:line in range(1, line('$'))
		let l:len = len(getline(l:line))
		let l:max = max([l:len, l:max])
	endfor
	let l:new = l:max == winwidth(0) ? s:original_width : l:max
	call defx#call_action('resize', l:new)
endfunction
