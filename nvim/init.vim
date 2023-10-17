" VIM-PLUG MANAGER ##################################################{{{
" Install vim-plug with the following command:
" curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

call plug#begin('~/.config/nvim/plugged')

" User interface
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }    " Nerdtree file explorer
" Plug 'flazz/vim-colorschemes'            " Great collection of color themes
" Plug 'itchyny/lightline.vim'             " Light status line
Plug 'vim-airline/vim-airline' " status bar (needs special fonts)
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'

" Sudo files
Plug 'lambdalisue/suda.vim'

" Syntax and completion
Plug 'tomtom/tcomment_vim'               " Comment any type of code (gcc, gcip)
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Language server integration
Plug 'honza/vim-snippets'
"" Plug 'tmsvg/pear-tree'
Plug 'imsnif/kdl.vim' " Zellij config files lang
Plug 'wgwoods/vim-systemd-syntax'

" Language specific
Plug 'plasticboy/vim-markdown'           					" markdown syntax
Plug 'mitsuhiko/vim-rst'                 					" rst syntax
Plug 'andys8/vim-elm-syntax'             					" elm language
Plug 'cespare/vim-toml'                  					" rust config files
Plug 'idris-hackers/idris-vim'           					" idris language
Plug 'rust-spandex/spandex.vim'          					" spandex language
Plug 'JuliaEditorSupport/julia-vim' 	 					" Julia language
Plug 'chrisbra/csv.vim'					 					" csv
Plug 'dylon/vim-antlr'					 					" antlr
Plug 'stsewd/sphinx.nvim', { 'do': ':UpdateRemotePlugins' } " Sphinx

" Git integration
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fugitive'                " git wrapper
Plug 'airblade/vim-gitgutter'            " git sign symbols before ligne number
Plug 'ryanoasis/vim-devicons'

call plug#end()                          " Add plugins to &runtimepath
" }}}



" PERSONAL  #########################################################{{{
set mouse=a                      " enable mouse
let mapleader=","                " leader is comma
inoremap ,, <esc>
tnoremap <ESC> <C-\><C-n>:q!<CR> " out of term mode
nnoremap  <F2> :vsp<CR>:term<CR>
nnoremap <silent> <F5> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>
" }}}



" COLOR #############################################################{{{
colo gruvbox
set background=dark              " use dark background
syntax enable                    " enable syntax processing
" colorscheme jellybeans           " awesome colorscheme
" }}}



" INDENTATION #######################################################{{{
" set expandtab                    " tabs are spaces
set tabstop=4                    " number of visual spaces per TAB
" set softtabstop=4                " number of spaces inserted in insert mode
set shiftwidth=4                 " number of spaces for 1 indentation level
" make tabs and trailing spaces visible
set list listchars=tab:·\ ,trail:∎
set autoindent                   " copy indent on new line
filetype plugin indent on        " load filetype-specific indent files
" Align blocks and keep them selected
vnoremap < <gv
vnoremap > >gv

" highlight trailing whitespace
highlight ExtraWhitespace ctermbg=blue guibg=blue
match ExtraWhitespace /\s\+\%#\@<!$/
" }}}



" UI CONFIG #########################################################{{{
set number relativenumber        " show line numbers
set showcmd                      " show command in bottom bar
set cursorline                   " highlight current line
set wildmenu                     " visual autocomplete for command menu
set lazyredraw                   " redraw only when we need to.
set showmatch                    " highlight matching [{()}]
set encoding=utf8                " use UTF-8 encoding
set conceallevel=2               " use vim conceal feature
" }}}



" SEARCHING #########################################################{{{
set incsearch                    " search as characters are entered
set hlsearch                     " highlight matches
" turn off search highlight with [,<space>]
nnoremap <leader><space> :nohlsearch<CR>
" }}}



" FOLDING ###########################################################{{{
set foldenable                   " enable folding
set foldlevelstart=10            " open most folds by default
set foldnestmax=10               " 10 nested fold max
" space toggles folds
nnoremap <space> za
set foldmethod=syntax            " fold based on syntax
" }}}



