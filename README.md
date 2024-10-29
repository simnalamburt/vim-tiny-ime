vim-tiny-ime
========
Tiny automatic IME switcher for macOS. Switch to English IME whenever vim
switchs to normal mode.

```vim
Plug 'simnalamburt/vim-tiny-ime'
```

vim-tiny-ime is quick and lightweight to run and install, as it uses
[macos-input-source] 0.1.4, which provides a small universal binary.

[macos-input-source]: https://github.com/simnalamburt/macos-input-source

### Options

If you want to change the default IME, set `g:tiny_ime_default`.

```vim
let g:tiny_ime_default = 'Colemak'
```

The default value of `g:tiny_ime_default` is `'ABC'`.

&nbsp;

--------

*vim-tiny-ime* is primarily distributed under the terms of the [GNU General
Public License, version 3] or any later version. See [COPYRIGHT] for details.

[GNU General Public License, version 3]: LICENSE
[COPYRIGHT]: COPYRIGHT
