


# scrolling downwards


`CTRL-E` scroll window [count] lines downwards in the buffer.

`CTRL-D`: scroll window downwards in the buffer.
- The number of lines downwards comes from the option `count`. 
> default `count` = half a screen
- if [count] is given,will set option `scroll` to [count]

`<S-Down>/<S-CR>/<S-+>/<CTRL-F>`: scroll window [count] pages Forwards in the buffer


`z+`
- without [count]: take the line in the bottom ato the top,and put the cursor in that line
- with [count]: just like `z<CR>`,put the cursor to line [count]

# scrolling upwards


`CTRL-Y`: scroll window [count] lines upwards in the buffer

`CTRL-U`: like `CTRL-D`

`<S-Uo>/<S-->/<CTRL-B>`: scroll window [count] pages backwards in the buffer

`z^`: 

# scrolling relative to cursor

keeping the cursor on the same line.

`z<CR>`: redraw,line [count] at top of window(default cursor line),put cursor at first non-blank
`zt`: like `z<CR>`,but leave the cursor in the same clumn


`z.`: line [count] at center of window(default cursor line),put cursor at first non-blank 
`zz`: like `z.`,but leave the cursor in the same column

`z-`: line [count] at bottom of window(default cursor line),put cursor at first non-blank 
`zb`: like `z-`,but leave the cursor in the same column


`z{height}<CR>`: change the window height = {height}

# scrolling horizontally
# scrolling synchronously
# scrolling with a mouse wheel



































