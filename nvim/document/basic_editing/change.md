this file describes command that delete or change text 
change text means deleting the text and replace it with other text using one command 
a"" the command can be undo
can redo the non-Ex command with '.' command


1. deleting text 

`X`: delete char before the cursor
`D`: delete to end

`gJ`: join line without insert any space
> with join done,the mark `[` will set to the start of the joined line,`]` to the end



2. delete and insert


3. simple changes


CTRL-A          Add [count] to the number or alphabetic character at
            or after the cursor.

{Visual}g CTRL-A    Add [count] to the number or alphabetic character in
            the highlighted text. If several lines are
                highlighted, each one will be incremented by an
            additional [count],will make it increase

> `CTRL-X` is reverse(相反)


{Visual}[count]<    Shift the highlighted lines [count]



4. complex changes

- filter

A filter is a program that accepts text as stand input ,change it in some way ,then return it 

!{motion}{filter}   Filter {motion} text lines through the external
            program {filter}.

!!{filter}      Filter [count] lines through the external program
            {filter}.

={motion}       Filter {motion} lines through the external program
            given with the 'equalprg' option. 

Nvim uses temporary files for filtering and generating diffs.On exit,
Nvim deletes the tempdir and its contents.

- substitute

:[range]s[ubstitute]/{pattern}/{string}/[flags] [count]
            For each line in [range] replace a match of {pattern}
            with {string}.
> When [range] and [count] are omitted, replace in the
            current line only.  When [count] is given, replace in
            [count] lines, starting with the last line in [range].
            When [range] is omitted start in the current line.

<!-- TODO: detailed to see :help -->

- change tab

:\[range]ret\[ab]\[!] \[new_tabstop]
            Replace all sequences of white-space containing a
            <Tab> with new strings of white-space using the new
            tabstop value given.  If you do not specify a new
            tabstop size or it is zero, Vim uses the current value
            of 'tabstop'.

        hell



5. copy and move text

v_p:        will replace the selected text

:reg[isters]		Display the type and contents of all numbered and
            			named registers.
> "c"	for characterwise text
> "l"	for linewise text
> "b"	for blockwise-visual text

["x]gP			Just like "P", but leave the cursor just after the new
           text.

]p       Like "p", but adjust the indent to the current line.

- `"`: default register
- `0-9`: the 0 register store recent yank;1-9 store the recent delete or change ;
- `-`: store the text deleted less than one line
- `:/./%/#`: recent commandline/recent insert text/current filename/alternate file
- `/`: recent search pattern
- `_`: temp
- `=`: store expresssion outcome
- `*/+`: system cutboard



6. formatting text 


:\[range]ce\[nter] \[width]
:\[range]ri\[ght] \[width]
:\[range]le\[ft] \[indent]
                set the align


:gq     typeset(排版) the target with option `textwith`

gw{motion}		Format the lines that {motion} moves over.  Similar to
			gq but puts the cursor back at the same position in
			the text.




7. sort text

Vim has a sorting function and a sorting command.  The sorting function can be
found here: sort(), uniq().
							:sor :sort
:[range]sor[t][!] [b][f][i][l][n][o][r][u][x] [/{pattern}/]
			Sort lines in [range].  When no range is given all
			lines are sorted.
