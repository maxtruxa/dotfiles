" More ideas:
" https://gist.github.com/subfuzion/7d00a6c919eeffaf6d3dbf9a4eb11d64

" Source modularized vim config.
for fpath in split(globpath(stdpath('config') . '/init.vim.d/', '*.vim'), '\n')
  execute 'source' fpath
endfor
