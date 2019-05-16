vim-tiny-ime
========
Tiny automatic IME switcher for macOS. Switch to English IME whenever vim switchs
to normal mode.

```vim
" ~/.vimrc
Plug 'simnalamburt/vim-tiny-ime', { 'do' : './build' }
```

## Options

If you want to change the default IME, set `g:tiny_ime_default`.

```vim
let g:tiny_ime_default = 'Colemak'
```

The default value of `g:tiny_ime_default` is `'ABC'`.

<br>

--------

*vim-tiny-ime* is primarily distributed under the terms of the [GNU General
Public License, version 3] or any later version. See [COPYRIGHT] for details.

[GNU General Public License, version 3]: LICENSE
[COPYRIGHT]: COPYRIGHT
