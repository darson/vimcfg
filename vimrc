"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=500
set textwidth=500

" Enable filetype plugins
filetype plugin on
filetype indent on

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ";"

" Line numner
set number

" Mouse should be used in normal mode
set mouse=r

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set scrolloff=7

" Turn on the Wild menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
  set wildignore+=.git\*,.hg\*,.svn\*
else
  set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

"Always show current position
set ruler

" Height of the command bar
set cmdheight=1

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Add a bit extra margin to the left
set foldcolumn=1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

try
  colorscheme desert
catch
endtry

set background=dark

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936

" Use Unix as the standard file type
set ffs=unix,dos,mac


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set nowb
set noswapfile



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew 
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <F2> :tabprevious<cr>
map <F3> :tabnext<cr> 
map <leader>tf :tabfirst<cr>
map <leader>tl :tablast<cr>

" Command line mode, c-a goto the beginning
cnoremap <C-A> <Home>

" jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2

" override stupid vim default of python
autocmd FileType python setlocal shiftwidth=2 softtabstop=2 tabstop=2

" Linebreak on 500 characters
set lbr

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines


""""""""""""""""""""""""""""""
" => Customize key mapping
""""""""""""""""""""""""""""""
" close script buffer if exists
function s:CloseYuanScriptBuf()
  " check bufexists in case of buf already closed by user
  if exists("s:YuanRunScriptBufNR") && bufexists(s:YuanRunScriptBufNR)
    execute "bd" .. s:YuanRunScriptBufNR
  endif
endfunction

" run auto command like rsync to remote
function s:YuanRunScript(path)
  call s:CloseYuanScriptBuf()
  let s:YuanRunScriptBufNR = term_start(a:path, {"vertical": 1})
endfunction
map <silent> <F5> :call <SID>YuanRunScript("/bin/bash " .. getcwd() .. "/run.sh")<cr>

" close all helper buffers
function s:OmniClose()
  TagbarClose
  NERDTreeClose
  normal gq
  call s:CloseYuanScriptBuf()
  cclose
endfunction

function s:OpenShell()
  let l:file_parent_dir = expand("%:p:h")
  let l:buf = term_start("/bin/bash", {"term_finish": "close"})
  call term_sendkeys(l:buf, "cd " .. l:file_parent_dir .. " && clear\<cr>")
endfunction

map <silent> <F6> :call <SID>OpenShell()<CR>


" close tagbar,nerdtree,fugitive at once
map <silent> <F4> :call <SID>OmniClose()<CR>

" disable F1
map <F1> <Esc>
imap <F1> <Esc>
map <F7> :cprevious<CR>
map <F8> :cnext<CR>

" scroll the other split
map <C-S-E> <C-W>w<C-e><C-w>w
map <C-S-Y> <C-W>w<C-y><C-w>w

""""""""""""""""""""""""""""""
" => Plugins
""""""""""""""""""""""""""""""
set nocompatible              

call plug#begin('~/.vim/plugged')

Plug 'easymotion/vim-easymotion'
Plug 'majutsushi/tagbar'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-surround'
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-fugitive'
Plug 'davidhalter/jedi-vim'
Plug 'Yggdroot/indentLine'
Plug 'itchyny/lightline.vim'

call plug#end()

""""""""""""""""""""""""""""""
" => CTRL-P
""""""""""""""""""""""""""""""
let g:ctrlp_working_path_mode = 0
let g:ctrlp_max_height = 20
let g:ctrlp_custom_ignore = 'node_modules\|^\.DS_Store\|^\.git\|^\.coffee\|^\.pyc'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Nerd Tree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDTreeWinPos = "right"
let NERDTreeShowHidden=0
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let g:NERDTreeWinSize=35
let g:NERDTreeDirArrowExpandable = '>'
let g:NERDTreeDirArrowCollapsible = '+'
let g:NERDTreeMapOpenSplit = "s"
let g:NERDTreeMapPreviewSplit = "gs"
let g:NERDTreeMapOpenVSplit = "v"
let g:NERDTreeMapPreviewVSplit = "gv"
map <leader>nn :NERDTreeToggle<cr>
map <leader>nf :NERDTreeFind<cr>

""""""""""""""""""""""""""""""
" => Tagbar
""""""""""""""""""""""""""""""
map <leader>tt :TagbarToggle<CR><c-w><c-w>


""""""""""""""""""""""""""""""
" => jedi-vim
""""""""""""""""""""""""""""""
let g:jedi#completions_command = "<C-N>"
let g:jedi#popup_on_dot = 0
let g:jedi#use_tabs_not_buffers = 1
let g:jedi#show_call_signatures = 0

""""""""""""""""""""""""""""""
" => indent-line
""""""""""""""""""""""""""""""
let g:indentLine_enabled = 0
map <silent> <leader>i :IndentLinesToggle<CR>

""""""""""""""""""""""""""""""
" => lightline
""""""""""""""""""""""""""""""
set laststatus=2
set noshowmode
let g:lightline = {
  \ 'colorscheme': 'wombat',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
  \ },
  \ 'component_function': {
  \   'gitbranch': 'FugitiveHead'
  \ },
  \ }

" change wombat's active tabline to white bg color
let s:lltabcolor=g:lightline#colorscheme#wombat#palette
let s:lltabcolor.tabline.tabsel=[["#000000", "#e2e2e2", 0, 254]]

""""""""""""""""""""""""""""""
" Additional customize rc
""""""""""""""""""""""""""""""
if filereadable(expand("~/myrc"))
  source ~/myrc
endif

