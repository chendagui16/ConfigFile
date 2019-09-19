" ================================ Plugin Manager ========================
filetype off

call plug#begin('~/.vim/bundle/')

" @ Plugin --- [ ColorScheme ]
Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" @ Plugin --- [ File Buffer Manager ]
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'yegappan/mru'
Plug 'danro/rename.vim'

" @ Plugin --- [ File Search ]
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'ctrlpvim/ctrlp.vim'
Plug 'rking/ag.vim'

" @ Plugin --- [ View ]
Plug 'terryma/vim-multiple-cursors'
Plug 'terryma/vim-smooth-scroll'
Plug 'terryma/vim-expand-region'
Plug 'kana/vim-operator-user'
Plug 'haya14busa/vim-operator-flashy'
Plug 'haya14busa/incsearch.vim'

" @ Plugin --- [ Code Plug ]
Plug 'w0rp/ale'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-commentary'
Plug 'majutsushi/tagbar'

" @ Plugin --- [ Git Plug ]
Plug 'tpope/vim-git'
Plug 'tpope/vim-fugitive'
Plug 'gregsexton/gitv'
Plug 'airblade/vim-gitgutter'
Plug 'mhinz/vim-signify'

" @ Plugin --- [ Useful Plug ]
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

" @ Plugin --- [ Code Complete Unity ]
Plug 'mattn/emmet-vim'
Plug 'Valloric/YouCompleteMe'
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'

" @ Plugin --- [ Syntax ]
Plug 'kh3phr3n/python-syntax'
Plug 'elzr/vim-json'
Plug 'plasticboy/vim-markdown'
Plug 'vim-latex/vim-latex'
Plug 'chiphogg/vim-prototxt'


call plug#end()

syntax on
syntax enable

filetype on
filetype plugin on
filetype plugin indent on

" =============================== Plugin Config ==========================
" Set Ale Cheacker
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '?'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
nmap sp <Plug>(ale_previous_wrap)
nmap sn <Plug>(ale_next_wrap)
let g:ale_linters = {
	\'python': ['flake8'],
	\'tex': ['chktex'],
	\'cpp': ['clang', 'gcc', 'cpplint', 'cppcheck']
	\}

let g:ale_cpp_cpplint_options="--linelength=120"
" EasyAlign
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" auto complete
let g:UltiSnipsExpandTrigger="<S-tab>"

" ColorFul NERDTree Settings
let g:NERDTreeRespectWildIgnore=1
let g:NERDTreeDirArrows=0
let g:NERDTreeShowBookmarks=1

" GitGutter Setting
let g:gitgutter_sign_column_always = 0
let g:gitgutter_max_signs = 99999

" AirLine Settings
let g:airline_powerline_fonts = 1
let g:airline_theme='serene'
" let g:airline_theme='jellybeans'
let g:airline_left_sep=''
let g:airline_right_sep=''

" latex-suite setting
let g:tex_flavor='latex'
let g:Tex_CustomTemplateDirectory="$HOME/.vim/ftplugin/latex-suite/templates"

" Ag.vim Settings
let g:ackprg = "ag --nocolor --nogroup --column"
set grepprg=ag\ --nogroup\ --nocolor
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

" Multip Cursor
" Default mapping
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

" Vim incsearch
let g:vim_search_pulse_disable_auto_mappings = 1
let g:incsearch#auto_nohlsearch = 1

" Emmet Config
" change <Tab> config , if use [YouCompleteMe]
let g:user_emmet_expandabbr_key ='<Tab>'

let g:user_emmet_settings = {
			\ 'php'     : {
			\ 'extends' : 'html',
			\ 'filters' : 'c',
			\ },
			\ 'xml'     : {
			\ 'extends' : 'html',
			\ },
			\ 'haml'    : {
			\ 'extends' : 'html',
			\ },
			\ 'phtml'    : {
			\ 'extends' : 'html',
			\ }
			\}

"------------------ YouCompleteMe -------------------
" Linux vim && NeoVim Using YouCompleteMe
if(has("mac"))
	let g:ycm_python_binary_path='/usr/bin/python'
else
	let g:ycm_server_python_interpreter='/usr/bin/python'
endif
let g:ycm_auto_trigger = 1
let g:ycm_global_ycm_extra_conf = "~/.vim/ftplugin/.ycm_extra_conf.py"
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_server_log_level = 'info'
let g:ycm_min_num_identifier_candidate_chars = 2
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_complete_in_strings=1
let g:ycm_use_ultisnips_completer = 1
let g:ycm_cache_omnifunc = 1
let g:ycm_max_diagnostics_to_display = 0
let g:ycm_key_list_select_completion = ['<C-n>', '<C-j>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<C-k>']
let g:ycm_filetype_blacklist = {
			\ 'tagbar' : 1,
			\ 'qf' : 1,
			\ 'notes' : 1,
			\ 'unite' : 1,
			\ 'text' : 1,
			\ 'vimwiki' : 1,
			\ 'pandoc' : 1,
			\ 'infolog' : 1,
			\ 'mail' : 1,
			\ 'mundo': 1,
			\ 'fzf': 1,
			\ 'ctrlp' : 1
			\}

