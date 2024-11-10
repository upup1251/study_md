Command-line mode is used to enter Ex commands (":"), search patterns ("/" and "?"), and filter commands ("!").

# command-line edit

\<S-Left> or \<C-Left>		cursor one WORD left

\<S-Right> or \<C-Right>	cursor one WORD right

CTRL-B      cursor to beginning of command-line
CTRL-E      cursor to end of command-line.

CTRL-W		Delete the word before the cursor.
CTRL-U		Remove all characters between the cursor position and the beginning of the line.



# command-line completion


# Ex commmand-lines

# Ex command-line ranges

Some Ex commands accept a line range in front of them.  This is noted as [range].  It consists of one or more line specifiers, separated with ',' or ';'.

specifiers can be:
- 绝对行号：指定行号，如 3、5 等。
- .：当前行。
- $：文件的最后一行。
- %：整个文件，相当于 1,$。
- 标记：'t（小写）表示标记 t 的位置，'T（大写）表示标记 T 的位置。
- 搜索模式：/pattern/ 和 ?pattern? 用于匹配行。


# Ex command-line flags

# Ex special char

speical char:
- %：代表当前文件名。
- #：代表当前窗口的备用文件名。
- #n：代表缓冲区n的文件名。
- ##：代表参数列表中的所有文件名，名称之间用空格分隔。
- #<n：代表第n个旧文件名。

filename decorate(修饰) suffix(后缀)

- filename:p：将文件名转换为完整路径。
- filename:h：获取文件名的头部。
- filename:t：获取文件名的尾部（最后一个组件）。
- filename:r：去除文件名的扩展名。
- filename:e：获取文件名的扩展名。


# command-line window

In the command-line window the command line can be edited just like editing text in any window.

`q:`: open command-line window
`q?`/`g/`: open string search history

\<CR>		Execute the command-line under the cursor.
CTRL-C		Continue in Command-line mode.
:quit		Discard the command line and go back to Normal mode.




