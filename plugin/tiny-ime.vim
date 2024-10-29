" Prevent it from being loaded twice
if exists('g:loaded_tiny_ime')
  finish
endif
let g:loaded_tiny_ime = 1

if !exists('g:tiny_ime_default')
  let g:tiny_ime_default = 'ABC'
endif

let s:tiny_ime_dir = expand('<sfile>:p:h:h')

" Register 'set-ime' to the autocommands
augroup tiny_ime
  autocmd!
  autocmd InsertLeave * silent! execute '!'.s:tiny_ime_dir.'/input-source set --localized-name '.g:tiny_ime_default
augroup END