let g:ycm_error_symbol = '>>'
let g:ycm_warning_symbol = '>*'

nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>

" fzf Setting
set rtp+=~/.fzf
" =============================== Theme setting ==========================
try
	colorscheme solarized
	set background=dark
catch
endtry

" =============================== Common setting ==========================
set mouse=a   " enable the use of the mouse, 'a' = all mode
set nocompatible  "  set compatible=off, means using vim not vi
set clipboard=unnamed  " set system clipboard
set regexpengine=1  " set regexp engine = old engine
set history=9888  " set max history for command-line
let mapleader="\<Space>"
let g:mapleader="\<Space>"
if exists('$TMUX')
   set term=screen-256color
endif
" Format
set nu  " display line number
set tabstop=4  " number of space that a <Tab> in the file counts for
set shiftwidth=4  " number of space to use for each step of (auto)indent, <, > use this setting
set softtabstop=4  " number of space that a <Tab> counts for while performing editing operations.
set expandtab  " use spaces to insert a <Tab>
autocmd FileType cpp,proto set tabstop=2
autocmd FileType cpp,proto set shiftwidth=2
autocmd FileType cpp,proto set softtabstop=2
autocmd FileType python set tabstop=4
autocmd FileType python set shiftwidth=4
autocmd FileType python set softtabstop=4
set autowrite  " auto save file when change buffer
set display=lastline
" For indent
set wrap  " autowrap too long line and display continues on the next line
set autoindent  " copy indent from current line when starting a new line
set smartindent  " do smart autoindenting when starting a new line.  such as cindent for C-like programs
set smarttab  " do smart tabs when inserting tab
set cindent  " get the amount of indent for line according the indenting rule
set linebreak  " wrap long lines at a character in appropriate character rather than last character
set shiftround  " Round indent to multiple of 'shiftwidth'. Useful for >, < command or CTRL-T, CTRL-D in Insert mode
" Encoding setting
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,latin1
set termencoding=utf-8
language messages en_US.utf-8
" Search and Case
set gdefault  " default global when use :s///
set hlsearch  " Highlight search
set incsearch  " increasing search
set ignorecase  " ignore case in search patterns
set fileignorecase  " ignore case when using file names and directories
set showcmd  " show commad in the right-bottom corner of the screen
set whichwrap+=<,>,h,l  " allow h,l,<left>,<right> move to the previous/next line when cursor is on the first/last charater
" Command-line completetaion
set wildmenu
set wildmode=longest,full
set completeopt=menu,menuone,longest
set completeopt+=preview

set switchbuf=useopen,usetab  " The behaviour when switching between buffers.
set shortmess=a  " Use short message, such as '[+]' instead of '[Modified]', 'a' means 'all'
" No back up files
set nobackup
set nowritebackup
set noswapfile
" Rule the define
set noshowmode  " don't show mode, because it will show in airline
set ruler  " show the line and column number of the cursor position
set cursorline  " highlight the screen line of the cursor
set winaltkeys=no  " don't use ALT keys for menus in GUI version
" Advance configure
set magic  " use magic search pattern
set lazyredraw  " don't redraw while executing macros, which can speed-up
set ttyfast  " Improve smoothness of redrawing, which can speed-up
set hidden  " Buffer becomes hidden when it is abandoned
set autoread  " auomatically read when the file has been changed outside of Vim
set laststatus=2  " a status line mode
set cmdheight=1  " command-line height
set modelines=1  " mode-line height
" No surround sound
set noerrorbells
set novisualbell
set t_vb=
" Set Fold
set foldenable
" misc settings
set fileformat=unix
set fileformats=unix,dos,mac
" Set split
set splitright  " Put new vsplit on the right
set splitbelow  " Put new split on the below
" Set Undo file
set undofile
set undodir=~/.vim/undo/
set viminfo+=!
" Diff GUI Vim with NVim
" Set No Top Menu and Scroll
if has("gui_running")
	set guioptions-=e
	set guioptions-=m
	set guioptions-=T
	set guioptions-=L
	set guioptions-=r
	set guioptions-=B
	set guioptions-=0
	set go=
	set guitablabel=
	set paste
	" set mousemodel=popup_setpos
	" set mouse-=a
	"set guitablabel=%M\ %t

	" Fonts Settings
	"set guifont=ProfontWindows\ 9
	"set guifont=IBM\ 3270\ Narrow\ Medium\ 10
	if(has('win32'))
		set guifont=Consolas_for_Powerline_FixedD:h10:cANSI
	elseif(has('osx'))
		set guifont=Aix:h14
	else
		set guifont=Aix\ 9
	endif

	map <silent> <F1> :if &guioptions =~# 'T' <Bar>
				\set guioptions-=T <Bar>
				\set guioptions-=m <bar>
				\else <Bar>
				\set guioptions+=T <Bar>
				\set guioptions+=m <Bar>
				\endif<CR>
