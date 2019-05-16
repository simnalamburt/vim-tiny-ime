" Prevent it from being loaded twice
if exists('g:loaded_tiny_ime')
  finish
endif
let g:loaded_tiny_ime = 1

if !exists('g:tiny_ime_default')
  let g:tiny_ime_default = 'ABC'
endif

" Verify that the build is complete
let s:tiny_ime_dir = expand('<sfile>:p:h:h')
if !executable(s:tiny_ime_dir.'/set-ime')
  echo 'vim-tiny-ime: You have to run the following command to complete install of vim-tiny-ime.'
  echo ' '
  echo '    $ '.s:tiny_ime_dir.'/build'
  echo ' '
  finish
endif

" Register 'set-ime' to the autocommands
augroup tiny_ime
  autocmd!
  autocmd InsertLeave * silent! execute '!'.s:tiny_ime_dir.'/set-ime '.g:tiny_ime_default
augroup END
