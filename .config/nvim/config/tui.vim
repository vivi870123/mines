" Search keyword with Google using surfraw
if executable('sr')
  command! -nargs=1 GoogleKeyword call mines#tui#google_keyword(<q-args>)
  nnoremap <Leader>gk :execute 'GoogleKeyword ' . expand('<cword>')<CR>
endif

if executable('htop')
  command! Htop        FloatermNew htop
  command! HtopSplit   call mines#tui#run('vnew', 'htop')

  nnoremap <Leader>ht :Htop<CR>
endif

if executable('ranger')
  " Use floaterm ranger wrapper
  command! Ranger      call mines#tui#run('float', 'ranger')
  command! RangerSplit call mines#tui#run('new', 'ranger')
endif

if executable('vifm')
  command! Vifm        call mines#tui#run('float', 'vifm')
  command! VifmSplit   call mines#tui#run('new', 'vifm')
endif

if executable('vtop')
  command! Vtop        call mines#tui#run('float', 'vtop')
  command! VtopSplit   call mines#tui#run('vnew', 'vtop')
endif

if executable('cmus')
  command! Cmus        call mines#tui#run('float', 'cmus')
  command! CmusSplit   call mines#tui#run('vnew', 'cmus')
endif
