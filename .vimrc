syntax on

" leaderkey to Space
let mapleader = " "

" check for term gui colors
if (has("termguicolors"))
 set termguicolors
endif

" set vim font to nerd font
set guifont=mononoki:h22

" Colorschemes
" dark themes: elly, alduin, gruvbox, onedark, vim-material, vilight, vorange,
" vydark, hydrangea, nord, 256_noir, iceberg, hybrid, tender, apprentice,
" deus, pencil, nofrils-dark, afterglow, sierra, deep-space,
" revolutions, Revolution, zenburn, tetragrammaton, strange, cabin, muon,
" thornbird, lucius, stormpetrel, Spink, redblack, abra
" light themes: Tomorrow, PaperColor Light, vylight, zenesque, louver,
" laederon, lightcolors, kalt, Light, rainbow_autumn
colorscheme elly 

" for PaperColor light theme
" set background=light
" colorscheme PaperColor

let g:material_terminal_italics = 1
" options are: 'default', 'palenight', 'ocean', 'lighter', 'darker', 'default-community', 'palenight-community', 'ocean-community', 'lighter-community', 'darker-community'
let g:material_theme_style = 'default-community'
" colorscheme material

" gruvbox 
let g:gruvbox_contrast_dark = 'hard'


" autocmd BufWinEnter,Filetype json colorscheme afterglow
" autocmd BufWinEnter,Filetype *.py colorscheme deep-space
" autocmd BufWinEnter,Filetype c colorscheme deep-space
" autocmd BufWinEnter,Filetype rs colorscheme deep-space
" autocmd BufWinEnter,Filetype *.txt colorscheme hydrangea
" autocmd BufWinEnter,Filetype html colorscheme hydrangea
" autocmd BufWinEnter,Filetype markdown, colorscheme muon
" autocmd BufWinEnter,Filetype vimwiki colorscheme gruvbox
" autocmd BufWinEnter,Filetype xml colorscheme gruvbox


set shiftwidth=4
set tabstop=4
set softtabstop=4
set number relativenumber
set foldenable

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

" Colored column at line wrap
set colorcolumn=80

" better scrolling -> doesn`t work when compatible is set 
set scrolloff=14
set sidescrolloff=14

 " Hard Wrap - max line length 80
" set wrap
" set wrapmargin=0
" set textwidth=0
" set columns=80

" Treat all .md files as markdown
autocmd BufNewFile,BufRead *.md set filetype=markdown
" Hide and format markdown elements like **bold**
autocmd FileType markdown set conceallevel=2

" toggle background transparent
let t:is_transparent = 0                     
function! Toggle_transparent_background()                      
  if t:is_transparent == 0                   
    hi Normal guibg=#202025 ctermbg=black                     
    let t:is_transparent = 1
  else
    hi Normal guibg=NONE ctermbg=NONE                    
    let t:is_transparent = 0                        
  endif                    
endfunction               
nnoremap <C-x><C-t> :call Toggle_transparent_background()<CR>

" highlight search
map <leader>h :noh<CR>

" Set backup directory
" set backup
" set backupdir=C:/Program\ Files\ (x86)/Vim/vimtmp//,.
" set directory=C:/Program\ Files\ (x86)/Vim/vimtmp//,.
" set nowritebackup


"Plugins
set nocompatible
filetype plugin on
set laststatus=2
" set t_Co=256
if !has('gui_running')
  set t_Co=256
endif

call plug#begin('~/.vim/plugged')
Plug 'itchyny/lightline.vim'
Plug 'preservim/nerdtree'
Plug 'vimwiki/vimwiki'
Plug 'flazz/vim-colorschemes'
Plug 'srcery-colors/srcery-vim'
Plug 'ulwlu/elly.vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'jacoborus/tender.vim'
Plug 'kaicataldo/material.vim', { 'branch': 'main' }
Plug 'lotabout/skim', { 'dir': '~/.skim', 'do': './install' }
Plug 'lotabout/skim.vim'
Plug 'luochen1990/rainbow'
Plug 'tommcdo/vim-lion'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'rust-lang/rust.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'mattn/vim-lsp-settings'
" Plug 'vim-syntastic/syntastic'
" Plug 'ycm-core/YouCompleteMe'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'preservim/tagbar'
Plug 'ap/vim-css-color'
call plug#end()


" Lightline
" don`t show extra mode information
set noshowmode
" set color scheme (molokai, apprentice, darcula, ayu_dark, deus, wombat, simpleblack)
let g:lightline = {
      \ 'colorscheme': 'molokai',
      \ }


"Language Server Protocol settings
if executable('pyls')
	" pip install python-language-server
	au User lsp_setup call lsp#register_server({
		\ 'name': 'pyls',
		\ 'cmd': {server_info->['pyls']},
		\ 'allowlist': ['python'],
		\ })
endif

if executable('rls')
	" rust language server
	au User lsp_setup call lsp#register_server({
		\ 'name': 'rls',
		\ 'cmd': {server_info->['rustup', 'run', 'stable', 'rls']},
		\ 'workspace_config': {'rust': {'clippy_preference': 'on'}},
		\ 'whitelist': ['rust'],
		\ })
endif

"Tab completion
inoremap <expr> <Tab>	pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab>	pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>	pumvisible() ? asnycomplete#close_popup() : "\<cr>"


" rainbow - Enable rainbow parentheses
" let g:rainbow_active = 1


" vim-lion - squeeze aligning text by some character
let b:lion_squeeze_spaces = 1


" vim-syntastic
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" " produces wired symbols on file start up -> disable next line
" " let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" let g:syntastic_aggregate_errors = 1
" " run Syntastic along with YouCompleteMe for c, cpp, objc, objcpp
" let g:ycm_show_diagnostics_ui = 0


" YouCompleteMe - close preview window after user accepts the offered completion string
" let g:ycm_autoclose_preview_window_after_completion = 1


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

