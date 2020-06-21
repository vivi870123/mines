let g:clap_layout = {
      \ 'relative': 'editor',
      \ 'width': '90%',
      \ 'height': '60%',
      \ 'row': '20%',
      \ 'col': '5%'
      \ }

let g:clap_cache_directory = $DATA_PATH . '/clap'
let g:clap_layout = { 'relative' : 'editor' }
let g:clap_enable_yanks_provider = 1
let g:clap_no_matches_msg = 'No matches'
let g:clap_current_selection_sign = {
      \ 'text': '=>',
      \ 'texthl': 'ClapCurrentSelection',
      \ 'linehl': 'ClapCurrentSelection'
      \}

let g:clap_selected_sign = {
      \ 'text': '->',
      \ 'texthl': 'ClapSelected',
      \ 'linehl': 'ClapSelected'
      \}

let g:clap_search_box_border_style = 'curve'

let g:clap_prompt_format = '%spinner%%forerunner_status% %provider_id% ❯  '
let g:clap_enable_icon = 1
let g:clap_provider_grep_enable_icon = 1
let g:clap_provider_grep_opts = '-H --no-heading --vimgrep --smart-case --hidden'
let g:clap_insert_mode_only = v:false

" `:Clap quick_open` to open some dotfiles quickly.
let g:clap_provider_open = {
      \ 'source': ['~/.vimrc', '~/.spacevim', '~/.bashrc', '~/.tmux.conf'],
      \ 'sink': 'e',
      \ }

augroup clap_events
	autocmd!
	autocmd User ClapOnExit call lightline#update()
augroup END

" vim: set ts=2 sw=2 tw=80 noet :
