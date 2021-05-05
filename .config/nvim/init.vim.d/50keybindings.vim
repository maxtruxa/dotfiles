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

" Delete buffer.
nnoremap <silent> <leader>bd :Bdelete<CR>

" Delete buffer, discarding any changes.
nnoremap <silent> <leader>bD :bdelete!<CR>

" Wipe-out buffer.
nnoremap <silent> <leader>bw :Bwipeout<CR>

" Wipe-out buffer, discarding any changes.
nnoremap <silent> <leader>bW :Bwipeout!<CR>

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
