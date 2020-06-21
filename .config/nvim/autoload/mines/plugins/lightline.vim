scriptencoding utf8

function! mines#plugins#lightline#is_lean() abort
  return &filetype =~? '\v^coc-explorer|defx|diff|vista|magit|deol|undotree(diff)?$'
endfunction

function! mines#plugins#lightline#is_plain() abort
  return &buftype ==? 'terminal' || &filetype =~? '\v^help|defx|deol|gina|coc-explorer|codi|vista_kind$'
endfunction

function! mines#plugins#lightline#lineinfo() abort
  return &filetype ==? 'help'         ? ''  :
  \      &filetype ==? 'defx'					? ' ' :
  \      &filetype ==? 'codi'         ? ' ' :
  \      &filetype ==? 'deol'         ? ' ' :
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
  \      mines#plugins#lightline#is_lean() || mines#plugins#lightline#is_plain() ? ' '  :
  \      printf('%d:%d ☰  %d%%', line('.'), col('.'), 100*line('.')/line('$'))
endfunction

function! mines#plugins#lightline#mode() abort
	return mines#plugins#lightline#is_lean() || mines#plugins#lightline#is_plain() ? toupper(&filetype) : Lightlinemode()
endfunction

function! Lightlinemode()
  let nr = mines#plugins#lightline#get_buffer_number()
  let nmap = ['⓿ ','❶ ','➋ ','❸ ','❹ ','❺ ','❻ ','❼ ','❽ ','❾ ','➓ ','⓫ ','⓬ ','⓭ ','⓮ ','⓯ ','⓰ ','⓱ ','⓲ ','⓳ ','⓴ ']
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

function! mines#plugins#lightline#get_buffer_number()
  let i = 0
  for nr in filter(range(1, bufnr('$')), 'bufexists(v:val) && buflisted(v:val)')
    let i += 1
    if nr == bufnr('')
      return i
    endif
  endfor
  return ''
endfunction

function! mines#plugins#lightline#filenameactive() abort
  if n()
    return ''
  endif
  if &buftype ==? 'terminal'
    return has('nvim') ? b:term_title . ' (' . b:terminal_job_pid . ')' : ''
  endif
  if &filetype ==? 'defx'
    return get(g:lightline, 'DEFX', '')
  endif
  if &filetype ==? 'tagbar'
    return get(g:lightline, 'fname', '')
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

  let mo = mines#plugins#lightline#modified()
  return empty(mo) ? mines#plugins#lightline#filename : mines#plugins#lightline#filename . ' ' . mo
endfunction

function! mines#plugins#lightline#modified() abort
  return mines#plugins#lightline#is_lean() || mines#plugins#lightline#is_plain() ?  ''		:
  \      &modified                                       ?  ' '	:
  \      &modifiable                                     ?  ''		: '-'
endfunction

function! mines#plugins#lightline#readonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return ""
  else
    return ""
  endif
endfunction

function! mines#plugins#lightline#gitinfo ()abort
  if &filetype ==?  'coc-explorer'      ||
    \&filetype ==   'vista'     ||
    \&filetype ==   'undotree'  ||
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

function! mines#plugins#lightline#cocstatus() abort
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

function! mines#plugins#lightline#cocfix() abort
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

function! mines#plugins#lightline#filename()
  let icon = (strlen(&filetype) ? ' ' . WebDevIconsGetFileTypeSymbol() : ' no ft')
  let filename = mines#plugins#lightline#filename()
  let ret = [filename,icon]
  if filename == ''
    return ''
  endif
  return join([filename, icon],'')
endfunction

function! mines#plugins#lightline#filetype()
  return ('' != mines#plugins#lightline#readonly() ? mines#plugins#lightline#readonly() . ' ' : '') .
        \ ('' != expand('%:t') ? expand('%:t') : '')
endfunction

function! mines#plugins#lightline#filetype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! mines#plugins#lightline#fileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

