""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Basic configuration

" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc.
" Not necessary to set with neovim, but useful for vim.
set nocompatible

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype plugin indent on

" Enable syntax highlighting.
syntax on

" Enable list mode and set easily identifiable characters for tabs, non-breaking
" space and trailing whitespace. Setting custom tab characters has the nice side
" effect that it allows moving the cursor to the beginning of a tab.
" Note that this will interfere with soft line wrapping (`set nolist`).
set list
execute "set listchars=tab:\uBB\uB7,nbsp:~,trail:\uB7"

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid, when inside an event handler
" (happens when dropping a file on gvim) and for a commit message (it's
" likely a different one than last time).
autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
  \ |   exe "normal! g`\""
  \ | endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
    \ | wincmd p | diffthis
endif

" Vim with default settings does not allow easy switching between multiple
" buffers in the same window. Users can use multiple split windows or multiple
" tab pages to edit multiple files, but it is still best to enable an option to
" allow easier switching between files.
"
" One such option is the 'hidden' option, which allows you to re-use the same
" window and switch from an unsaved buffer without saving it first. Also allows
" you to keep an undo history for multiple files when re-using the same window
" in this way. Note that using persistent undo also lets you undo in multiple
" files even in the same window, but is less efficient and is actually designed
" for keeping undo history after closing Vim entirely. Vim will complain if you
" try to quit without saving, and swap files will keep you safe if your computer
" crashes.
set hidden

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Open new split panes on the right and below.
set splitbelow
set splitright

" Better command-line completion.
set wildmenu

" Show partial commands in the last line of the screen.
set showcmd

" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below).
set hlsearch

" Highlight search matches while typing.
set incsearch

" Use case insensitive search, except when using capital letters.
set ignorecase
set smartcase

" Allow backspacing over autoindent, line breaks and start of insert action.
set backspace=indent,eol,start

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline

" Display the cursor position on the last line of the screen or in the status
" line of a window.
set ruler

" Disable showmode since using vim-airline; otherwise use 'set showmode'.
set noshowmode

" Always display the status line, even if only one window is displayed.
set laststatus=2

" Scroll a bit horizontally when at the end of the line.
set sidescroll=6

" Use visual bell instead of beeping when doing something wrong.
set visualbell

" And reset the terminal code for the visual bell. If visualbell is set, and
" this line is also included, vim will neither flash nor beep. If visualbell
" is unset, this does nothing.
set t_vb=

" Enable use of the mouse for all modes.
set mouse=a

" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue".
"set cmdheight=2

" Display line numbers on the left.
set number

" Quickly time out on keycodes, but never time out on mappings.
set notimeout ttimeout ttimeoutlen=200

" Use <F11> to toggle between 'paste' and 'nopaste'.
set pastetoggle=<F11>

" Indentation settings for using 2 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
" See: http://stackoverflow.com/questions/426963/replace-tab-with-spaces-in-vim
set shiftwidth=2 softtabstop=2 expandtab

" '100: Remember marks for the last 100 edited files.
" <1000: Limit the number of lines saved for each register to 1000 lines.
" s100: Skip registers with more than 100KB of text.
" h: Disable search highlighting when Vim starts.
" n...: Save state information in a more appropriate place.
execute 'set shada=''100,<1000,s100,h,n' . g:xdg_state_home . '/nvim/shada/main.shada'

" Save swap files to a more appropriate place.
" Important: The two trailing spaces are significant! See `:h 'directory'`.
execute 'set directory=' . g:xdg_state_home . '/nvim/swap//'

" Move .netrwhist to cache directory.
let g:netrw_home=g:xdg_state_home . '/nvim'

" Enable code completion.
set omnifunc=syntaxcomplete#Complete

" Display a ruler by coloring column 81 red.
"set colorcolumn=81
" Better: Display ruler only where the line limit actually exceeds 80.
highlight ColorColum ctermbg=magenta
call matchadd('ColorColumn', '\%81v.', 100)

" Change color of line numbers to grey.
highlight LineNr ctermfg=grey

" Disable bold font style for comments.
highlight Comment cterm=NONE
