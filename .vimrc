execute pathogen#infect()

set statusline=%f%m%=%l,%v\ %P\ 

set path=.,**

" fugitive+es freak out, yay
set shell=sh

" 'tabs'
set hidden
nnoremap <silent> <C-N> :bnext<CR>
nnoremap <silent> <C-P> :bprev<CR>
nnoremap <silent> gt :bnext<CR>
nnoremap <silent> gT :bprev<CR>
nnoremap <Leader>g :ls<CR>:b *
nnoremap <Leader>f :find *

nnoremap <silent> vc :GundoToggle<CR>

set undofile
set undodir=$HOME/.vim-undo
set undolevels=5000

set cursorline
set laststatus=2
set modeline
set mouse=a
set number
set scrolloff=1
set wildmenu

let g:c_syntax_for_h=1

filetype on
filetype plugin on
syntax enable

set formatoptions=tcroqj
set nrformats=hex

" fuck netrw.
let loaded_netrwPlugin = 1

" enable filetype indent for some things
" (use a fairly sensible indent thing for all others)
set ai ci pi
autocmd FileType python,yaml,rst filetype indent on
filetype indent on

set tabstop=4 softtabstop=4 shiftwidth=4 expandtab
autocmd FileType c setl noexpandtab

" specific indent things
autocmd FileType markdown,yaml setl ts=2 sts=2 sw=2
autocmd FileType es,rst setl ts=3 sts=3 sw=3

" specific format things
autocmd FileType markdown,rst setl formatoptions-=c formatoptions+=aw

" searching
set ignorecase smartcase

" remove trailing whitespace; works on one line or selection
noremap <silent> sw ms$:s/\s\+$//<CR>g`s

" draw trailing whitespace
set list lcs=trail:·,tab:\ \ 

" remove trailing whitespace from files we save of certain types
autocmd FileType c,java,python,html,htmldjango autocmd BufWrite <buffer> exe "norm!ms"|keepj %s/\s\+$//e|exe "norm!g`s"


colorscheme apprentice

hi Unsullied ctermbg=NONE ctermfg=240 guibg=NONE guifg=#585858 cterm=NONE gui=NONE
let g:unsullied_height=5
