"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Standalone Vim Configuration
" Mateo Olaya's .vimrc - No external dependencies
" Last Updated: 2025-04-15
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GENERAL SETTINGS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible              " Use Vim defaults instead of 100% vi compatibility
set backspace=indent,eol,start " More powerful backspacing
set history=1000             " Keep 1000 lines of command line history
set ruler                    " Show the cursor position all the time
set showcmd                  " Display incomplete commands
set incsearch                " Do incremental searching
set wildmenu                 " Display completion matches in a status line
set ttimeout                 " Time out for key codes
set ttimeoutlen=100          " Wait up to 100ms after Esc for special key
set display=truncate         " Show @@@ in the last line if it is truncated
set scrolloff=5              " Keep 5 lines above/below cursor visible
set nrformats-=octal         " Don't treat numbers with leading zeros as octal
set hidden                   " Allow buffer switching without saving

" Enable file type detection and do language-dependent indenting
filetype plugin indent on

" Switch syntax highlighting on
syntax on

" Set encoding and file format defaults
set encoding=utf-8
set fileformats=unix,dos,mac

" Set default indentation - tabs as spaces
set expandtab           " Use spaces instead of tabs
set tabstop=4           " A tab is 4 spaces
set shiftwidth=4        " Number of spaces to use for autoindent
set softtabstop=4       " A tab press is 4 spaces
set autoindent          " Copy indent from current line when starting a new line
set smartindent         " Smart autoindenting when starting a new line

" No backup files - live on the edge (or use version control)
set nobackup
set nowritebackup
set noswapfile

" Set terminal title
set title

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" USER INTERFACE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set number              " Show line numbers
set relativenumber      " Show relative line numbers (absolute for current line)
set laststatus=2        " Always show status line
set cursorline          " Highlight current line
set showmatch           " Show matching brackets
set matchtime=2         " Show matching brackets for 0.2 seconds
set noerrorbells        " No beeping
set visualbell          " Flash the screen instead of beeping
set t_vb=               " Even better: no flashing
set shortmess+=I        " Don't show the Vim intro message
set colorcolumn=80      " Highlight column 80
set signcolumn=yes      " Always show sign column for git gutter, linting, etc.

" Search settings
set hlsearch            " Highlight search results
set ignorecase          " Case-insensitive searching
set smartcase           " Case-sensitive if expression contains a capital letter

" Folding settings
set foldmethod=indent   " Fold based on indentation
set foldnestmax=10      " Max 10 depth
set nofoldenable        " Don't fold by default
set foldlevel=2         " When folding is enabled, default level

" Make the completion menu behave like an IDE
set completeopt=menu,menuone,popup,noselect,noinsert

" Use a native colorscheme (works in terminal too)
colorscheme desert

" Try to improve colors in terminal
if !has('gui_running')
  set t_Co=256
endif

" Status line configuration 
set statusline=
set statusline+=\ %f                           " File path relative to current directory
set statusline+=\ %y                           " Filetype
set statusline+=\ %m                           " Modified flag
set statusline+=\ %r                           " Read-only flag
set statusline+=%=                             " Switch to right side
set statusline+=\ %l/%L\ [%p%%]                " Current line/total lines [percentage]
set statusline+=\ %c                           " Column number
set statusline+=\ [%{&fileencoding?&fileencoding:&encoding}] " File encoding

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NETRW SETTINGS (Built-in File Explorer)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:netrw_banner = 0       " Hide the banner at the top
let g:netrw_liststyle = 3    " Use tree view
let g:netrw_browse_split = 4 " Open files in previous window
let g:netrw_altv = 1         " Split to the right
let g:netrw_winsize = 25     " Set width of explorer to 25% of screen

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" KEY MAPPINGS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set leader key to comma
let mapleader = ","

" Press Space to turn off search highlighting and clear any message displayed
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Quickly edit/reload vimrc
nnoremap <leader>ev :e $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>:echo "vimrc reloaded!"<CR>

