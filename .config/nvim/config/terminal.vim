" neovim terminal mapping and settings
set scrollback=100000

" Make escape work in the Neovim terminal.
tnoremap <Esc> <C-\><C-n>

" Make navigation into and out of Neovim terminal splits nicer.
tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l

augroup terminal_settings
  autocmd!
  autocmd FileType floaterm
      \  nnoremap <silent><buffer> [[ ?❯<CR>
      \| nnoremap <silent><buffer> ]] /❯<CR>
augroup END
