" Ideas:
" https://gist.github.com/subfuzion/7d00a6c919eeffaf6d3dbf9a4eb11d64

" Make s:xdg_data_home and s:xdg_state_home available to the rest of the script.
let s:xdg_data_home = $XDG_DATA_HOME
if empty(s:xdg_data_home)
  let s:xdg_data_home = $HOME . '/.local/share'
endif
let s:xdg_state_home = $XDG_STATE_HOME
if empty(s:xdg_state_home)
  let s:xdg_state_home = $HOME . '/.local/state'
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins

" Plug (vim-plug) plugin manager
" https://github.com/junegunn/vim-plug
" Remember to run 'PlugInstall' after adding a new plug!

" Auto-install vim-plug and configured plugins if vim-plug isn't installed.
let s:plug_main_script = s:xdg_data_home . '/nvim/site/autoload/plug.vim'
if empty(glob(s:plug_main_script))
  silent execute '!curl -fLo ''' . s:plug_main_script . ''' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Load plugins into $XDG_DATA_DIR/nvim/plugged.
call plug#begin(stdpath('data') . '/plugged')

" NERD Tree - file explorer
" https://github.com/scrooloose/nerdtree
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" nerdtree-git-plugin - show git status in NERD Tree
" https://github.com/Xuyuanp/nerdtree-git-plugin
Plug 'Xuyuanp/nerdtree-git-plugin'

" vim-airline - enhanced statusline
" https://github.com/vim-airline/vim-airline
Plug 'vim-airline/vim-airline'
" https://github.com/vim-airline/vim-airline-themes
Plug 'vim-airline/vim-airline-themes'

" vim-windowswap - mark and swap windows with <leader>ww
" https://github.com/wesQ3/vim-windowswap
Plug 'wesQ3/vim-windowswap'

" Load plugins.
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Configure NERD tree

" Auto start NERD tree when opening a directory.
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | wincmd p | endif

" Auto start NERD tree if no files are specified.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | exe 'NERDTree' | endif

" Let quit work as expected if after entering :q the only window left open is
" NERD Tree itself.
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

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
execute 'set shada=''100,<1000,s100,h,n' . s:xdg_state_home . '/nvim/shada/main.shada'

" Save swap files to a more appropriate place.
" Important: The two trailing spaces are significant! See `:h 'directory'`.
execute 'set directory=' . s:xdg_state_home . '/nvim/swap//'

" Move .netrwhist to cache directory.
let g:netrw_home=s:xdg_state_home . '/nvim'

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Helper functions

highlight HLNextBlink ctermbg=red
"highlight HLNextBlink cterm=reverse

" TODO: How to cancel `sleep` when trying to input more stuff while the function
"       still runs? Check this out: https://vi.stackexchange.com/a/27032
function! HLNext(blinktime)
  let [bufnum, lnum, col, off] = getpos('.')
  let matchlen = strlen(matchstr(strpart(getline('.'), col - 1), @/))
  let target_pat = '\c\%#'.@/
  let blinks = 3
  for n in range(1, blinks)
    let match = matchadd('HLNextBlink', target_pat, 101)
    redraw
    execute 'sleep ' . float2nr(a:blinktime / (2 * blinks) * 1000) . 'm'
    call matchdelete(match)
    redraw
    execute 'sleep ' . float2nr(a:blinktime / (2 * blinks) * 1000) . 'm'
  endfor
endfunction

function! Light()
  echom "set bg=light"
  set bg=light
endfunction

function! Dark()
  echom "set bg=dark"
  set bg=dark
endfunction

function! ToggleLightDark()
  if &bg ==# "light"
    call Dark()
  else
    call Light()
  endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Keybinds

" Shortcut to edit this configuration file:
" (e)dit (c)onfiguration
nnoremap <silent> <leader>ec :e $MYVIMRC<CR>

" Shortcut to source this configuration file after editing it:
" (s)ource (c)onfiguration
nnoremap <silent> <leader>sc :source $MYVIMRC<CR>

" Toggle NERDTree.
nnoremap <silent> <Space> :NERDTreeToggle<CR>

" Toggle line numbers.
nnoremap <silent> <leader>tn :set number! number?<CR>

" Toggle line wrap.
nnoremap <silent> <leader>tw :set wrap! wrap?<CR>

" Toggle buffer (switch between current and last buffer).
nnoremap <silent> <leader>bb <C-^>

" Go to next buffer.
nnoremap <silent> <leader>bn :bnext<CR>
nnoremap <C-l> :bnext<CR>

" Go to previous buffer.
nnoremap <silent> <leader>bp :bprevious<CR>
nnoremap <C-h> :bprevious<CR>

" Close buffer.
nnoremap <silent> <leader>bd :bdelete<CR>

" Kill buffer.
nnoremap <silent> <leader>bD :bdelete!<CR>

" List buffers.
nnoremap <silent> <leader>bl :ls<CR>

" List and select buffer.
nnoremap <silent> <leader>bg :ls<CR>:buffer<Space>

" Horizontal split with new buffer.
nnoremap <silent> <leader>bh :new<CR>

" Vertical split with new buffer.
nnoremap <silent> <leader>bv :vnew<CR>

" Easily mark and swap windows.
let g:windowswap_map_keys = 0 " prevent (deprecated) default keybinds
nnoremap <silent> <leader>ww :call WindowSwap#EasyWindowSwap()<CR>

" Improved keyboard navigation when switching between windows.
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l

" Re-yank any text that is pasted in visual mode.
" See: http://stackoverflow.com/questions/290465/vim-how-to-paste-over-without-overwriting-register
xnoremap <expr> p 'pgv"'.v:register.'y'

" Temporarily disable search highlighting (see 'set hlsearch'). Highlighting is
" re-enabled by performing another search or using 'n' or something similar.
nnoremap <silent> <leader>\ :nohlsearch<CR>

"nnoremap <silent> n n:call HLNext(0.3)<CR>
"nnoremap <silent> N N:call HLNext(0.3)<CR>

" Toggle colors to optimize based on light or dark background.
nnoremap <leader>c :call ToggleLightDark()<CR>

" Map indent/unindent to tab/shift+tab.
vmap <TAB> >gv
vmap <S-TAB> <gv

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Styling

" Theme for vim-airline.
let g:airline_theme='violet'
let g:airline_powerline_fonts = 1
" Show buffers at the top.
let g:airline#extensions#tabline#enabled = 1

" Highlight the current line.
highlight CursorLine cterm=NONE ctermbg=235 ctermfg=NONE guibg=NONE guifg=NONE
autocmd BufEnter * setlocal cursorline
autocmd WinEnter * setlocal cursorline
autocmd BufLeave * setlocal nocursorline
autocmd WinLeave * setlocal nocursorline

" Hyper doesn't properly support cursor styles, so just use a block.
set guicursor=a:block

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filetype specific settings

" While it is nice to split language specific configuration into separate
" files inside the "ftplugin" directory, the additional work required to
" maintain those files is just not worth it when each language has only a
" small amount of custom settings.

" Set filetype based on file extension.
autocmd BufRead,BufNewFile *.ts setfiletype typescript
autocmd BufRead,BufNewFile *.handlebars setfiletype html
autocmd BufRead,BufNewFile *.hbs setfiletype html

" Neovim's "vim.vim" ftplugin sets textwidth to 78.
autocmd FileType vim setlocal textwidth=80

" Identation overrides.
autocmd FileType cpp,lua,python setlocal shiftwidth=4 softtabstop=4 expandtab
" For languages that natively indent using tabs, do so and reset listchars for
" tabs back to spaces.
autocmd FileType go,make,gitconfig setlocal shiftwidth=4 softtabstop=4 tabstop=4 noexpandtab
autocmd FileType go,make,gitconfig setlocal listchars=tab:\ \ ,

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Init

" Set background to dark. This forces better readable colors for the terminal.
" Toggle with <leader>c.
silent call Dark()
