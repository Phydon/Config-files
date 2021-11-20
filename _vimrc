syntax on

" check for term gui colors
if (has("termguicolors"))
 set termguicolors
endif

" Colorschemes
" good for markdown: slate
" dark themes: gruvbox, onedark
" light themes: tomorrow, PaperColor Light
colorscheme gruvbox

" for PaperColor light theme
" set background=light
" colorscheme PaperColor

let g:material_terminal_italics = 1
" options are: 'default', 'palenight', 'ocean', 'lighter', 'darker', 'default-community', 'palenight-community', 'ocean-community', 'lighter-community', 'darker-community'
let g:material_theme_style = 'default-community'
" colorscheme material

autocmd BufWinEnter,Filetype json colorscheme onedark
autocmd BufWinEnter,Filetype markdown,vimwiki colorscheme slate

set shiftwidth=4
set tabstop=4
set softtabstop=4
set number relativenumber

" Set backup directory
set backup
set backupdir=C:/Program\ Files\ (x86)/Vim/vimtmp//,.
set directory=C:/Program\ Files\ (x86)/Vim/vimtmp//,.
set nowritebackup

"Plugins
set nocompatible
filetype plugin on
set laststatus=2
set t_Co=256

call plug#begin('C:/Program\ Files\ (x86)/Vim/vim82/plugged')
Plug 'itchyny/lightline.vim'
Plug 'vimwiki/vimwiki'
" Plug 'flazz/vim-colorschemes'
Plug 'NLKNguyen/papercolor-theme'
Plug 'jacoborus/tender.vim'
Plug 'kaicataldo/material.vim', { 'branch': 'main' }
Plug 'tpope/vim-surround'
call plug#end()

" Always show command
set showcmd

" Highlight matching brackets[{()}]
set showmatch

" Set language to english by default
set langmenu=en_US
let $LANG = 'en_US'
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

set encoding=utf-8

" Have lines wrap instead of continue off-screen
set linebreak

" Treat all .md files as markdown
autocmd BufNewFile,BufRead *.md set filetype=markdown
" Hide and format markdown elements like **bold**
autocmd FileType markdown set conceallevel=2


" Vim with all enhancements
source $VIMRUNTIME/vimrc_example.vim

" Use the internal diff if available.
" Otherwise use the special 'diffexpr' for Windows.
if &diffopt !~# 'internal'
  set diffexpr=MyDiff()
endif
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

