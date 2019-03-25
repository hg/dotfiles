" vim: sw=2 sts=2 et

" search files recursively in current directory
set path+=**

" backspace over autoindent, line breaks, start of insert
set backspace=indent,eol,start

" show cursor position
set ruler

" yank to the end of line
nnoremap Y y$

" auto read when a file is changed from the outside
set autoread

" show N next/prev lines to the cursor when moving up/down
set scrolloff=1

" show possible commands when pressing Tab in command line
set wildmenu

" find stuff as you type
set incsearch

" ignore case while searching
set ignorecase

" override 'ignorecase' when pattern contains upper case chars
set smartcase

" use UTF-8 as default encoding
set encoding=utf-8

" set order of line break types
set fileformats=unix,dos

" delete comment character when joining commented lines
set formatoptions+=j

" keep changed buffers in the background without saving them
set hidden

" show command input as you type
set showcmd

" enable line numbering
set relativenumber

" show tabs and all trailing whitespace
set list
set listchars=tab:>-,trail:•,extends:>,precedes:<

" use space as leader key
let mapleader = " "

" set encryption method
set cryptmethod = "blowfish2"

" handy way to switch between windows
map <C-h> <C-W>h
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-l> <C-W>l

" 'W' command to 'sudo save' the file
command! W w !sudo tee % > /dev/null

" remember last position in file
au BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") |
      \   exe "normal! g'\"" |
      \ endif

" enable mouse support
if has('mouse')
  set mouse=a
endif

" undo changes from last editing sessions
if has('persistent_undo')
  set undodir=~/.vim/undo/
  silent call system('mkdir -p ' . &undodir)
  set undofile
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              editor appearance                              "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 24-bit colors
if &t_Co > 256
  set termguicolors
endif

" hide toolbar, menu, and scrollbars
if has('gui_running')
  set guioptions-=T
  set guioptions-=m
  set guioptions-=r
  set guioptions-=R
  set guioptions-=l
  set guioptions-=L
endif

" highlight 80th column
set colorcolumn=80

" highlight current line
set cursorline

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                 load plugins                                "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin()

" plugins
" Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }

" themes
Plug 'w0ng/vim-hybrid'

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                    theme                                    "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

colorscheme hybrid
set background=dark

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              configure plugins                              "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" netrw
let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_liststyle = 3
let g:netrw_list_hide = netrw_gitignore#Hide()

" vim-go
" let g:go_fmt_command = "goimports"
" let g:go_metalinter_autosave = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  hotkeys                                    "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" quickfix jumps
map <C-,> :cprevious<CR>
map <C-.> :cnext<CR>

" format as table
vnoremap <Tab> !column -t -o ' '<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            configure filetypes                              "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" bash & friends
autocmd FileType sh call ConfigureLangModeShell()
function ConfigureLangModeShell()
  setlocal expandtab
  setlocal shiftwidth=2
  setlocal softtabstop=2
endfunction

