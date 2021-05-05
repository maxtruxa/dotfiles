""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Styling

" Highlight the current line.
highlight CursorLine cterm=NONE ctermbg=235 ctermfg=NONE guibg=NONE guifg=NONE
autocmd BufEnter * setlocal cursorline
autocmd WinEnter * setlocal cursorline
autocmd BufLeave * setlocal nocursorline
autocmd WinLeave * setlocal nocursorline

" Hyper doesn't properly support cursor styles, so just use a block.
set guicursor=a:block
