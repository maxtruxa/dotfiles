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
