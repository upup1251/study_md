

[toc]



where is the cursor?  
we can use `CTRL-G` or enable the option `ruler`(show the cursor position in the status line)

with option `virtualedit`,we can go to the place where is no character

# motions and operatiors

1. operator

the following operatiors are available:
`c`: change
`d`: delete
`y`: yank into register

`>`: shift right
`<`: shift left

`zf`: define a fold

`g@`: call function set with the option `operatorfunc`
> the value of `operatorfunc` if a function name
`!`: filter through an external program


`~`: swap case(大小写)(only enable option `tildeop`)
`g~`: swap case
`gu`: lower case
`gU`: upper case

`=`: filter through option `equalprg`(C-indenting if empty)
> `equalprg`:设置格式化工具
`gq`: text formatting(decided by option `textwidth`)
`gw`: text formatting with no cursor movement compare to `gq`

`g?`: rot13 encoding.add 13 to ascii for every alpha,x2 will recover


2. motion-count-multiplied(相乘)

num1 operator num2 motion = num1·num2 motion


3. operator x2

like `operator+operator`,then the seconed `operator` will become the `motion`,represent(代表) current all-line
> also there has 'num1 operator num2 operator'


4. operator-result-curosr-position

after done a operator,the position of cursor is mostly at the left of start of the operated-object


5. motion's affect scope(影响范围)

- linewise: motions between lines affect lines
- charwise: motions within a line affect characters
    - inclusive(包容性): the start and end position of the motion are included in the operator
    - exculusive(排他性): the last character whill not included


which motions are linewise,inclusive,exculusive is mentioned with the command.but there are two exceptions(特例):
- if the motion is exculusive + the end of the motion is in colunm 1 = the end of motion will moved to the end of previous line and the motion becomes inclusive.
- the motion is exculusive + the end of the motion is in colunm 1 + the start of the motion at or before the first non-blank(非空白) in the line  = the motion will becomes linewise.


> note:when the operator is pending(待处理)(waiting for motion),a special set of mapping can be used(`:omap`).


command motion   
can use a `:` command substitute for(代替) motion,like 'd: call search("f")<CR>"

> if the command is morethan one line,this will can't be repeat with `.`

6. change the affect scope

`operator`+`v/V/CTRL-V`+`motion`: this will like `v/V/CTRL-V`+`motion`+`operator`

- `v`
    - operator: work charwise
    - motion 
        - linewise -> exculusive
        - charwise -> toggle inclusive/exculusive

- `V`: work linewise
- `CTRL-V`: work like visual block mode selection


# left-right motions

move the cursor to the specified column in the current line.

`h` = `<left>` = `<CTRL-H>` = `<BS>`(退格键)(all are exculusive)
`l` = `<right>` = `<space>`(all are exculusive)

`0`: to the first character of the line(exculusive)
`^`: to the first non-blank character of the line(exculusive),ignore [count]
> when enable option `wrap`(换行),screen line work
`g0`: to the first character of the screen line(exculusive)
`g^`: to the firast non-blank character of the screen line(exculusive)
`gm`: to half the screenwidth
`gM`: to half the text of the line

`$`: To the end of the line.  When a count is given also go [count - 1] lines downward(inclusive)
`g$`: To the last character of the screen line and [count - 1] screen lines downward (inclusive)
`g_`: To the last non-blank character of the line and [count - 1] lines downward (inclusive)

`|`: to screen column [count] in the line(exculusive)


`f{char}`: to [count]'th {char} right towards,(inclusive)
`f{char}`: to [count]'th {char} left towards,(exculusive)

`t{char}`: till before [count]'th {char} right towards,(inclusive)
`T{char}`: till after [count]'th {char} left towards,(exculusive)

`;`: repeate lastest `f`,`t`,`F` or `T` [count] times
`'`: repeate lastest `f`,`t`,`F` or `T` in opposite direction [count] times



# up-down motions


`k` = `<up>` = `<CTRL-P>`: [count] lines upward(linewise)
`j` = `<down>` = `<CTRL-J>` = `<NL>`(new line换行键) = `<CTRL-N>`: [count] lines downward(linewise)

`gk` = `g<up>`: [count] display lines upward(exculusive)
`gj` = `g<down>`: [count] display lines downward(exculusive)

`-`: [count] lines upward,on the first non-blank character(linewise)
`+` = `CTRL-M` = `<CR>`: [count] lines downward,on the first non-blank character(linewise)
`_`: [count]-1 lines downward, on the first non-blank character (linewise)

`G`: Goto line [count] on the first non-blank character(linewise)
> default last line
`gg`: Goto line [count],on the first non-blank character(linewise)
> default first line

