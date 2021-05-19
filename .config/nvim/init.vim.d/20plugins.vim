""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins

" Plug (vim-plug) plugin manager
" https://github.com/junegunn/vim-plug
" Remember to run 'PlugInstall' after adding a new plug!

" Auto-install vim-plug and configured plugins if vim-plug isn't installed.
let s:plug_main_script = g:xdg_data_home . '/nvim/site/autoload/plug.vim'
if empty(glob(s:plug_main_script))
  silent execute '!curl -fLo ''' . s:plug_main_script . ''' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Load plugins into $XDG_DATA_DIR/nvim/plugged.
call plug#begin(stdpath('data') . '/plugged')

" NERDTree - file explorer
" https://github.com/preservim/nerdtree
Plug 'preservim/nerdtree', { 'on':  'NERDTreeToggle' }

" nerdtree-git-plugin - show git status in NERDTree
" https://github.com/Xuyuanp/nerdtree-git-plugin
Plug 'Xuyuanp/nerdtree-git-plugin'

" vim-airline - enhanced statusline
" https://github.com/vim-airline/vim-airline
Plug 'vim-airline/vim-airline'
" https://github.com/vim-airline/vim-airline-themes
Plug 'vim-airline/vim-airline-themes'

" vim-bbye - delete buffers without closing your windows
" https://github.com/moll/vim-bbye
Plug 'moll/vim-bbye'

" vim-windowswap - mark and swap windows with <leader>ww
" https://github.com/wesQ3/vim-windowswap
Plug 'wesQ3/vim-windowswap'

" BufOnly.vim - delete all buffers except for the current one
" https://github.com/vim-scripts/BufOnly.vim
Plug 'vim-scripts/BufOnly.vim'

" Load plugins.
call plug#end()


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Configure NERDTree

" Show hidden files by default.
let NERDTreeShowHidden=1

" Auto start NERDTree when opening a directory.
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | wincmd p | endif

" Auto start NERDTree if no files are specified.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | exe 'NERDTree' | endif

" Let quit work as expected if after entering :q the only window left open is
" NERD Tree itself.
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Configure airline

" Theme for vim-airline.
let g:airline_theme='violet'
let g:airline_powerline_fonts = 1
" Show buffers at the top.
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
