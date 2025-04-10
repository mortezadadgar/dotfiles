" Copied from vim-svelte and updated from ftplugn/html.vim
if exists("loaded_matchit")
	let b:match_ignorecase = 1
	let b:match_words = '<!--:-->,' ..
				\ '<:>,' ..
				\ '#\%(if\|await\|each\)\>:\:\%(else\|catch\|then\)\>:\/\%(if\|await\|each\)\>,' ..
				\	      '<\@<=[ou]l\>[^>]*\%(>\|$\):<\@<=li\>:<\@<=/[ou]l>,' ..
				\	      '<\@<=dl\>[^>]*\%(>\|$\):<\@<=d[td]\>:<\@<=/dl>,' ..
				\	      '<\@<=\([^/!][^ \t>]*\)[^>]*\%(>\|$\):<\@<=/\1>'
endif
