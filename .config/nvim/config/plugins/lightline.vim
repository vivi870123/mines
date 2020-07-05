" bufferline
let g:lightline#bufferline#show_number  = 0
let g:lightline#bufferline#unicode_symbols = 0
let g:lightline#bufferline#shorten_path = 1
let g:lightline#bufferline#enable_devicons = 1
let g:lightline#bufferline#filename_modifier = ':t'
let g:lightline#bufferline#unnamed = '[No Name]'

let g:lightline_hybrid_style = 'plain'
let g:lightline_gruvbox_style = 'hard_left'

let g:lightline = {
	\
	\ 'colorscheme': 'hybrid',
	\ 'active': {
	\   'left': [ 
	\			[ 'homemode', 'paste' ], 
	\			[ 'tuncate', 'filename_active' ],
	\  ],
	\   'right':[
	\			[ 'lineinfo' ], 
	\     [ 'cocstatus' ], 
	\     [ 'coc_errors', 'coc_warnings', 'coc_ok' ], 
	\			[ 'gitinfo' ], 
	\			[ 'cocfix' ], 
	\			[ 'anzu' ], 
	\			[ 'method' ],
	\		],
	\ },
	\ 'inactive': {
	\   'left': [ [ 'homemode' ], ['filename_active'] ],
	\   'right':[ [ 'lineinfo' ], ['filetype'] ],
	\ },
	\ 'tabline': {'left': [['buffers'],], 'right': [['logo']] },
	\ 'component': {'logo': 'ﴔ', 'truncate': '%<'},
	\ 'component_expand': {
	\   'buffers'					: 'lightline#bufferline#buffers',
	\   'coc_warnings'		: 'lightline#coc#warnings',
	\   'coc_errors'			: 'lightline#coc#errors',
	\   'coc_ok'					:	'lightline#coc#ok',
	\ },
	\ 'component_function': {
	\		'anzu'						: 'anzu#search_status',
	\   'cocfix'					: 'LightlineCocFixes',
	\   'cocstatus'				: 'CocStatusBar',
	\   'fileformat'			: 'LightLineFileformat',
	\   'filename'				: 'LightLineFname',
	\   'filename_active'	: 'LightlineFilenameActive',
	\   'filetype'				:	'LightLineFiletype',
	\   'gitinfo'					:	'LightLineGit',
	\   'homemode'				: 'LightlineMode',
	\   'lineinfo'				: 'LightlineLineinfo',
	\   'method'					: 'NearestMethodOrFunction',
	\   'readonly'				: 'LightLineReadonly',
	\ },
	\ 'component_type': {
	\   'buffers'					: 'tabsel',
	\   'coc_errors'		: 'error',
	\   'coc_ok'				: 'left',
	\   'coc_warnings'	: 'warning',
	\ },
	\ 'separator': { 'left': '', 'right': '' },
	\ 'subseparator': { 'left': '|', 'right': '|' }
	\ }


function! s:lightline_is_lean() abort
  return &filetype =~? '\v^coc-explorer|diff|vista|magit|undotree(diff)?$'
endfunction

function! s:lightline_is_plain() abort
  return &buftype ==? 'terminal' || &filetype =~? '\v^help|gina|coc-explorer|vista_kind$'
endfunction

function! LightlineLineinfo() abort
  return &filetype ==? 'help'         ? ''  :
  \      &filetype ==? 'coc-explorer'	? ' ' :
  \      &filetype ==? 'diff'         ? ' ' :
  \      &filetype ==? 'magit'        ? ' ' :
  \      &filetype =~? 'gina-ls'      ? ' ' :
  \      &filetype =~? 'gina-push'    ? ' ' :
  \      &filetype =~? 'gina-commit'  ? ' ' :
  \      &filetype =~? 'gina-grep'    ? ' ' :
  \      &filetype =~? 'gina-log'     ? ' ' :
  \      &filetype =~? 'gina-status'  ? ' ' :
  \      &filetype =~? 'gina-show'    ? ' ' :
  \      &filetype =~? 'gina-edit'    ? ' ' :
  \      &filetype =~? 'undotree'     ? ' ' :
  \      &filetype ==? 'vista_kind'   ? ' ' :
  \
  \      s:lightline_is_lean() || s:lightline_is_plain() ? ' '  :
  \      printf('%d:%d ☰  %d%%', line('.'), col('.'), 100*line('.')/line('$') . '%')
endfunction

function! LightlineMode() abort
    return s:lightline_is_lean() || s:lightline_is_plain() ? toupper(&filetype) : Lightlinemode()
endfunction

function! Lightlinemode()
  let nr = s:get_buffer_number()
  let nmap = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
  if nr == 0
    return ''
  endif
  let l:number = nr
  let l:result = ''
  for i in range(1, strlen(l:number))
    let l:result = get(nmap, l:number % 10, l:number % 10) . l:result
    let l:number = l:number / 10
  endfor
  return l:result
endfunction

function! s:get_buffer_number()
  let i = 0
  for nr in filter(range(1, bufnr('$')), 'bufexists(v:val) && buflisted(v:val)')
    let i += 1
    if nr == bufnr('')
      return i
    endif
  endfor
  return ''
endfunction

