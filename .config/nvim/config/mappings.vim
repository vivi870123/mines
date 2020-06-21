" Key-mappings
" ------------

" Non-standard {{{
" ------------

" Window-control prefix
nnoremap  [Window]   <Nop>
nmap      s [Window]

" remove F1 binding
map <f1> <nop>
nmap <f1> <nop>
imap <f1> <nop>

" Fix keybind name for Ctrl+Spacebar
map <Nul> <C-Space>
map! <Nul> <C-Space>

" Double leader key for toggling visual-line mode
nmap <silent> <Leader><Leader> V
vmap <Leader><Leader> <Esc>

" duplicate paragraph
nnoremap <leader>cp yap<S-}>p

" Toggle fold
nnoremap <CR> za

" Focus the current fold by closing all others
nnoremap <S-Return> zMza

" Use backspace key for matchit.vim
nmap <BS> %
xmap <BS> %

" Adjust viewports to the same size
map <leader>= <c-w>=

" Exit from input mode
" inoremap jk <Esc>

" jumps
nnoremap <leader>go <C-o>
nnoremap <leader>gi <C-i>
nnoremap g. g;

" copy & paste
nnoremap <leader>cp yap<S-}>p

" Toggle fold
nnoremap <CR> za

" Focus the current fold by closing all others
nnoremap <S-Return> zMza

" Use backspace key for matchit.vim
nmap <BS> %
xmap <BS> %

" jumps
nnoremap go <C-o>
nnoremap gi <C-i>
nnoremap g. g;

" mapping for decrease number
nnoremap <C-X><C-X> <C-X>

" In-menu scrolling
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

" Scroll pages in menu
inoremap <expr><C-f> pumvisible() ? "\<PageDown>" : "\<Right>"
inoremap <expr><C-b> pumvisible() ? "\<PageUp>" : "\<Left>"
imap     <expr><C-d> pumvisible() ? "\<PageDown>" : "\<C-d>"

