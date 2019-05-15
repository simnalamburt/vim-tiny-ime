if exists('g:loaded_tiny_ime')
    finish
endif
let g:loaded_tiny_ime = 1

if !exists('g:tiny_ime_normal_ime')
    let g:tiny_ime_normal_ime = 'U.S.'
endif

if !exists('g:tiny_ime_cjk_ime')
    let g:tiny_ime_cjk_ime= 'Squirrel'
endif

if !exists('g:tiny_ime_cjk_default_english')
    let g:tiny_ime_cjk_default_english = (g:tiny_ime_cjk_ime == "Squirrel")
endif

if !exists('g:tiny_ime_auto_detect')
    let g:tiny_ime_auto_detect = 1
endif

if !exists('g:tiny_ime_binary_dir')
    let g:tiny_ime_binary_dir = expand('<sfile>:p:h:h')
endif
let s:tiny_ime_binary = g:tiny_ime_binary_dir . "/set-ime"

if findfile('set-ime', g:tiny_ime_binary_dir) == ""
    echo 'vim-tiny_ime: ' . s:tiny_ime_binary . ' is not found'
    echo 'vim-tiny_ime: Forgotten to run make?'
    finish
endif

function s:switch_normal_ime()
    call s:switch_ime(g:tiny_ime_normal_ime)
endfunction

function s:switch_cjk_ime(cjk_mode)
    call s:switch_normal_ime()
    " Press Command-Space
    silent !echo "tell application \"System Events\"\n
                 \    keystroke \" \" using {command down}\n
                 \end tell" | osascript
    " If default english but we want cjk mode, press shift.
    " If default cjk but we want english mode, press shift.
    if a:cjk_mode == g:tiny_ime_cjk_default_english
        call s:press_shift()
    endif
endfunction

function s:switch_ime(ime)
    execute "silent !" . s:tiny_ime_binary . " '" . a:ime . "' > /dev/null"
endfunction

function s:press_shift()
    silent !echo "tell application \"System Events\"\n
                 \    key down shift\n
                 \    key up shift\n
                 \end tell" | osascript
endfunction

function s:insert_entered()
    if g:tiny_ime_auto_detect
        let l:char = getline('.')[col('.') - 2]
        let l:cjk_mode = l:char >= "\x80"
    else
        let l:cjk_mode = 1
    endif
    call s:switch_cjk_ime(l:cjk_mode)
endfunction

function s:insert_leave()
    call s:switch_normal_ime()
endfunction

autocmd InsertEnter * :call s:insert_entered()
autocmd InsertLeave * :call s:insert_leave()
