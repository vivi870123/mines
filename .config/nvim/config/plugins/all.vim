
if dein#tap('vim-clap')
  nnoremap <silent><Leader>c <cmd>Clap files  ~/.config/nvim<cr>
  nnoremap <silent><leader>l <cmd>Clap lines<cr>

  nnoremap <silent><localleader>f <cmd>Clap files<cr>
  nnoremap <silent><localleader>b <cmd>Clap buffers<cr>
  nnoremap <silent><localleader>v <cmd>Clap yanks<cr>
  nnoremap <silent><localleader>q <cmd>Clap quickfix<cr>
  nnoremap <silent><localleader>g <cmd>Clap grep<cr>
  nnoremap <silent><LocalLeader>j <cmd>Clap jumps<CR>
  nnoremap <silent><LocalLeader>t <cmd>Clap tags<CR>
  nnoremap <silent><LocalLeader>c <cmd>Clap colors<CR>
  nnoremap <silent><LocalLeader>h <cmd>Clap help_tags<CR>
  nnoremap <silent><LocalLeader>/ <cmd>Clap lines<CR>
  nnoremap <silent><LocalLeader>; <cmd>Clap command_history<CR>

  " nnoremap <silent><Leader>gl :<C-u>Clap! commits<CR>
  nnoremap <silent><Leader>gt <cmd>Clap tags ++query=<cword><CR>
  xnoremap <silent><Leader>gt <cmd>Clap tags ++query=@visual<CR><CR>
  nnoremap <silent><Leader>gf <cmd>Clap files ++query=<cword><CR>
  xnoremap <silent><Leader>gf <cmd>Clap files ++query=@visual<CR><CR>
  nnoremap <silent><Leader>gg <cmd>Clap grep ++query=<cword><CR>
  xnoremap <silent><Leader>gg <cmd>Clap grep ++query=@visual<CR><CR>

  nnoremap <silent> <Leader>c <cmd>Clap files ~/dotfiles/neovim/.config/nvim<cr>

  function! s:clap_mappings()
    nnoremap <silent> <buffer> <nowait>' <cmd>call clap#handler#tab_action()<CR>
    inoremap <silent> <buffer> <Tab>   <C-R>=clap#navigation#linewise('down')<CR>
    inoremap <silent> <buffer> <S-Tab> <C-R>=clap#navigation#linewise('up')<CR>
    nnoremap <silent> <buffer> <C-f> <cmd><c-u>call clap#navigation#scroll('down')<CR>
    nnoremap <silent> <buffer> <C-b> <cmd><c-u>call clap#navigation#scroll('up')<CR>

    nnoremap <silent> <buffer> sg  <cmd>call clap#handler#try_open('ctrl-v')<CR>
    nnoremap <silent> <buffer> sv  <cmd>call clap#handler#try_open('ctrl-x')<CR>
    nnoremap <silent> <buffer> st  <cmd>call clap#handler#try_open('ctrl-t')<CR>

    nnoremap <silent> <buffer> q     <cmd>call clap#handler#exit()<CR>
    nnoremap <silent> <buffer> <Esc> <cmd>call clap#handler#exit()<CR>
    inoremap <silent> <buffer> <Esc> <C-R>=clap#navigation#linewise('down')<CR><C-R>=clap#navigation#linewise('up')<CR><Esc><Esc>
    inoremap <silent> <buffer> <c-o> <C-R>=clap#navigation#linewise('down')<CR><C-R>=clap#navigation#linewise('up')<CR><Esc><Esc>
    inoremap <silent> <buffer> jk    <C-R>=clap#navigation#linewise('down')<CR><C-R>=clap#navigation#linewise('up')<CR><Esc>
  endfunction

  autocmd user_events FileType clap_input call s:clap_mappings()

  if dein#tap('vim-floaterm')
    nnoremap <silent><leader>tt <cmd>Clap floaterm<cr>
  endif
endif

if dein#tap('coc-clap')
  nnoremap <silent><localleader>d <cmd>Clap coc_diagnostics<cr>
  nnoremap <silent><localleader>l <cmd>Clap coc_location<cr>
  nnoremap <silent><localleader>o <cmd>Clap coc_outline<CR>
endif

if dein#tap('vim-clap-sessions')
	nnoremap <silent><LocalLeader>s <cmd>Clap sessions<CR>
endif

if dein#tap('vista.vim')
	nnoremap <silent> <Leader>o :<C-u>Vista<CR>
	nnoremap <silent> <Leader>O :<C-u>Vista show<CR>
endif

