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

" disable mouse
set mouse=

" use space as leader key
let mapleader = " "

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

" undo changes from last editing sessions
if has('persistent_undo')
  set undodir=~/.vim/undo/
  silent call system('mkdir -p ' . &undodir)
  set undofile
endif

let g:python_host_prog  = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python3'

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

" https://github.com/kovidgoyal/kitty/issues/108#issuecomment-320492663
" vim hardcodes background color erase even if the terminfo file does
" not contain bce (not to mention that libvte based terminals
" incorrectly contain bce in their terminfo files). This causes
" incorrect background rendering when using a color theme with a
" background color.
let &t_ut=''

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                 load plugins                                "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin()

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-sleuth'

" themes
Plug 'w0ng/vim-hybrid'

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                    theme                                    "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:gruvbox_contrast_dark = 'hard'

colorscheme hybrid
set background=dark

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              configure plugins                              "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:deoplete#enable_at_startup = 1
set completeopt-=preview

let g:LanguageClient_serverCommands = {
  \ 'cpp': ['clangd'],
  \ 'go': ['gopls'],
  \ }

autocmd BufWritePre *.go :call LanguageClient#textDocument_formatting_sync()

" netrw
let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_liststyle = 3
let g:netrw_list_hide = netrw_gitignore#Hide()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  hotkeys                                    "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" quickfix jumps
map <C-,> :cprevious<CR>
map <C-.> :cnext<CR>

" format as table
vnoremap <Tab> !column -t -o ' '<CR>

" Alt+F
nnoremap <M-f> :GFiles<CR>
nnoremap <M-x> :Commands<CR>
nnoremap <M-s> :Rg<CR>

nnoremap <leader>f                 :call LanguageClient#textDocument_formatting_sync()<CR>
nnoremap <silent> <leader><leader> :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <leader>b        :call LanguageClient#textDocument_implementation()<CR>
nnoremap <silent> <leader>m        <Plug>(lcn-menu)
nnoremap <silent> <leader>r        :call LanguageClient#textDocument_references()<CR>
nnoremap <silent> <leader>n        :call LanguageClient#textDocument_rename()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            configure filetypes                              "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" bash & friends
autocmd FileType sh call ConfigureLangModeShell()
function ConfigureLangModeShell()
  nnoremap <leader>f :w<CR> :!shfmt -w -s -i 2 %<CR><CR>
  nnoremap <leader>c :w<CR> :!shellcheck %<CR>
endfunction

" cpp
autocmd FileType c,cpp,go call ConfigureLangModeCpp()
function ConfigureLangModeCpp()
endfunction

autocmd FileType go call ConfigureLangModeGo()
function ConfigureLangModeGo()
  setlocal ts=4
endfunction
