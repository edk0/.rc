filetype on
filetype off

execute pathogen#infect()

let mapleader=","

set statusline=%f:%l%m%=%l,%v\ %P\ "trail

let g:python_host_prog = '/usr/bin/python2.7'
let g:python3_host_prog = '/usr/local/bin/python3.5'

set shell=sh

set path=.,**

nnoremap <silent> vc :MundoToggle<CR>

set undofile
set undodir=$HOME/.vim-undo
set undolevels=5000

set directory=$HOME/.vim-tmp

set exrc
set secure

set hidden
set laststatus=2
set modeline modelines=5
set mouse=a
set number
set scrolloff=1
set wildmenu
set backspace=indent,eol,start

set clipboard=unnamed

let g:c_syntax_for_h=1

filetype plugin indent on
syntax enable

set formatoptions=tcroq
if version >= 704
	set formatoptions+=j
endif
set nrformats=hex

" fuck netrw.
let loaded_netrwPlugin = 1

set autoindent copyindent preserveindent

set tabstop=4 softtabstop=4 shiftwidth=4
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd FileType python,rst,markdown,yaml,html,puppet set expandtab

" specific indent things
autocmd FileType markdown,yaml setl ts=2 sts=2 sw=2
autocmd FileType groovy setl ts=2 sts=2 sw=2
autocmd FileType puppet setl ts=2 sts=2 sw=2
autocmd FileType es,rst setl ts=3 sts=3 sw=3

" specific format things
autocmd FileType markdown,rst setl formatoptions-=c
autocmd FileType rst setl formatoptions+=w

nnoremap <Leader>t :tag<Space>

" unite
call unite#custom#source('file,file_rec', 'matchers', ['matcher_default', 'matcher_project_ignore_files'])
nnoremap <Leader>g :Unite -short-source-names -start-insert buffer<CR>
nnoremap <Leader>f :Unite -short-source-names -start-insert buffer file_rec<CR>
nnoremap gr :Unite -start-insert grep:.:-isR<CR>
nnoremap gt :UniteWithCursorWord grep:.:-isR<CR>

" searching
set ignorecase smartcase incsearch hlsearch
nnoremap <Leader>h :nohlsearch<CR>

" remove trailing whitespace; works on one line or selection
noremap <silent> sw ms$:s/\s\+$//<CR>g`s

" draw trailing whitespace
set list lcs=trail:·,tab:→\ "trail

" remove trailing whitespace from files we save of certain types
autocmd FileType * autocmd BufWrite mkview|exe "norm!ms"|keepj %s/\s\+$//e|exe "norm!g`s"|silent loadview

" style
set cursorline
colorscheme apprentice
hi Comment ctermbg=NONE ctermfg=213 guibg=NONE guifg=#ff87ff cterm=NONE gui=NONE

hi Unsullied ctermbg=NONE ctermfg=240 guibg=NONE guifg=#585858 cterm=NONE gui=NONE
let g:unsullied_height=5


" things
autocmd BufNewFile,BufRead /home/edk/src/socksrouter/* set noexpandtab
autocmd BufNewFile,BufRead /home/edk/src/iocaine/* set noexpandtab
