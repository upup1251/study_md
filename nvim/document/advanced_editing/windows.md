# introduction 

Summary:
   A buffer is the in-memory text of a file.
   A window is a viewport on a buffer.
   A tab page is a collection of windows.

A buffer is a file loaded into memory for editing.  The original file remains unchanged until you write the buffer to the file.

A buffer can be in one of three states:
- active: The buffer is displayed in a window.
- hidden: The buffer is not displayed.
- inactive: The buffer is not displayed and does not contain anything.


# starting vim

start vim with the argu `-o{N}/-O{N}` will take {N} horizontal split or vertical split window

statusline

A status line will be used to separate windows.  The 'laststatus' option tells when the last window also has a status line:
	'laststatus' = 0	never a status line
	'laststatus' = 1	status line if there is more than one window
	'laststatus' = 2	always a status line
	'laststatus' = 3	have a global statusline at the bottom instead of one for each window

> change the contents of the status line with the 'statusline' option.

# open and close a window



:[N]sp[lit] [++opt] [+cmd] [file] /CTRL-s   Split current window in two.  The result is two viewports on the same file.
- Make the new window N high 
- If [file] is given it will be edited in the new window.

:[N]sp[lit] [++opt] [+cmd] [file] /CTRL-s      Like :split, but split vertically. 

:[N]new [++opt] [+cmd] [file]/CTRL-n       Create a new window and start editing an empty file in it.

CTRL-W ^	Split the current window in two and edit the alternate file.



:q[uit]/CTRL-W q        		Without {count}: Quit the current window.  If {count} is given quit the {count} window. 

:clo[se]CTRL-W c					CTRL-W_c :clo :close Without {count}: Close the current window. If given close the {count} window.

:hid[e]/:{count}hid[e]          Without {count}: Quit the current window, unless it is the last window on the screen.

:on\[ly][!]/CTRL-W o			 Make the current window the only one on the screen. All other windows are closed.


# move cursor to other window


CTRL-W h/j/k/l: move to left,down,up,right window
CTRL-W w: move to 'foucusable' window
> such like notcie plgin window

CTRL-W t: move to top-left window
CTRL-W b: move to botton-right window

CTRL-W p: goto previous window
CTRL-W P: goto preview window

'CTRL-W [count] {arg}' = ':wincmd [count] {atg}'


# moving windows around

CTRL-W r    	Rotate windows downwards/rightwards.
CTRL-W R	    Rotate windows upwards/leftwards.
CTRL-W x        Exchange current window with next one.

CTRL-W K	    Move the current window to be at the very top, using 
                the full width of the screen.
CTRL-W J	Move the current window to be at the very bottom
CTRL-W H	Move the current window to be at the far left
CTRL-W L	Move the current window to be at the far right
CTRL-W T	Move the current window to a new tab page


CTRL-W =	Make all windows (almost) equally high and wide,
:res[ize] -N/CTRL-W -   	Decrease current window height by N (default 1).
:res[ize] +N/CTRL-W +   	Increase current window height by N (default 1).
:res[ize] [N]/CTRL-W _	    Set current window height to N (default: highest possible).



z{nr}<CR>	Set current window height to {nr}.
CTRL-W <	Decrease current window width by N (default 1).
CTRL-W >	Increase current window width by N (default 1).

# window resize
# argument and buffer list command
# do a command in all buffers or windows
# tag of file name under the cursor
# the previewe window
# using hidden buffers
# special kinds of buffers