" COC CONFIG  #######################################################{{{
set hidden                       " if hidden is not set, TextEdit might fail
set nobackup                     " Some servers have issues with backup files, see #649
set nowritebackup                " Some servers have issues with backup files, see #649
set cmdheight=2                  " Better display for messages
set updatetime=300               " bad experience for diagnostic messages when it's default 4000
set shortmess+=c                 " don't give |ins-completion-menu| messages
set signcolumn=yes               " always show signcolumns
let g:coc_snippet_next="<Tab>"   " use Tab to navigate to next snippet placeholder
let g:coc_snippet_prev="<S-Tab>" " use Shift-Tab to previous snippet placeholder

"  " 'Enter' (CR) key for selection
"  " inoremap <expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
"
"  " Tab to switch suggestions
"  inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
"  inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"
"  " let g:coc_snippet_next="<Tab>"   " use Tab to navigate to next snippet placeholder
"  " let g:coc_snippet_prev="<S-Tab>" " use Shift-Tab to previous snippet placeholder

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


" Jumping to definition
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)
" }}}


" STATUS LINE #######################################################{{{
function! CocCurrentFunction()
	return get(b:, 'coc_current_function', '')
endfunction

let g:airline_powerline_fonts = 1
"" let g:lightline = {
"" 	\ 'colorscheme': 'wombat',
"" 	\ 'active': {
"" 	\   'left': [ [ 'mode', 'paste' ],
"" 	\             [ 'cocstatus', 'currentfunction', 'readonly', 'filename', 'modified' ] ]
"" 	\ },
"" 	\ 'component_function': {
"" 	\   'cocstatus': 'coc#status',
"" 	\   'currentfunction': 'CocCurrentFunction'
"" 	\ },
"" 	\ }
"" " }}}



" NERDTREE ##########################################################{{{
let NERDTreeIgnore = ['\.pyc$','__pycache__','.git$']
let NERDTreeShowHidden=1
noremap <C-n> :NERDTreeToggle<CR>
" close if only nerdtree left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" }}}



" LATEX CONFIGURATION ###############################################{{{
let g:tex_flavor = 'latex'       " use latex flavor instead of plaintex
let g:tex_conceal = "abdgm"      " display unicode math characters
" }}}



" MARKDOWN ##########################################################{{{
" disable header folding
let g:vim_markdown_folding_disabled = 1

" do not use conceal feature, the implementation is not so good
let g:vim_markdown_conceal = 0

" disable math tex conceal feature
let g:tex_conceal = ""
let g:vim_markdown_math = 1

" support front matter of various format
let g:vim_markdown_frontmatter = 1  " for YAML format
let g:vim_markdown_toml_frontmatter = 1  " for TOML format
let g:vim_markdown_json_frontmatter = 1  " for JSON format
" }}}


" PEER-TREE #########################################################{{{
" Default rules for matching:
let g:pear_tree_pairs = {
            \ '(': {'closer': ')'},
            \ '[': {'closer': ']'},
            \ '{': {'closer': '}'},
            \ "'": {'closer': "'"},
            \ '"': {'closer': '"'},
			\ "<": {'closer': '>'}
            \ }
" See pear-tree/after/ftplugin/ for filetype-specific matching rules

" Pear Tree is enabled for all filetypes by default:
let g:pear_tree_ft_disabled = []

" Pair expansion is dot-repeatable by default:
let g:pear_tree_repeatable_expand = 1

" Smart pairs are disabled by default:
let g:pear_tree_smart_openers = 1
let g:pear_tree_smart_closers = 1
let g:pear_tree_smart_backspace = 1

" If enabled, smart pair functions timeout after 60ms:
let g:pear_tree_timeout = 60

" Automatically map <BS>, <CR>, and <Esc>
"let g:pear_tree_map_special_keys = 1
"
"" Default mappings:
"imap <BS> <Plug>(PearTreeBackspace)
"imap <CR> <Plug>(PearTreeExpand)
"imap <Esc> <Plug>(PearTreeFinishExpansion)

" auto sudo
let g:suda_smart_edit = 1
