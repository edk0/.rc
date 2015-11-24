#!/usr/bin/env es
au BufRead,BufNewFile *.es set filetype=es
au BufRead,BufNewFile * if getline(1) =~# '^#!/usr/bin/\(env \)\=es' | set filetype=es | endif
