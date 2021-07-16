""" Plugins {{{
filetype plugin indent on
set nocompatible

if empty(glob('$XDG_CONFIG_HOME/nvim/autoload/plug.vim'))
  silent !curl -fLo $XDG_CONFIG_HOME/nvim/autoload/plug.vim --Create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin("$VIMCONFIG/plugged")
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

Plug 'rust-lang/rust.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'cespare/vim-toml'

Plug 'christoomey/vim-tmux-navigator'

Plug 'chriskempson/base16-vim'
call plug#end()
" }}}
""" Plugin Config {{{
let g:rustfmt_autosave = 1
let g:fzf_preview_window = []

" vim-tmux-navigator
let g:tmux_navigator_no_mappings = 1
let g:tmux_navigator_save_on_switch = 2

nnoremap <silent> <c-h> :TmuxNavigateLeft<CR>
nnoremap <silent> <c-j> :TmuxNavigateDown<CR>
nnoremap <silent> <c-k> :TmuxNavigateUp<CR>
nnoremap <silent> <c-l> :TmuxNavigateRight<CR>
nnoremap <silent> <c-\> :TmuxNavigatePrevious<CR>

" Airline
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.linenr = ' '
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.colnr = ':'
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''

" Colourscheme
let base16colorspace=256  " Access colors present in 256 colorspace
set termguicolors
colorscheme base16-gruvbox-dark-hard
" }}}
""" Config {{{
set mouse=a
set cursorline

" Number lines
set number
set relativenumber

" Spaces & Tabs
set tabstop=4
set noexpandtab
set shiftwidth=4
set softtabstop=4

set wrap
set formatoptions=tcqrn1
set tw=100
set autoindent

" Sane splits
set splitright
set splitbelow

" Tags
set tags+=./tags;,tags

" Decent wildmenu
set wildmenu
set wildmode=list:longest
set wildignore=.hg,.svn,*~,*.png,*.jpg,*.gif,*.settings,Thumbs.db,*.min.js,*.swp,publish/*,intermediate/*,*.o,*.hi,Zend,vendor

" GUI
set guioptions-=T " Remove toolbar
set vb t_vb=
set scrolloff=3
set backspace=indent,eol,start

set signcolumn=yes
set encoding=utf-8
set hidden
set ttyfast
set laststatus=2
set lazyredraw
set noshowmode
set showcmd
syntax enable
set showbreak=↪\
set listchars=tab:▸\ ,eol:↲,nbsp:␣,trail:•,precedes:←,extends:→
map <leader>l :set list!<CR> " Toggle tabs and EOL
" }}}
""" Mappings"{{{
let mapleader = " "

" <leader><leader> toggles between buffers
nnoremap <leader><leader> <c-^>
nnoremap [b :bprevious<CR>
nnoremap ]b :bnext<CR>

nnoremap <leader>o :Files<CR>
nnoremap <leader>; :Buffers<CR>
nnoremap <leader>] :Tags<CR>

" Change directory to directory of current file
nnoremap <leader>cd :cd %:h<CR>

" Quickfix
command! Vfix botright vertical copen | vertical resize 50
command! -nargs=* QFix call QFixToggle(<f-args>)
function! QFixToggle(v, e)
	if exists("g:qfix_win") && a:e == 1
		cclose
		unlet g:qfix_win
	else
		if a:v == 0
			copen
		else
			Vfix
		endif
		let g:qfix_win = bufnr("$")
	endif
endfunction

noremap <silent> ]o :QFix 0 1<CR>
noremap <silent> [o :QFix 1 1<CR>
noremap ]q :cnext<CR>
noremap [q :cprev<CR>
noremap ]Q :cfirst<CR>
noremap [Q :clast<CR>
noremap <silent>j gj
noremap <silent>k gk
noremap <silent>H g^
noremap <silent>L g$

" Generate ctags
nnoremap <leader>tt :!ctags -R . <CR>

map Y y$
vnoremap <leader>y "+y<CR>
noremap <leader>p :read !xsel --clipboard --output<CR>
noremap <leader>c :w !xsel -ib<CR><CR>

noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>
"}}}
""" Utils {{{
" Permanent undo
set undodir=$XDG_CACHE_HOME/.vimdid
set undofile
"}}}
""" Search Tools {{{
set incsearch
set hlsearch
set ignorecase
set smartcase
set showmatch
set matchpairs+=<:>
map <leader>, :let @/=''<CR>

" Include subfolders
set path+=**

" Center search results
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" Ripgrep
noremap <leader>s :Rg 
if executable("rg")
  set grepprg=rg\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

let g:fzf_layout = { 'down': '~25%' }
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '
  \   .shellescape(<q-args>), 1)

function! s:list_cmd()
  let base = fnamemodify(expand('%'), ':h:.:S')
  return base == '.' ? 'fd --type file --follow' : printf('fd --type file --follow | proximity-sort %s', shellescape(expand('%')))
endfunction

command! -bang -nargs=? -complete=dir Files
  \call fzf#vim#files(<q-args>, {'source': s:list_cmd(),
  \                               'options': '--tiebreak=index'}, <bang>0)

" Quick Grep
noremap <Leader>g :grep<space><C-r><C-w><CR>:QFix 0 0<CR><CR>
noremap <leader>r :grep<space>

" }}}
""" Notes {{{
" Go to Note Directory
nnoremap <leader>nd :cd $NOTES_DIR<CR>
" Ripgrep Notes
nnoremap <leader>ng :cd $NOTES_DIR<CR>:Ngrep<space><C-r><C-w><CR>:QFix 1 0<CR><CR>
nnoremap <leader>nr :cd $NOTES_DIR<CR>:Ngrep 
" FZF Notes (multi-tag)
nnoremap <leader>[ :cd $NOTES_DIR<CR>:Nf (^\|[[:space::]])@(\w\S*)<CR>
" Get Questions
nnoremap <leader>nq :grep /\*\*Q\*\*/ %<CR>
" Create New Note
nnoremap <leader>nn :CreateNote
" Create Note Link
nnoremap <leader>nl :call fzf#run({'sink': 'HandleFZF', 'down': '25%'}) <CR>

" Create Note
command! -nargs=1 NewNote :call NewNote(<f-args>)
command! -nargs=1 CreateNote :execute ":e" $NOTES_DIR . '/' . strftime("%Y%m%d%H%M") . "-<args>.md"
function! NewNote(name)
	let filename = a:name
	:CreateNote ".filename."
	:r! date
endfunction

" Note Search 
command! -bang -nargs=* Nf
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always -g !tags -e '
  \   .shellescape(<q-args>), 1)

command! -nargs=1 Ngrep grep "<args>" -g "*.md" $NOTES_DIR

" Note Linking
function! HandleFZF(file)
    let filename = fnameescape(a:file)
    let filename_wo_timestamp = fnameescape(fnamemodify(a:file, ":t:s/^[0-9]*-//"))
    let mdlink = "[ ".filename_wo_timestamp." ]( ".filename." )"
    put=mdlink
endfunction
command! -nargs=1 HandleFZF :call HandleFZF(<f-args>)

"}}}
""" Folding {{{
set foldenable
set foldlevelstart=0
set foldnestmax=10
set foldmethod=marker
set modelines=1
" }}}
""" Coc {{{
set nobackup
set nowritebackup
set updatetime=300
set shortmess+=c

" Tab for completion
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-.> to trigger completion.
inoremap <silent><expr> <c-.> coc#refresh()

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Show documentation in a preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Scroll through float windows
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
"}}}
" vim:foldmethod=marker:foldlevel=0
