execute pathogen#infect()

let mapleader=","

set statusline=%f%m%=%l,%v\ %P\ "trail

set path=.,**

" fugitive+es freak out, yay
set shell=sh

nnoremap <silent> vc :MundoToggle<CR>

set undofile
set undodir=$HOME/.vim-undo
set undolevels=5000

set directory=$HOME/.vim-tmp

set exrc
set secure

set hidden
set laststatus=2
set modeline
set mouse=a
set number
set scrolloff=1
set wildmenu

set clipboard=unnamed

let g:c_syntax_for_h=1

filetype on
filetype plugin on
syntax enable

set formatoptions=tcroq
if version >= 704
	set formatoptions+=j
endif
set nrformats=hex

" fuck netrw.
let loaded_netrwPlugin = 1

" enable filetype indent for some things
" (use a fairly sensible indent thing for all others)
set autoindent copyindent preserveindent
filetype indent on

set tabstop=4 softtabstop=4 shiftwidth=4
autocmd FileType python,rst,md,yaml,html set expandtab

" specific indent things
autocmd FileType markdown,yaml setl ts=2 sts=2 sw=2
autocmd FileType groovy setl ts=2 sts=2 sw=2
autocmd FileType es,rst setl ts=3 sts=3 sw=3

" specific format things
autocmd FileType markdown,rst setl formatoptions-=c
autocmd FileType rst setl formatoptions+=w

" unite
call unite#custom#source('file,file_rec', 'matchers', ['matcher_default', 'matcher_project_ignore_files'])
nnoremap <Leader>g :Unite -short-source-names -start-insert buffer<CR>
nnoremap <Leader>f :Unite -short-source-names -start-insert buffer file_rec<CR>
nnoremap gr :Unite -start-insert grep:.:-isR<CR>
nnoremap gt :UniteWithCursorWord grep:.:-isR<CR>

" searching
set ignorecase smartcase nohlsearch incsearch

" remove trailing whitespace; works on one line or selection
noremap <silent> sw ms$:s/\s\+$//<CR>g`s

" draw trailing whitespace
set list lcs=trail:·,tab:→\ "trail

" remove trailing whitespace from files we save of certain types
autocmd FileType * autocmd BufWrite mkview|exe "norm!ms"|keepj %s/\s\+$//e|exe "norm!g`s"|silent loadview


set cursorline
colorscheme apprentice

hi Unsullied ctermbg=NONE ctermfg=240 guibg=NONE guifg=#585858 cterm=NONE gui=NONE
let g:unsullied_height=5


" things
autocmd BufNewFile,BufRead /home/edk/src/fireplace/* set noexpandtab
