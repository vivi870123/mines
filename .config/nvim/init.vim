if &compatible
  set nocompatible
endif

" enable true color
if has('termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

let $VIM_PATH = fnamemodify(resolve(expand('<sfile>:p')), ':h:h') . '/nvim'
let $DATA_PATH = g:etc#cache_path

augroup user_events
  autocmd!
  autocmd CursorHold *? syntax sync minlines=300
augroup END

" Disable vim distribution plugins {{{
  let g:c_syntax_for_h = 1
  let g:did_install_default_menus = 1
  let g:loaded_2html_plugin = 1
  let g:loaded_getscript = 1
  let g:loaded_getscriptPlugin = 1
  let g:loaded_gzip = 1
  let g:loaded_logiPat = 1
  " let g:loaded_netrw = 1
  " let g:loaded_netrwFileHandlers  = 1
  " let g:loaded_netrwPlugin        = 1
  " let g:loaded_netrwSettings      = 1
  let g:loaded_matchit = 1
  let g:loaded_matchparen = 1
  let g:netrw_nogx = 1 " disable netrw's gx mapping.
  let g:loaded_rrhelper = 1  " ?
  let g:loaded_shada_plugin = 1  " ?
  let g:loaded_tar = 1
  let g:loaded_tarPlugin = 1
  let g:loaded_tutor_mode_plugin = 1
  let g:loaded_vimball = 1
  let g:loaded_vimballPlugin = 1  
	let g:loaded_zip = 1
  let g:loaded_zipPlugin = 1

" }}}
" Providers {{{
" Set them directly if they are installed, otherwise disable them. 
" To avoid the runtime check cost, which can be slow.
if has('nvim')
	" Python This must be here because it makes loading vim VERY SLOW otherwise
	let g:python_host_skip_check = 1
	if executable('python2')
		let g:python_host_prog = exepath('python2')
	else
		let g:loaded_python_provider = 0
	endif

	let g:python3_host_skip_check = 1
	if executable('python3')
		let g:python3_host_prog = exepath('python3')
	else
		let g:loaded_python3_provider = 0
	endif

	if executable('neovim-node-host')
		let g:node_host_prog = exepath('neovim-node-host')
	else
		let g:loaded_node_provider = 0
	endif

	if executable('neovim-ruby-host')
		let g:ruby_host_prog = exepath('neovim-ruby-host')
	else
		let g:loaded_ruby_provider = 0
	endif
endif

" }}}
" Initialize base requirements {{{
if has('vim_starting')
	" Use spacebar as leader and ; as secondary-leader
	" Required before loading plugins!
	let g:mapleader="\<Space>"
	let g:maplocalleader=';'

	" Release keymappings prefixes, evict entirely for use of plug-ins.
	nnoremap <Space>  <Nop>
	xnoremap <Space>  <Nop>
	nnoremap ,        <Nop>
	xnoremap ,        <Nop>
	nnoremap ;        <Nop>
	xnoremap ;        <Nop>
	nnoremap m        <Nop>
	xnoremap m        <Nop>

" Ensure data directories
call etc#util#ensure_directory([
				\   g:etc#cache_path    . '/undo',
				\   g:etc#cache_path    . '/backup',
				\   g:etc#cache_path    . '/session',
				\ ])
endif
" }}}

call etc#init()

" Internal Plugin Settings  {{{
" ------------------------ 
" PHP {{{
    let g:PHP_removeCRwhenUnix  = 0
    let g:PHP_default_indenting = 0

    " Don't outdent the <?php tags to the first column
    let g:PHP_outdentphpescape  = 0
    let g:php_htmlInStrings     = 0 " neat! :h php.vim
    let g:php_baselib           = 1 " highlight php builtin functions
    let g:php_noShortTags       = 1
    let g:php_syncmethod        = 10 " :help :syn-sync https://stackoverflow.com/a/30732393/557215
  " }}}
  " Python {{{
    let g:python_highlight_all = 1
  " }}}
  " Vim {{{
    let g:vimsyntax_noerror = 1
    let g:vim_indent_cont = &shiftwidth
  " }}}
  " Bash {{{
    let g:is_bash = 1
  " }}}  " Java {{{
    let g:java_highlight_functions = 'style'
    let g:java_highlight_all = 1
    let g:java_highlight_debug = 1
    let g:java_allow_cpp_keywords = 1
    let g:java_space_errors = 1
    let g:java_highlight_functions = 1                                                                                                 
  " }}}          
  " JavaScript {{{
    let g:SimpleJsIndenter_BriefMode = 1
    let g:SimpleJsIndenter_CaseIndentLevel = -1
  " }}}
" }}}

call etc#util#source_file('config/plugins/all.vim')

call etc#util#source_file('config/settings.vim')
call etc#util#source_file('config/autocmds.vim')
call etc#util#source_file('config/mappings.vim')

call etc#util#source_file('config/terminal.vim')
call etc#util#source_file('config/tui.vim')

call etc#util#source_file('config/plugins/prose.vim')

call mines#theme#init()

call etc#util#source_file('config/color.vim')

" After this file is sourced, plug-in code will be evaluated.
" See ~/.vim/after for files evaluated after that.
" See `:scriptnames` for a list of all scripts, in evaluation order
" Launch Vim with `vim --startuptime vim.log` for profiling info.
"
" To see all leader mappings, including those from plug-ins:

" vim: set foldmethod=marker ts=2 sw=2 tw=80 noet :

" nnoremap <a-j> :echo('hello')
" nnoremap <a-a> ggVG
