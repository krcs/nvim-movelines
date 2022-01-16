# nvim-movelines

Neovim lua plugin for moving lines in normal and visual mode.

For vim-script version see:
- https://github.com/krcs/vim-movelines.git

### Installation

Copy `movelines.lua` into `~/.config/nvim/lua`.

For normal mode call `MoveNormal(direction)`.
For virtual mode call `MoveVisual(direcion)`.

`direction` - Up,Down,Left,Right, words or only the first letter.

In the `init.vim` file insert following lines to map keys.
I am using Alt+[cursor key]:

```
lua require('movelines.lua')

nnoremap <silent> <A-k> :call MoveNormal("u")<CR>
nnoremap <silent> <A-j> :call MoveNormal("d")<CR>
nnoremap <silent> <A-h> :call MoveNormal("l")<CR>
nnoremap <silent> <A-l> :call MoveNormal("r")<CR>

xnoremap <silent> <A-k> :call MoveVisual("Up")<CR>
xnoremap <silent> <A-h> :call MoveVisual("left")<CR>
xnoremap <silent> <A-l> :call MoveVisual("Right")<CR>
xnoremap <silent> <A-j> :call MoveVisual("down")<CR>
```

### License
Same as Neovim. See `:h license`
