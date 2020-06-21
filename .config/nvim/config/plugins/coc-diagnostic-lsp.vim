function! EnableProselint()
	call coc#config('diagnostic-languageserver', {
		\		"prose": {
		\			"command": "proselint",
		\			"debounce": 200,
		\			"args": ["--compact", "-"],
		\			"offsetLine": 0,
		\			"offsetColumn": 0,
		\			"sourceName": "proselint",
		\			"formatLines": 1,
		\			"formatPattern": [
		\			"^[^:]+:(\\d+):(\\d+):(\\s)(.*)$",
		\				{
		\					"line": 1,
		\					"column": 2,
		\					"security": 3,
		\					"message": 4
		\				}
		\			],
		\			"securities": {
		\				" ": "info"
		\     }
		\}
		\}
endfunction

" PHP config
autocmd FileType text,markdown,texttile call EnableProselint()
