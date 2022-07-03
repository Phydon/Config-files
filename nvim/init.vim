" leaderkey to Space
let mapleader = " "

" check for term gui colors
if (has("termguicolors"))
set termguicolors
endif

" Colorschemes
" dark themes: elly, alduin, gruvbox, onedark, vim-material, vilight, vorange,
" vydark, hydrangea, nord, 256_noir, iceberg, hybrid, tender, apprentice,
" deus, pencil, nofrils-dark, afterglow, sierra, deep-space,
" revolutions, Revolution, zenburn, tetragrammaton, strange, cabin, muon,
" thornbird, lucius, stormpetrel, Spink, redblack, abra
" light themes: Tomorrow, PaperColor Light, vylight, zenesque, louver,
" laederon, lightcolors, kalt, Light, rainbow_autumn

" for PaperColor light theme
" set background=light
" colorscheme PaperColor

" gruvbox 
let g:gruvbox_contrast_dark = 'hard'


set shiftwidth=4
set tabstop=4
set softtabstop=4
set number relativenumber
set foldenable

" Highlight matching brackets[{()}]
set showmatch

" Set language to english by default
set langmenu=en_US
let $LANG = 'en_US'
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Have lines wrap instead of continue off-screen
set linebreak

" Colored column at line wrap
set colorcolumn=80

" " Hard Wrap - max line length 80
" set wrap
" set wrapmargin=0
" set textwidth=0
" set columns=80


" highlight search
map <leader>h :noh<CR>


"Plugins
filetype plugin on
set laststatus=2
" if !has('gui_running')
"   set t_Co=256
" endif

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(stdpath('data') . '/plugged')
Plug 'itchyny/lightline.vim'
Plug 'preservim/nerdtree'
Plug 'vimwiki/vimwiki'
Plug 'flazz/vim-colorschemes'
Plug 'srcery-colors/srcery-vim'
Plug 'ulwlu/elly.vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'jacoborus/tender.vim'
Plug 'lotabout/skim', { 'dir': '~/.skim', 'do': './install' }
Plug 'lotabout/skim.vim'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'rust-lang/rust.vim'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'preservim/tagbar'
Plug 'ap/vim-css-color'
call plug#end()


colorscheme elly


" Lightline
" don`t show extra mode information
set noshowmode
" set color scheme (molokai, apprentice, darcula, ayu_dark, deus, wombat, simpleblack)
let g:lightline = {
      \ 'colorscheme': 'molokai',
      \ }


" " Start NERDTree. If a file is specified, move the cursor to its window.
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif

" " Start NERDTree, unless a file or session is specified, eg. vim -S session_file.vim.
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists('s:std_in') && v:this_session == '' | NERDTree | endif

" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

" show hidden files
let NERDTreeShowHidden=1

" show line numbers
let NERDTreeShowLineNumbers=1

" NERDTree win size when opened
let NERDTreeWinSize=25

" Toogle NERDTree 
nmap <F7> :NERDTreeToggle<CR>

" NERDTree Syntax Highlighting
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1


" TAGBAR
" automatically open tagbar on start up
" autocmd VimEnter * nested :call tagbar#autoopen(1)
" autocmd FileType * nested :call tagbar#autoopen(0)
" set tagbar width if using vertical split
let g:tagbar_width = max([15, winwidth(0) / 5])
" Tagbar omitting the short help at the top of the window and the blank lines in between top-level scopes
" possible values are:
" 0: Show short help and blank lines between top-level scopes
" 1: Don't show the short help or the blank lines.
" 2: Don't show the short help but show the blank lines.
let g:tagbar_compact = 2
" show data types
" let g:tagbar_show_data_type = 1
" show line numbers
" let g:tagbar_show_tag_linenumbers = 2
" line wrap
let g:tagbar_wrap = 2
" toggle tagbar on or off with F8 key
nmap <F8> :TagbarToggle<CR>
" specify path if ctags are not in $PATH environment variable
" --> change path
" g:tagbar_ctags_bin = 'path_to_ctags.exe'


" skim
map <leader>f :Files ~<CR>

" skim with preview window
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)


" ripgrep
map <leader>r :Rg ~<CR>