`:[range]`:
- 如果你给出一个行号范围 [range]，光标会移动到该范围的最后一行([range] 可以是单行号)
- 在 Ex 模式下（即通过 Q 或者 :visual 进入 Ex 模式），会打印出指定范围内的行。
- 与G 命令不同，这个命令不会修改跳转列表（jumplist），即无法通过 Ctrl-o 和 Ctrl-i 来跳回。


`{count}%`: go to {count} percentage in the file,on the first non-blank in line(linewise)
> ({count} * 文件行数 + 99) / 100

`"[range]go[to]/go [count]`: 
- :go 或 :goto 命令可以让你根据字节偏移（byte offset）来跳转
- [count] 指的是跳转到文件中的第 [count] 个字节。
> 默认情况下，如果你不指定 [count]，count=1。
- 当你指定了 [range] 时，它会使用范围中的最后一个数字作为字节数进行跳转。



# word motions


1. word and WORD

word: consists of a seris of letters,digits and underscores(下划线)
> we can change with the option `sikeyword`

WORD: consists of a seris of non-blank characters,swparated with white space

> a empty line is comsidered to be word and WORD


2. word motion

`<S-right>` = `w`: [count] words forward(exculusive)
`<C-right>` = `W`: [count] WORDS forward(exculusive)

`e`: forward to the end of word [count] (inclusive)
> will not stop in an empty line
`E`: forward to the end of WORD [count] (inclusive)


`<S-Left>` = `b`: [count] words backward(exculusive)
`<C-Left>` = `B`: [count] WORDS backward(exculusive)

`ge`: backward to the end of word [count] (inclusive)
`gE`: backward to the end of WORD [count] (inclusive)


# text object motions

<!-- TODO: don't clear -->

1. define

- sentence 
a sentence is defined as ending at a '.','!','?' followed by either the end of a line,or by a space or tab.

- paragraph: begin after each empty line


2. command


`(/)`: [count] sentences backward/forward(exculusive)

`{/}` [count] paragraphs backward/forward(exculusive)

`]]`: [count] sections forward or to the next "{" in the first column.When used after an operator,then stop below a "}" in the first cloumn

`][`: [count] sections forward or to the next "}" in the first cloumn

`[[`: [count] sections backward or to the previous "{" in the first cloumn

`[]` [count] sections backward or to the previous "}" in the first cloumn





# text object selection

(helelb fjj
only be used while in Visual mode or after an operator.

- start with "a" select "a"n object including white space
- the commands starting with "i" select an "inner" object without white space, or just the white space. 
> Thus the "inner" commands always select less text than the "a" commands.


a/ib			"a block", select [count] blocks, from "[count] [(" to
			the matching ')', including the '(' and ')' (see
			[(). 


# marks 

Jumping to a mark can be done in two ways:
1. With (backtick): goto the specified location (exclusive).
2. With ' (single quote): goto the first non-blank character in the line of the specified location (linewise).


## command

m'  or  m`		Set the previous context mark.  This can be jumped to
			with the "''" or "``" command 

m<  or  m>		Set the '< or '> mark.  Useful to change what the
			gv command selects.
> `gv` will select the selection last selected


g'{mark}  g`{mark}
			Jump to the {mark}, but don't change the jumplist when
			jumping within the current buffer.


:marks			List all the current marks
> The '(, '), '{ and '} marks are not listed


'0 -'9: when you exits vim,the position of existed file will be remember in '0,the 1,2...9 is older existed file position



lower case letter marks 'a - 'z
upper case letter marks 'A - 'Z
numbered marks '0 - '9
last insert position '^
last change position '.
last affected text area '\[ and '\]
> affected like delete and replace ...
the Visual area '< and '>


# jumps 

## jump_list

A "jump" is a command that normally moves the cursor several lines away.

CTRL-O			Go to [count] Older cursor position in jump list
\<Tab>/CTRL-I		Go to [count] newer cursor position in jump list
:ju[mps]		Print the jump list (not a motion command).


## change_list

g;			Go to [count] older position in change list.
g,			Go to [count] newer position in change list.
:changes		Print the change list.



# various motion 

%			Find the next item in this line after or under the
			cursor and jump to its match.Items can be:([{}])

[(			Go to [count] previous unmatched '('.
[{			Go to [count] previous unmatched '{'.
])			Go to [count] next unmatched ')'.
]}			Go to [count] next unmatched '}'.
]m			Go to [count] next start of a method (for Java or
			similar structured language). 
]M			Go to [count] next end of a method
[m			Go to [count] previous start of a method 
[M			Go to [count] previous end of a method

[#			Go to [count] previous unmatched "#if" or "#else".
]#			Go to [count] next unmatched "#else" or "#endif".
[*  or  [/		Go to [count] previous start of a C comment "/*".
]*  or  ]/		Go to [count] next end of a C comment "*/".

H			To line [count] from top (Home) of window
M			To Middle line of window
L			To line [count] from bottom of window


![](assets/vimKey.png)