" insert keymap like emacs
inoremap <C-w> <C-[>diwa
inoremap <C-h> <BS>
inoremap <C-d> <Del>
inoremap <C-u> <C-G>u<C-U>
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-a> <Home>
inoremap <expr><C-e> pumvisible() ? "\<C-e>" : "\<End>"

" command line alias
cnoremap <C-p> <Up>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>
cnoremap <C-h> <BS>
cnoremap <C-t> <C-R>=expand("%:p:h") . "/" <CR>

" maintain the same shortcut as vim-gtfo becasue it's in my muscle memory.
nnoremap <silent> gof <cmd>call mines#mappings#open_file_folder()<CR>

" }}}
" Global niceties {{{
" ---------------
" yank to end
nnoremap Y y$

" no overwrite paste
xnoremap p "_dP

" Start an external command with a single bang
nnoremap ! <cmd>!

" Allow misspellings
cnoreabbrev Bd bd
cnoreabbrev bD bd
cnoreabbrev Q! q!
cnoreabbrev Q1 q!
cnoreabbrev Qa qa
cnoreabbrev qw wq
cnoreabbrev Qall! qall!
cnoreabbrev W! w!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

" Start new line from any cursor position
inoremap <S-Return> <C-o>o

nnoremap zl z5l
nnoremap zh z5h

" Window control
nnoremap <tab> <C-w>w
nnoremap <C-x> <C-w>x<C-w>w
nnoremap <silent><C-w>z :vert resize<CR>:resize<CR>:normal! ze<CR>

" Select all
nnoremap <silent> gv ggVG

" Select blocks after indenting
xnoremap < <gv
xnoremap > >gv|

" Use tab for indenting
nmap >  >>_
nmap <  <<_

"go to last edit location with ;'
nnoremap <localleader>' ;'

" Select last paste
nnoremap <expr> gp '`['.strpart(getregtype(), 0, 1).'`]'

" }}}
" File operations {{{
" ---------------

" Switch to the directory of the opened buffer
map <Leader>cd <cmd>lcd %:p:h<CR>:pwd<CR>

" Fast saving
nnoremap <silent><Leader>w <cmd>write<CR>
vnoremap <silent><Leader>w <Esc><cmd>write<CR>
nnoremap <silent><C-s> <cmd>write<CR>
vnoremap <silent><C-s> <cmd>write<CR>
cnoremap <silent><C-s> <cmd>write<CR>
inoremap <silent><C-s> <esc><cmd>write<CR>

cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" }}}
" Editor UI {{{
" ---------

" Macros
" qq to record, Q to replay
nnoremap Q @@

" make dot work in visual mode
xnoremap . <cmd>norm.<CR>

" Allows you to visually select a section and then hit @ to run a macro on all lines
" https://medium.com/@schtoeffel/you-don-t-need-more-than-one-cursor-in-vim-2c44117d51db#.3dcn9prw6
xnoremap @ <cmd>call mines#mappings#execute_macro_over_visual_range()<CR>

" Tabs
nnoremap th  <cmd>tabfirst<CR>
nnoremap tk  <cmd>tabnext<CR>
nnoremap tj  <cmd>tabprevious<CR>
nnoremap tl  <cmd>tablast<CR>
nnoremap tc  <cmd>tabclose<CR>
nnoremap tn  <cmd>tabnew<CR>
nnoremap tJ  <cmd>TabMoveLeft<CR>
nnoremap tK  <cmd>TabMoveRight<CR>
nnoremap <silent> <A-j> <cmd>tabnext<CR>
nnoremap <silent> <A-k> <cmd>tabprevious<CR>

command! TabMoveLeft call mines#mappings#tab_move_by(-2)
command! TabMoveRight call mines#mappings#tab_move_by(1)

" }}}
" Totally Custom {{{
" --------------

" https://twitter.com/vimgifs/status/913390282242232320
" :h i_CTRL-G_u
augroup PROSE_MAPPINGS
  au!
  au FileType markdown,text inoremap <buffer> . .<c-g>u
  au FileType markdown,text inoremap <buffer> ? ?<c-g>u
  au FileType markdown,text inoremap <buffer> ! !<c-g>u
  au FileType markdown,text inoremap <buffer> , ,<c-g>u
augroup END

" Remove spaces at the end of lines
nnoremap <silent> ,<Space> <cmd>silent! keeppatterns %substitute/\s\+$//e<CR>

" C-r: Easier search and replace
xnoremap <C-r> <cmd>call mines#mappings#get_selection('/')<CR>:%s/\V<C-R>=@/<CR>//gc<Left><Left><Left>

" Quick substitute within selected area
xnoremap s <cmd>s//gc<Left><Left><Left>

" Location/quickfix list movement
nmap ]q <cmd>cnext<CR>
nmap [q <cmd>cprev<CR>

" Yank buffer's absolute path to clipboard
nnoremap <Leader>y <cmd>let @+=expand("%:~:.")<CR>:echo 'Yanked relative path'<CR>
nnoremap <Leader>Y <cmd>let @+=expand("%:p")<CR>:echo 'Yanked absolute path'<CR>

" Drag current line/s vertically and auto-indent
vnoremap <Leader>K <cmd>m-2<CR>gv=gv
vnoremap <Leader>J <cmd>m'>+<CR>gv=gv
noremap  <Leader>K <cmd>m-2<CR>
noremap  <Leader>J <cmd>m+<CR>

" go to begining or End of line
nnoremap <silent> B ^
nnoremap <silent> E $
xnoremap <silent> B ^
xnoremap <silent> E $

" }}}
" Append modeline to EOF {{{
nnoremap <silent> <Leader>ml <cmd>call mines#mappings#append_modeline()<CR>

" }}}
" Windows and buffers {{{

" Window resizing mappings
if bufwinnr(1)
	noremap <S-Up> <C-W>+
	noremap <S-Down> <C-W>-
	noremap <S-Left> <c-w><
	noremap <S-Right> <c-w>>
endif

nnoremap <silent> [Window]v		<cmd>split<CR>
nnoremap <silent> [Window]g		<cmd>vsplit<CR>
nnoremap <silent> [Window]t		<cmd>tabnew<CR>
nnoremap <silent> [Window]o		<cmd>only<CR>
nnoremap <silent> [Window]b		<cmd>b#<CR>
nnoremap <silent> [Window]c		<cmd>call mines#mappings#close_buffer()<CR>
nnoremap <silent> [Window]C		<cmd>call mines#mappings#close_buffer(v:true)<CR>

" Background dark/light toggle and contrasts
nmap <silent> [Window]h <cmd>call mines#mappings#toggle_background()<CR>
nmap <silent> [Window]- <cmd>call mines#mappings#toggle_contrast(-v:count1)<cr>
nmap <silent> [Window]= <cmd>call mines#mappings#toggle_contrast(+v:count1)<cr>

" }}}

" vim: set foldmethod=marker ts=2 sw=2 tw=80 noet :