function! LightlineFilenameActive() abort
  if s:lightline_is_lean()
    return ''
  endif
  if &buftype ==? 'terminal'
    return has('nvim') ? b:term_title . ' (' . b:terminal_job_pid . ')' : ''
  endif
  if &filetype ==? 'vista_kind'
    return get(g:lightline, 'VISTA', '')
  endif
  if &filetype ==? 'vista'
    return get(g:lightline, 'VISTA', '')
  endif
  if empty(expand('%:t'))
    return '[No Name]'
  endif

  let mo = s:lightline_modified()
  return empty(mo) ? LightLineFname() : LightLineFname() . ' ' . mo
endfunction

function! s:lightline_modified() abort
  return s:lightline_is_lean() || s:lightline_is_plain() ?  ''  :
  \      &modified                                       ?  ' ' :
  \      &modifiable                                     ?  ''  : '-'
endfunction

function! LightLineReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return ""
  else
    return ""
  endif
endfunction

function! LightLineGit()abort
	if &filetype ==?  'coc-explorer'  ||
		\&filetype ==   'vista'					||
		\&filetype ==   'undotree'			||
		\&filetype ==   'magit'
		return ""
	endif

	let gitbranch=get(g:, 'coc_git_status', '')
	let gitcount=get(b:, 'coc_git_status', '')
	let gitinfo = []
	if empty(gitbranch)
		let gitbranch=""
	endif
	if empty(gitcount)
		let gitcount=""
	endif
	call add(gitinfo,gitbranch)
	call add(gitinfo,gitcount)
	return trim(join(gitinfo,''))
endfunction

function! CocStatusBar() abort
    let status=get(g:, 'coc_status', '')
    if empty(status)
        return ""
    endif
    let regstatus=substitute(status,"TSC","Ⓣ ","")
    let statusbar= split(regstatus)
    if &filetype ==? "go"
        let gobar ="Ⓖ "
        call add(statusbar,gobar)
    endif
    "return join(statusbar," ")
    let s = join(statusbar," ")
    if empty(s)
        return ""
    endif
     return join(['❖',s])
endfunction

function! LightLineCocError()
  let error_sign = get(g:, 'coc_status_error_sign', has('mac') ? '❌ ' : 'E')
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info)
    return ''
  endif
  let errmsgs = []
  if get(info, 'error', 0)
    call add(errmsgs, error_sign . info['error'])
  endif
  return join(errmsgs, ' ')
endfunction

function! LightLineCocWarn() abort
  let warning_sign = get(g:, 'coc_status_warning_sign')
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info)
    return ''
  endif
  let warnmsgs = []
  if get(info, 'warning', 0)
    call add(warnmsgs, warning_sign . info['warning'])
  endif
 return join(warnmsgs, ' ')
endfunction

function! LightlineCocFixes() abort
  let b:coc_line_fixes = get(get(b:, 'coc_quickfixes', {}), line('.'), 0)
  return b:coc_line_fixes > 0 ? printf('%d ', b:coc_line_fixes) : ''
endfunction

" Diagnostic's feedback
function! CocUpdateQuickFixes(error, actions) abort
  let coc_quickfixes = {}
  try
    for action in a:actions
      if action.kind ==? 'quickfix'
        for change in action.edit.documentChanges
          for edit in change.edits
            let start_line = edit.range.start.line + 1
            let end_line = edit.range.end.line + 1
            let coc_quickfixes[start_line] = get(coc_quickfixes, start_line, 0) + 1
            if start_line != end_line
              let coc_quickfixes[end_line] = get(coc_quickfixes, end_line, 0) + 1
            endif
          endfor
        endfor
      endif
    endfor
  catch
  endtry
  if coc_quickfixes != get(b:, 'coc_quickfixes', {})
    let b:coc_quickfixes = coc_quickfixes
    call lightline#update()
  endif
endfunction

autocmd  user_events User CocStatusChange,CocDiagnosticChange
\   call lightline#update()
\|  call CocActionAsync('quickfixes', function('CocUpdateQuickFixes'))

function! LightLineFname()
  let icon = (strlen(&filetype) ? ' ' . WebDevIconsGetFileTypeSymbol() : ' no ft')
  let filename = LightLineFilename()
  let ret = [filename,icon]
  if filename == ''
    return ''
  endif
  return join([filename, icon],'')
endfunction

function! LightLineFilename()
  return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ ('' != expand('%:t') ? expand('%:t') : '')
endfunction

function! LightLineFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! LightLineFileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

" Show current method name in lightline
function! NearestMethodOrFunction() abort
  let vista_method = get(b:, 'vista_nearest_method_or_function', '')
  return vista_method
endfunction
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

nmap <Leader>1 <Plug>lightline#bufferline#go(1)
nmap <Leader>2 <Plug>lightline#bufferline#go(2)
nmap <Leader>3 <Plug>lightline#bufferline#go(3)
nmap <Leader>4 <Plug>lightline#bufferline#go(4)
nmap <Leader>5 <Plug>lightline#bufferline#go(5)
nmap <Leader>6 <Plug>lightline#bufferline#go(6)
nmap <Leader>7 <Plug>lightline#bufferline#go(7)
nmap <Leader>8 <Plug>lightline#bufferline#go(8)
nmap <Leader>9 <Plug>lightline#bufferline#go(9)
nmap <Leader>0 <Plug>lightline#bufferline#go(10)