" Easier navigation between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Toggle file explorer
nnoremap <leader>e :Lexplore<CR>

" Quick save
nnoremap <leader>w :w<CR>

" Buffer navigation
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprevious<CR>
nnoremap <leader>bd :bdelete<CR>
nnoremap <leader>bl :buffers<CR>

" Tab navigation
nnoremap <leader>tn :tabnext<CR>
nnoremap <leader>tp :tabprevious<CR>
nnoremap <leader>tc :tabclose<CR>
nnoremap <leader>to :tabnew<CR>

" Toggle between relative/absolute line numbers
nnoremap <leader>n :set relativenumber!<CR>

" Keep selection after indent/outdent
vnoremap < <gv
vnoremap > >gv

" Better undo breaks
inoremap . .<C-g>u
inoremap ! !<C-g>u
inoremap ? ?<C-g>u
inoremap , ,<C-g>u

" Quickly insert current date and time
inoremap <leader>dt <C-r>=strftime('%Y-%m-%d %H:%M:%S')<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FILETYPE SPECIFIC SETTINGS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set up default for any files not covered by other filetypes
autocmd FileType *                 setlocal formatoptions-=cro " Disable auto-commenting for all files

" Text files
autocmd FileType text              setlocal textwidth=80
autocmd FileType text              setlocal spell spelllang=en_us

" Markdown files
autocmd FileType markdown          setlocal spell spelllang=en_us
autocmd FileType markdown          setlocal textwidth=80

" Python files
autocmd FileType python            setlocal tabstop=4 shiftwidth=4 expandtab
autocmd FileType python            setlocal textwidth=88 " Black formatter default
autocmd FileType python            setlocal colorcolumn=88

" JavaScript/TypeScript
autocmd FileType javascript,typescript    setlocal tabstop=2 shiftwidth=2 expandtab
autocmd FileType javascript,typescript    setlocal colorcolumn=100

" HTML, XML, CSS
autocmd FileType html,xml,css,scss  setlocal tabstop=2 shiftwidth=2 expandtab
autocmd FileType html,xml,css,scss  setlocal colorcolumn=100

" Go
autocmd FileType go                setlocal noexpandtab tabstop=4 shiftwidth=4

" Rust
autocmd FileType rust              setlocal tabstop=4 shiftwidth=4 expandtab

" YAML
autocmd FileType yaml              setlocal tabstop=2 shiftwidth=2 expandtab indentkeys-=<:>

" Shell scripts
autocmd FileType sh,zsh,bash       setlocal tabstop=2 shiftwidth=2 expandtab

" Ensure gitcommit files have spell-checking and right text width
autocmd FileType gitcommit         setlocal spell spelllang=en_us textwidth=72

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ADVANCED SETTINGS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Persistent undo
if has('persistent_undo')
  set undodir=~/.vim/undodir
  if !isdirectory(&undodir)
    call mkdir(&undodir, 'p', 0700)
  endif
  set undofile
endif

" Detect indentation of files
if has("autocmd")
  augroup detect_indent
    autocmd!
    autocmd BufReadPost * silent! Detect
  augroup END
endif

" Remember last position in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Autoread changes from disk
set autoread
if has("autocmd")
  autocmd FocusGained,BufEnter * :checktime
endif

" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Command to remove trailing whitespace
nnoremap <leader>tw :%s/\s\+$//e<CR>:let @/=''<CR>

" Make cursor line stand out more in active window and show normal cursor in inactive windows
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

" Enable mouse support in all modes
set mouse=a

" Enable system clipboard integration if available
if has('clipboard')
  set clipboard=unnamed
  if has('unnamedplus')
    set clipboard+=unnamedplus
  endif
endif

" Use ripgrep or ag for grepping if available
if executable('rg')
  set grepprg=rg\ --vimgrep
  set grepformat=%f:%l:%c:%m
elseif executable('ag')
  set grepprg=ag\ --vimgrep
  set grepformat=%f:%l:%c:%m
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" LOCAL CUSTOMIZATIONS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Load local customizations if they exist
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