if dein#tap('defx.nvim')
	nnoremap <localleader>e :Defx -split=vertical -winwidth=35 -direction=botright -toggle<CR>
	nnoremap <localleader>a :Defx -split=vertical -winwidth=35 -direction=botright -toggle `expand('%:p:h')` -search=`expand('%:p')`<CR>
endif

if dein#tap('iron.nvim')
	nmap <silent> <Leader>rr :<C-u>IronRepl<CR><Esc>
	nmap <silent> <Leader>rq <Plug>(iron-exit)
	nmap <silent> <Leader>rl <Plug>(iron-send-line)
	vmap <silent> <Leader>rl <Plug>(iron-visual-send)
	nmap <silent> <Leader>rp <Plug>(iron-repeat-cmd)
	nmap <silent> <Leader>rc <Plug>(iron-clear)
	nmap <silent> <Leader>r<CR>  <Plug>(iron-cr)
	nmap <silent> <Leader>r<Esc> <Plug>(iron-interrupt)
endif

if dein#tap('vim-doge')
	autocmd FileType javascript,javascriptreact,typescript,typescriptreact,python,php
		\ nnoremap <silent> <Leader>d :<C-u>DogeGenerate<CR>
endif

if dein#tap('any-jump.nvim')
  nnoremap <Leader>aj :AnyJump<CR>
  xnoremap <Leader>aj :AnyJumpVisual<CR>
  nnoremap <Leader>ab :AnyJumpBack<CR>
  nnoremap <Leader>al :AnyJumpLastResults<CR>
endif

if dein#tap('vim-floaterm')
  nnoremap <silent><F10> :FloatermPrev<CR>
  nnoremap <silent><F11> :FloatermNext<CR>
  nnoremap <silent><F12> :FloatermToggle<CR>
  nnoremap         <c-t> :FloatermToggle<CR>

  tnoremap <silent><F10> <C-\><C-n>:FloatermPrev<CR>
  tnoremap <silent><F11> <C-\><C-n>:FloatermNext<CR>
  tnoremap <silent><F12> <C-\><C-n>:FloatermToggle<CR>
  tnoremap <silent><c-t> <C-\><C-n>:FloatermToggle<CR>

  " Quickly switch tab in terminal
  tnoremap <C-J> <C-\><C-N>:FloatermNext<cr>
  tnoremap <C-K> <C-\><C-N>:FloatermPrev<cr>
  
  nnoremap <Leader>tn <cmd>FloatermNew<cr>
  nnoremap <Leader>tf <cmd>FloatermNew<cr>
  nnoremap <Leader>tv <cmd>FloatermNew --wintype=normal --position=bottom --height=15<cr>
  nnoremap <Leader>tg <cmd>FloatermNew --wintype=normal --position=right --width=70<cr>
  nnoremap <Leader>th <cmd>FloatermToggle<cr>
  nnoremap <Leader>tj <cmd>FloatermNext<CR>
  nnoremap <Leader>tk <cmd>FloatermPrev<CR>
endif 

if dein#tap('vim-sandwich')
	nmap <silent> sa <Plug>(operator-sandwich-add)
	xmap <silent> sa <Plug>(operator-sandwich-add)
	omap <silent> sa <Plug>(operator-sandwich-g@)
	nmap <silent> sd <Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)
	xmap <silent> sd <Plug>(operator-sandwich-delete)
	nmap <silent> sr <Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)
	xmap <silent> sr <Plug>(operator-sandwich-replace)
	nmap <silent> sdb <Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)
	nmap <silent> srb <Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)
	omap ib <Plug>(textobj-sandwich-auto-i)
	xmap ib <Plug>(textobj-sandwich-auto-i)
	omap ab <Plug>(textobj-sandwich-auto-a)
	xmap ab <Plug>(textobj-sandwich-auto-a)
	omap is <Plug>(textobj-sandwich-query-i)
	xmap is <Plug>(textobj-sandwich-query-i)
	omap as <Plug>(textobj-sandwich-query-a)
	xmap as <Plug>(textobj-sandwich-query-a)

	nmap <leader>"	saiw"
	nmap <leader>'	saiw'
	nmap <leader>(	saiw(
	nmap <leader>)	saiw)
	nmap <leader><	saiw<
	nmap <leader>>	saiw>
	nmap <leader><	saiw<
	nmap <leader>>	saiw>
	nmap <leader>{	saiw{
	nmap <leader>}	saiw}
	nmap <leader>[	saiw[
	nmap <leader>]	saiw]
endif

if dein#tap('vim-operator-replace')
	xmap p <Plug>(operator-replace)
endif

