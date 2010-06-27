" Colorscheme and Background "{{{
set background=light 	" light things up
if has("gui_running")
	set lines=41 columns=142 	" Set window size close to maximized
	colorscheme wombat			" Need a better one...
elseif ( &term =~ 'linux' || $DISPLAY =~ ' ')
	colorscheme desert256
else                            " we are on tty
	set t_Co=256				" Using 256-color yay
	colorscheme neverland-laptop " This 256-theme rocks!
	"set term=rxvt-256color
    " Stupid Bindings for tmux/Screen "{{{
    
    if $TERM == "linux"	" we are in X (hopefully)
    "set t_#2=[7$     
    "set t_KB=O*n     
    set t_kh=[7~
    set t_@7=[8~
    "set t_#4=[d      
    set t_k1=[11;*~  
    "set t_kl=O*D
    "set t_%1=[28;*~  
    set t_k2=[12;*~  
    "set t_kr=O*C
    "set t_%i=[c      
    set t_k3=[13;*~  
    "set t_ku=O*A
    "set t_&8=[26;*~  
    set t_k4=[14;*~  
    "set t_*7=[8$     
    set t_k5=[15;*~ 
    set t_k6=[17;*~
    set t_F1=[23;*~  
    set t_k7=[18;*~  
    set t_F2=[24;*~  
    set t_k8=[19;*~ 
    "set t_K1=[1;*~   
    set t_k9=[20;*~
    "set t_K3=Oy      
    set t_k;=[21;*~
    "set t_K4=[4;*~   
    "set t_kB=[Z   
    "set t_K5=Os      
    set t_kD=[3~   
    "set t_K6=O*k     
    "set t_kI=[2;*~
    "set t_K7=O*m     
    set t_kN=[6;*~
    "set t_K8=O*o     
    set t_kP=[5;*~       
    "set t_K9=O*j     
    "set t_KA=O*M     
    "set t_kd=O*B       
    
    endif
    "}}}
endif
" }}}

" Folds "{{{
if has('folding')
	set foldenable " Enable code folding
	set foldmethod=marker " Fold on marker
	"set foldopen-=search " Do not open folds when searching
	set foldopen-=undo " Do not open folds when undo'ing changes
	set foldlevel=0 " Zero default so folds are hidden at start
	" set foldlevel=999 " High default so folds are shown to start
	set foldmarker={{{,}}} " Keep foldmarkers default
	set foldcolumn=0 " Don't waste screen space
endif
" }}}

" Indenting and spaces " {{{
set backspace=indent,eol,start
set smarttab		" tabs at the beginning of lines, spaces everywhere else
set tabstop=4		" Number of spaces of tab character
set softtabstop=4 	" Backspace fake tabs
set shiftwidth=4	" Number of spaces to (auto)indent
"set expandtab		" Insert spaces instead of tabs
set whichwrap=b,s,h,l,<,>,~,[,] 
set autoindent		" Always set autoindenting on
set cindent         " Use strict C indenting
" }}}

" Plugins, Backup options " {{{
syntax on
filetype on
filetype plugin on
filetype indent on

set nocompatible 	" vi is dead
set backup
set backupdir=~/.vim/backup
set autowrite		" Save before commands like :next and :make
set mouse=a
" }}}

" Matching (), History, Lineno, Search options " {{{
set showfulltag         " Get function usage help automatically
set showcmd             " Show current vim command in status bar
set showmatch           " Show matching parentheses/brackets
set matchtime=3			" Show matching brackets for only 0.3 seconds
set showmode            " Show current vim mode
set viminfo='20,\"50    " read/write a .viminfo file, don't store more
						" than 50 lines of registers
set history=50          " keep 50 lines of command line history
set ruler               " show the cursor position all the time
set number 				" show line numbers

set hlsearch 		" highlight search terms
set incsearch 		" go jump around hits
set ignorecase		" search ignoring case
set wildignore=*.o,*.obj,*.bak,*.exe
set hidden			" hide buffers
" }}}

" Ripped of from a .vimrc in github
if v:version >= 700
    set numberwidth=1 " Keep number bar small if it's shown
    set completeopt-=menu " Get rid of the ugly menu
endif

" Low priority filename suffixes for filename completion {{{
set suffixes-=.h        " Don't give .h low priority
set suffixes+=.aux
set suffixes+=.log
set wildignore+=*.dvi
set suffixes+=.bak
set suffixes+=~
set suffixes+=.swp
set suffixes+=.o
set suffixes+=.class
" }}}

" Status Line "{{{
"
" cool status line with name, format, filetype, ascii/hex value of the 
"  char under the cursor, file position and line count
" set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set laststatus=2

" Uber cool status line
" Ripped of in github.com
set statusline=%F%m%r%h%w%=(%{strlen(&ft)?&ft:'?'},%{&fenc},%{&ff})\ \ %-9.(%l,%c%V%)\ \ %<%P

"}}}

" Key mappings {{{

" Move text, but keep highlight
vnoremap > ><CR>gv
vnoremap < <<CR>gv

" Allow the . to execute once for each line in visual selection
vnoremap . :normal .<CR>

" Make tab perform keyword/tag completion if we're not following whitespace
inoremap <tab> <c-r>=InsertTabWrapper()<cr>

" no more shift for :commands
:map , :

" Programming Keys:
"   F9  = Make
"   F10 = Next Error
"   F11 = Prev Error
"inoremap <F9> <Esc>:make<CR>
inoremap <F9> <Esc>:make<CR><CR>:copen<CR>
inoremap <F10> <Esc>:cnext<CR>
inoremap <F11> <Esc>:cprev<CR>
noremap <F9> <Esc>:make<CR>
noremap <F10> <Esc>:cnext<CR>
noremap <F11> <Esc>:cprev<CR>

" Buffer Switching:
"   F2 = next buffer
"   F3 = previous buffer
"   F4 = kill buffer
inoremap <F2> <Esc>:bn<CR>
inoremap <F3> <Esc>:bp<CR>
inoremap <F4> <Esc>:bd<CR>
noremap <F2> <Esc>:bn<CR>
noremap <F3> <Esc>:bp<CR>
noremap <F4> <Esc>:bd<CR>

" map <F12> to toggle the NERD_Tree
:map <F12> <Esc>:NERDTreeToggle<CR>

" Ctrl-s saves
:inoremap <C-s> <Esc>:w<CR>a
:nnoremap <C-s> :w<CR>

" Key mappings }}}

" Auto Commands "{{{
if has('autocmd')

	" Automatically add CREATED date and update MODIFIED date
    autocmd BufNewFile * call Created()
    autocmd BufWrite * call LastModified()

	" Set comment characters for common languages
	autocmd FileType python,sh,bash,zsh,ruby,perl,muttrc let StartComment="#" | let EndComment=""
	autocmd FileType html let StartComment="<!--" | let EndComment="-->"
	autocmd FileType php,cpp,javascript let StartComment="//" | let EndComment=""
	autocmd FileType c,css let StartComment="/*" | let EndComment="*/"
	autocmd FileType vim let StartComment="\"" | let EndComment=""
	autocmd FileType ini let StartComment=";" | let EndComment=""

	" Go back where I left off
	autocmd BufReadPost * call RestoreCursorPos()
	autocmd BufWinEnter * call OpenFoldOnRestore()
endif

    " Reread configuration of Vim if .vimrc is saved {{{
    augroup VimConfig
        au!
        autocmd BufWritePost ~/.vimrc       so ~/.vimrc
        autocmd BufWritePost vimrc          so ~/.vimrc
    augroup END
    " }}}
"}}}

" Tabs {{{

" max number of tabs to display (not open)
:set tabpagemax=6

" Tab manipulation
" :noremap <silent> <C-t> :tabnew<cr>
" :noremap <silent> <C-w> :tabc<cr>
" :noremap <silent> <C-tab> :tabn<cr>
" :noremap <silent> <C-s-tab> :tabp<cr> 
" noremap! <silent> <C-t> :tabnew<cr>
" noremap! <silent> <C-x> :tabc<cr>
" noremap! <silent> <C-tab> :tabn<cr>
" noremap! <silent> <C-s-tab> :tabp<cr> 

:nmap <C-S-tab> :tabprevious<cr>
:nmap <C-tab> :tabnext<cr>
:nmap <C-t> :tabnew<cr>
:map <C-t> :tabnew<cr>
:map <C-S-tab> :tabprevious<cr>
:map <C-tab> :tabnext<cr>
" :map <C-w> :tabclose<cr> "messes with vsp navigation
:imap <C-S-tab> <ESC>:tabprevious<cr>i
:imap <C-tab> <ESC>:tabnext<cr>i
:imap <C-t> <ESC>:tabnew<cr>

" Tabs }}}

" Functions " {{{

" Auto update create date {{{
 function! Created()
	 normal msHmS
	 let n = min([20, line("$")])
	 execute '1,' . n . 's#^\(.\{,10}CREATED: \).*#\1' .  strftime('%Y-%m-%d %H:%M') . '#e'
	 normal `Szt`s
	 call LastModified()
 endfunction
 " }}}

 " Auto update last modified date {{{
 function! LastModified()
	 if &modified
		 normal msHmS
		 let n = min([20, line("$")])
		 execute '1,' . n .  's#^\(.\{,10}MODIFIED: \).*#\1' .  strftime('%Y-%m-%d %H:%M') .  '#e'
		 normal `Szt`s
	 endif
 endfunction
 " }}}

" Restore my cursor position {{{
function! RestoreCursorPos()
	if expand("<afile>:p:h") !=? $TEMP
		if line("'\"") > 1 && line("'\"") <= line("$")
			let line_num = line("'\"")
			let b:doopenfold = 1
			if (foldlevel(line_num) > foldlevel(line_num - 1))
				let line_num = line_num - 1
				let b:doopenfold = 2
			endif
			execute line_num
		endif
	endif
endfunction
" }}}

" Open the fold if restoring cursor position {{{
function! OpenFoldOnRestore()
	if exists("b:doopenfold")
		execute "normal zv"
		if(b:doopenfold > 1)
			execute "+".1
		endif
		unlet b:doopenfold
	endif
endfunction
" }}}

" InsertTabWrapper() {{{
" Tab completion of tags/keywords if not at the beginning of the
" line.  Very slick.
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
" InsertTabWrapper() }}}

" Functions }}}

" Settings for specific syntax files {{{
let c_gnu=1
let c_comment_strings=1
let c_space_errors=1

"let perl_fold=1          " turn on perl folding capabilities
" }}}
