" Plugin Check Utility

" Detect operating system
if has('win32') || has('win64')
  let s:os = 'windows'
else
  let s:os = systemlist('uname -a')[0]
endif

function! mines#check#get_os()
  return s:os
endfunction

function! mines#check#has_floating_window()
  return exists('*nvim_win_set_config')
endfunction
