

# special keys



In Insert and Replace mode, the following characters have a special meaning; To insert one of these special characters into the buffer, precede(先于) it with CTRL-V.

CTRL-@		Insert previously inserted text and stop insert.
CTRL-A		Insert previously inserted text.

CTRL-W		Delete the word before the cursor
CTRL-U		Delete all entered characters before the cursor in the cu
            rrent line. 



CTRL-N		Find next keyword for completion(see i_CTRL-N).
CTRL-P		Find previous keyword for completion(see i_CTRL-P).

CTRL-R {register}	Insert the contents of a register.

CTRL-T		Insert one shiftwidth of indent at the start of the curre
            nt line.  
> The indent is always rounded to a 'shiftwidth'.

CTRL-D		Delete one shiftwidth of indent at the start of the curre            nt line

0 CTRL-D	Delete all indent in the current line.
^ CTRL-D	Delete all indent in the current line.  the next line's i
            dent will not change



# special special keys

The following keys are special.  They stop the current insert, do something,and then restart insertion. 

CTRL-O		execute one command, return to Insert mode
CTRL-\ CTRL-O	like CTRL-O but don't move the cursor


# option for text

The 'textwidth' option can be used to automatically break a line before it gets too long.

The 'wrapmargin' option does almost the same.  The difference is that 'textwidth' has a fixed width while 'wrapmargin' depends on the width of the screen. 
> When 'textwidth' and 'wrapmargin' are both set, 'textwidth' is used.

gq：用于格式化文本，调整行的长度，使其符合 textwidth 设置


the 'expandtab' will substitude(代替) \<tab> with \<space>  
enable the 'smarttab',at the start of line,\<tab> will insert 'shiftwidth' width,other place insert 'tabstop' width  
> disable it,always insert 'tabstop',the 'shiftwidth' only for indent(缩进)

the 'softtabstop' value will be used when \<tab> enter and \<BS> enter



# replace mode

Enter Replace mode with the "R" command in normal mode.

in replace mode,one char in the line is deleted for every char you type

If you delete characters in Replace mode (with \<BS>, CTRL-W, or CTRL-U), the change before will drop,the primary text will back.


# vitual replace mode

Enter Virtual Replace mode with the "gR" command in normal mode.

differ to R mode,it will change for the space in the screen,not for char
> good for typeset(排版)


# insert mode completion

In Insert and Replace mode, there are several commands to complete part of a keyword or line that has been typed.

Completion can be done for:
1. Whole lines						            i_CTRL-X_CTRL-L  
2. keywords in the current file				    i_CTRL-X_CTRL-N  
3. keywords in 'dictionary'				        i_CTRL-X_CTRL-K  
4. keywords in 'thesaurus', thesaurus-style	    i_CTRL-X_CTRL-T  
5. keywords in the current and included files	i_CTRL-X_CTRL-I  
6. tags							                i_CTRL-X_CTRL-]  
7. file names						            i_CTRL-X_CTRL-F  
8. definitions or macros				        i_CTRL-X_CTRL-D  
9. Vim command-line					            i_CTRL-X_CTRL-V  
10. User defined completion				        i_CTRL-X_CTRL-U  
11. omni completion					            i_CTRL-X_CTRL-O  
12. Spelling suggestions				        i_CTRL-X_s  
13. keywords in 'complete'				        i_CTRL-N i_CTRL-P

<!-- TODO: to many word for introduce completion -->

