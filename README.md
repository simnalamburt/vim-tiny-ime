vim-osx-ime
========

-   Switch English IME whenever vim switchs to normal mode.
-   When vim switches to insert mode:
    -   If the character before cursor is a Chinese character, switch to Chinese
        IME and put it in Chinese mode.
    -   If the character before cursor is an English character, switch to Chinese
        IME and put it in English mode.
