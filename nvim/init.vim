" LEADERKEY to Space
let mapleader = " "


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

" better scrolling -> doesn`t work when compatible is set
set scrolloff=14
set sidescrolloff=14

" HARD WRAP - max line length 80
" set wrap
" set wrapmargin=0
" set textwidth=0
" set columns=80


" TERMINAL-MODE
map <leader>TT :terminal<CR>
" escape terminal-mode
:tnoremap <Esc> <C-\><C-n>

" HIGHLIGHT SEARCH
map <leader>h :noh<CR>

" quickly ESCAPE to normal mode
imap qq <esc>
vmap qq <esc>


" save an UNDO backup
if has('persistent_undo')				"check if your vim version supports it
silent !mkdir -p ~/.config/nvim/undo
set undofile							"turn on undo files  
set undodir=$HOME/.config/nvim/undo		"directory where the undo files will be stored
endif


" PLUGINS
filetype plugin on
set laststatus=2
" if !has('gui_running')
"   set t_Co=256
" endif

" automatically install vim-plug
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
Plug 'arzg/vim-substrata'
Plug 'wadackel/vim-dogrun'
Plug 'logico/typewriter-vim'
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
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'ggandor/lightspeed.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'voldikss/vim-floaterm'
Plug 'ron-rs/ron.vim'
Plug 'Yggdroot/indentLine'
call plug#end()


" check for term gui colors
if (has("termguicolors"))
set termguicolors
endif

" COLORSCHEMES
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

" needs to be after plugin load
colorscheme substrata


" LIGHTLINE
" don`t show extra mode information
set noshowmode
" set color scheme (molokai, apprentice, darcula, ayu_dark, deus, wombat, simpleblack)
let g:lightline = {
      \ 'colorscheme': 'molokai',
      \ }


" SURROUND shortcuts
nmap <leader>" ysiw"
nmap <leader>' ysiw'
nmap <leader>( ysiw(
nmap <leader>) ysiw)
nmap <leader>[ ysiw[
nmap <leader>] ysiw]
nmap <leader>{ ysiw{
nmap <leader>} ysiw}
nmap <leader>< ysiw<
nmap <leader>> ysiw>


" VIMWIKI
" toogle todo checkboxes
:nmap <Leader>dd <Plug>VimwikiToggleListItem


" NERDTREE
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


" FLOATERM
let g:floaterm_shell = "nu"
let g:floaterm_title = "Terminal $1/$2"
let g:floaterm_width = 0.95
let g:floaterm_height = 0.9
let g:floaterm_keymap_toggle = "<Leader>FT"


" SKIM
map <leader>ff :Files ~<CR>

" skim with preview window
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)


" RIPGREP
map <leader>rr :Rg ~<CR>


" TELESCOPE
" Find files using Telescope command-line sugar.
nnoremap <leader>tf <cmd>Telescope find_files<cr>
nnoremap <leader>tg <cmd>Telescope live_grep<cr>
nnoremap <leader>tb <cmd>Telescope buffers<cr>
nnoremap <leader>th <cmd>Telescope help_tags<cr>
" remap fuzzy buffer search to <Ctrl> + </>
" to sort in reversed order at sorting_strategy=ascending
nnoremap <C-_> <cmd>Telescope current_buffer_fuzzy_find<cr>


" INDENTLINE
nnoremap <leader>ii <cmd>IndentLinesToggle<cr>


" EVERYTHING AFTER THIS IS LUA CODE
" =================================

lua << EOF
-- LSP
-- Setup nvim-cmp.
local cmp = require'cmp'
local lspconfig = require'lspconfig'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
	['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  -- sources where autocompletion should be used
  -- the order sets the priority (first -> most important, shows up on top; second shows up afterwards)
  -- keyword_length -> when should autocompletion show the first suggestions
  sources = cmp.config.sources({
    { name = 'nvim_lsp', keyword_length = 3 },
    { name = 'vsnip', keyword_length = 3 }, -- For vsnip users.
  }, {
    { name = 'buffer', keyword_length = 3 },
  })
})

-- use autocompletion in the command line as well
-- complete paths and commands
-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})


-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>de', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<space>dp', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', '<space>dn', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>dq', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>fm', vim.lsp.buf.formatting, bufopts)
end

require("nvim-lsp-installer").setup {}
local lsp_flags = {
	debounce_text_changes = 150,
}
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- SET AND CONFIGURE ANY LANGUAGE SERVERS BELOW
-- rust
require('lspconfig')['rust_analyzer'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    settings = {
      ["rust-analyzer"] = {}
    },
    capabilities = capabilities,
}
-- python
require('lspconfig')['jedi_language_server'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}
-- c/c++
require('lspconfig')['clangd'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}

-- haskell
require('lspconfig')['hls'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}