if dein#tap('vim-edgemotion')
	map gj <Plug>(edgemotion-j)
	map gk <Plug>(edgemotion-k)
	xmap gj <Plug>(edgemotion-j)
	xmap gk <Plug>(edgemotion-k)
endif

if dein#tap('vim-bookmarks')
  nmap ma :<C-u>cgetexpr bm#location_list()<CR> :<C-u>Clap quickfix<CR>
	nmap mn <Plug>BookmarkNext
	nmap mp <Plug>BookmarkPrev
	nmap mm <Plug>BookmarkToggle
	nmap mi <Plug>BookmarkAnnotate
	nmap mc <Plug>BookmarkClear
	nmap mC <Plug>BookmarkClearAll
endif

if dein#tap('vim-easy-align')
	" Start interactive EasyAlign in visual mode (e.g. vipga)
	xmap <silent> ga <Plug>(EasyAlign)
	" Start interactive EasyAlign for a motion/text object (e.g. gaip)
	nmap <silent> ga <Plug>(EasyAlign)
endif

if dein#tap('indentLine')
	nmap <silent><Leader>ti :<C-u>IndentLinesToggle<CR>
endif

if dein#tap('rainbow')
  nmap <silent><Leader>tr :<C-u>RainbowToggle<CR>
endif

if dein#tap('committia.vim')
  let g:committia_hooks = {}
  function! g:committia_hooks.edit_open(info)
    imap <buffer><C-d> <Plug>(committia-scroll-diff-down-half)
    imap <buffer><C-u> <Plug>(committia-scroll-diff-up-half)
    setlocal winminheight=1 winheight=1
    resize 10
    startinsert
  endfunction
endif

if dein#tap('auto-git-diff')
	autocmd user_events FileType gitrebase
		\  nmap <buffer><CR>  <Plug>(auto_git_diff_scroll_manual_update)
		\| nmap <buffer><C-n> <Plug>(auto_git_diff_scroll_down_page)
		\| nmap <buffer><C-p> <Plug>(auto_git_diff_scroll_up_page)
		\| nmap <buffer><C-d> <Plug>(auto_git_diff_scroll_down_half)
		\| nmap <buffer><C-u> <Plug>(auto_git_diff_scroll_up_half)
endif

if dein#tap('goyo.vim')
  nnoremap <Leader>z :Goyo<CR>
endif

if dein#tap('vimagit')
  nnoremap <silent> mg :Magit<CR>
endif

if dein#tap('undotree')
  nnoremap <Leader>u :UndotreeToggle<CR>
endif

if dein#tap('vim-asterisk')
	map n		<Plug>(is-nohl)<Plug>(anzu-n)
	map N		<Plug>(is-nohl)<Plug>(anzu-N)

	map *   <Plug>(asterisk-g*)<Plug>(is-nohl-1)
	map #   <Plug>(asterisk-g#)<Plug>(is-nohl-1)

	augroup vim-anzu
		autocmd!
		autocmd CursorHold,CursorHoldI,WinLeave,TabLeave * call anzu#clear_search_status()
	augroup END
endif

if dein#tap('splitjoin.vim')
  let g:splitjoin_join_mapping = ''
  let g:splitjoin_split_mapping = ''
  nmap sj :SplitjoinJoin<CR>
  nmap sk :SplitjoinSplit<CR>
endif

if dein#tap('dsf.vim')
  nmap dsf <Plug>DsfDelete
  nmap csf <Plug>DsfChange
endif

if dein#tap('vim-easymotion')
  nmap ss <Plug>(easymotion-s2)
  nmap sf <Plug>(easymotion-overwin-f)
  map  sh <Plug>(easymotion-linebackward)
  map  sl <Plug>(easymotion-lineforward)
  map  s/ <Plug>(easymotion-sn)
  omap s/ <Plug>(easymotion-tn)
  map  sn <Plug>(easymotion-next)
  map  sp <Plug>(easymotion-prev)
endif

if dein#tap('vimwiki')
	nnoremap <silent> <Leader>W :<C-u>VimwikiIndex<CR>
endif

if dein#tap('vim-textobj-multiblock')
	omap <silent> ab <Plug>(textobj-multiblock-a)
	omap <silent> ib <Plug>(textobj-multiblock-i)
	xmap <silent> ab <Plug>(textobj-multiblock-a)
	xmap <silent> ib <Plug>(textobj-multiblock-i)
endif

if dein#tap('vim-textobj-function')
	omap <silent> af <Plug>(textobj-function-a)
	omap <silent> if <Plug>(textobj-function-i)
	xmap <silent> af <Plug>(textobj-function-a)
	xmap <silent> if <Plug>(textobj-function-i)
endif