else
	set t_Co=256
	set showtabline=2
		set noimd
	set ttimeoutlen=0
	if len($TMUX) > 0
		" set screen title to vim $PWD folder name - format 'v:folder'
		set titlestring=v:%(%{fnamemodify(expand(\"$PWD\"),\":t\")}%)
		set t_ts=k
		set t_fs=\
		set title
	endif
endif
" Set spell checker
set spelllang=en_us
set spellfile=~/.vim/spell/en.utf-8.add
set dictionary+=/usr/share/dict/words
" Vim prefix for GTK
set backspace=indent,eol,start
" set tabs
set list listchars=tab:-\ ,extends:>,precedes:<

" =============================== Tooling Function Binding ===============
" Lookup HighLight Syntax Define
function! <SID>SynStack()
	echo map(synstack(line('.'),col('.')),'synIDattr(v:val, "name")')
endfunc

" Return indent (all whitespace at start of a line), converted from
" tabs to spaces if what = 1, or from spaces to tabs otherwise.
" When converting to tabs, result has no redundant spaces.
function! Indenting(indent, what, cols)
	let spccol = repeat(' ', a:cols)
	let result = substitute(a:indent, spccol, '\t', 'g')
	let result = substitute(result, ' \+\ze\t', '', 'g')
	if a:what == 1
		let result = substitute(result, '\t', spccol, 'g')
	endif
	return result
endfunction

" Convert whitespace used for indenting (before first non-whitespace).
" what = 0 (convert spaces to tabs), or 1 (convert tabs to spaces).
" cols = string with number of columns per tab, or empty to use 'tabstop'.
" The cursor position is restored, but the cursor will be in a different
" column when the number of characters in the indent of the line is changed.
function! IndentConvert(line1, line2, what, cols)
	let savepos = getpos('.')
	let cols = empty(a:cols) ? &tabstop : a:cols
	execute a:line1 . ',' . a:line2 . 's/^\s\+/\=Indenting(submatch(0), a:what, cols)/e'
	call histdel('search', -1)
	call setpos('.', savepos)
endfunction

" Space2Tab
" Tab2Space
" RetabIndent
command! -nargs=? -range=% Space2Tab call IndentConvert(<line1>,<line2>,0,<q-args>)
command! -nargs=? -range=% Tab2Space call IndentConvert(<line1>,<line2>,1,<q-args>)
command! -nargs=? -range=% RetabIndent call IndentConvert(<line1>,<line2>,&et,<q-args>)

function! VisualSelection(direction, extra_filter) range
	let l:saved_reg = @"
	execute "normal! vgvy"

	let l:pattern = escape(@", '\\/.*$^~[]')
	let l:pattern = substitute(l:pattern, "\n$", "", "")

	if a:direction == 'b'
		execute "normal ?" . l:pattern . "^M"
	elseif a:direction == 'ag'
		execute 'Ag '.l:pattern
	elseif a:direction == 'replace'
		execut  "%s" . '/'. l:pattern . '/'
	elseif a:direction == 'f'
		execute "normal /" . l:pattern . "^M"
	endif

	let @/ = l:pattern
	let @" = l:saved_reg
endfunction

" =============================== Shortcut setting =======================
if(has("mac"))
	nnoremap <D-3> :exec exists('syntax_on') ? 'syn off': 'syn on'<CR>
	nnoremap <D-4> mzgg=G`z

	nnoremap <D-5> ggVG:RetabIndent<CR>
	" Full Fucking Window ^M ending line file!
	nnoremap <D-6> :%s////g
else
	nnoremap <F3> :exec exists('syntax_on') ? 'syn off': 'syn on'<CR>
	nnoremap <F4> mzgg=G`z

	nnoremap <F9> ggVG:RetabIndent<CR>
	" Full Fucking Window ^M ending line file!
	nnoremap <F10> :%s////g
endif
" NERDTree
nnoremap <F2> :NERDTreeToggle<CR>

" Tagbar
nnoremap <F8> :TagbarToggle<CR>

" Window VertSplit switcher
nnoremap <leader><leader>h <C-w>h
nnoremap <leader><leader>j <C-w>j
nnoremap <leader><leader>k <C-w>k
nnoremap <leader><leader>l <C-w>l

" Set as toggle foldcomment
nnoremap zc @=((foldclosed(line('.')) < 0) ? 'zc' :'zo')<CR>
nnoremap zr zR
" Fast searcher
nnoremap z, :FZF --no-mouse .<CR>

" insert empty line
nnoremap <silent> zj o<ESC>k
nnoremap <silent> zk O<ESC>j

" Format Jump
nnoremap <silent> g; g;zz
nnoremap <silent> g, g,zz

" Smooth Scroll the terminal
nnoremap <silent> <C-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
nnoremap <silent> <C-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>

if(has('mac'))
	cnoremap <D-j> <Down>
	cnoremap <D-k> <Up>
	" cnoremap <D-h> <Left>
	" cnoremap <D-l> <Right>
	inoremap <D-j> <Down>
	inoremap <D-k> <Up>
	inoremap <D-[> <ESC>
	" inoremap <D-h> <Left>
	" inoremap <D-l> <Right>
else
	" Cursor Moving
	cnoremap <A-j> <Down>
	cnoremap <A-k> <Up>
	cnoremap <A-h> <Left>
	cnoremap <A-l> <Right>
	inoremap <A-j> <Down>
	inoremap <A-k> <Up>
	inoremap <A-h> <Left>
	inoremap <A-l> <Right>

	cnoremap <M-j> <Down>
	cnoremap <M-k> <Up>
	cnoremap <M-h> <Left>
	cnoremap <M-l> <Right>
	inoremap <M-j> <Down>
	inoremap <M-k> <Up>
	inoremap <M-h> <Left>
	inoremap <M-l> <Right>
endif

" Like Emacs
inoremap <C-e> <End>
inoremap <C-f> <Home>
inoremap <C-d> <Esc>VypA
inoremap <C-w> <C-o>w
inoremap <C-b> <C-o>b
vnoremap <C-c> "+y

" TabLine Tab configure KeyFire
nnoremap <leader>t :tabnew<CR>
nnoremap <leader>tn :tabnew<CR>
nnoremap <leader>tl :tabnext<CR>
nnoremap <leader>th :tabprevious<CR>
nnoremap <leader>tx :tabclose<CR>
nnoremap <leader>tc :tabclose<CR>

" Buffers KeyFire
nnoremap <leader>b :buffers<CR>

" Buftabline Config Manager
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprev<CR>
nnoremap <C-x> :bdelete<CR>

" Check Vim Syntax name Fn
nnoremap <leader>yi :call <SID>SynStack()<CR>

" MRU
nnoremap <leader>uh :MRU<CR>

" Split faster
nnoremap <leader>% :vs<CR>
nnoremap <leader>" :sp<CR>

" Fast to copy files path
nnoremap <leader>p "+gp
vnoremap <leader>p "+p
vnoremap <leader>y "+y
vnoremap <leader>d "+d
nnoremap <leader>cd :cd %:p:h<CR>
nnoremap <leader>cp :let @+=expand("%:p")<CR>:echo "Copied current file
			\ path '".expand("%:p")."' to clipboard"<CR>

" <leader>ss: Spell checking shortcuts
" fold enable settings
nnoremap <leader>ss :setlocal spell!<CR>
nnoremap <leader>sj ]szz
nnoremap <leader>sk [szz
nnoremap <leader>sa zg]szz
nnoremap <leader>sd 1z=
nnoremap <leader>sf z=

" Incsearch
" nnoremap / /\v
" vnoremap / /\v
map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

map n <Plug>(incsearch-nohl-n)zzzv
map N <Plug>(incsearch-nohl-N)zzzv
map * <Plug>(incsearch-nohl-*)zzzv
map # <Plug>(incsearch-nohl-#)zzzv
map g* <Plug>(incsearch-nohl-g*)zzzv
map g# <Plug>(incsearch-nohl-g#)zzzv

" Multi Cursor Find
vnoremap <leader>mf :MultipleCursorsFind
vnoremap <leader>s :call VisualSelection('ag', '')<CR>

" Multi Expand Region
map KK <Plug>(expand_region_expand)
map JJ <Plug>(expand_region_shrink)

"Emmet
imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")

" vim-operator-flashy
" Highlight yanked area
map y <Plug>(operator-flashy)
nmap Y <Plug>(operator-flashy)$

"Ag bind \ (backward slash) to grep shortcut
nnoremap \ :Ag<SPACE>
" =============================== Ignore setting =========================
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif
set wildignore+=*.so,*.swp,*.zip,*/.Trash/**,*.pdf,*.dmg,*/Library/**,*/.rbenv/**
set wildignore+=*/.nx/**,*.app,*.git,.git
