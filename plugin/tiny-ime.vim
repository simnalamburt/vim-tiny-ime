" Prevent it from being loaded twice
if exists('g:loaded_tiny_ime')
  finish
endif
let g:loaded_tiny_ime = 1

" Verify that the build is complete
let tiny_ime_dir = expand('<sfile>:p:h:h')
if findfile('set-ime', tiny_ime_dir) == ""
  echo 'vim-tiny-ime: You have to run the following command to complete install of vim-tiny-ime.'
  echo ' '
  echo '    bash '.tiny_ime_dir.'/build'
  echo ' '
  finish
endif

" Register 'set-ime' to the autocommands
autocmd InsertLeave * silent! execute "!".tiny_ime_dir."/set-ime ABC"
