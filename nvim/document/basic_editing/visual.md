Visual mode is a flexible and easy way to select a piece of text for an operator.  
> It is the only way to select a block of text.

# using visual mode

using visual mode consists of three parts:
- Mark the start of the text with "v", "V" or CTRL-V.
- Move to the end of the text.
- Type an operator command.

the option `hi-Visual` group determine the heighting of visual selection 

the option `virtualedit` set whether the black-area can be selected

the option `selection` set the character under the cursor is included or exclusive

# start and stop visual mode

with [count] before v/V/C-V ,will select the ( last selected number * [count] ) numbers this time

gv			Start Visual mode with the same area as the previous
			area and the same mode.
			In Visual mode the current and the previous Visual
			area are exchanged.

gn			search forward for the last used search pattern, like
with n, and start visual modegn			search forward for the last used search pattern, like
			with n, and start visual mode to select the match. to select the match.



# change the visual area

o			Go to Other end of highlighted text:

o			go to other end of highlighted text.
> in visual block(ctrl-v) mode the cursor moves to the other corner in the same line. 


# operation on the visual area


~	switch case					
!	filter through external command (1)		v_!  
=	filter through 'equalprg' option command (1)	v_=  
gq	format lines to 'textwidth' length (1)		v_gq
:	start Ex command for highlighted lines (1)	v_:  
J	join (1)					v_J  
U	make uppercase					v_U  
u	maheke lowercase					v_u  
I	block insert					v_b_I  
A	block append					v_b_A



# blockwise operator

with blockwise selection,the operator for the first line will happendd for all line

I{string}<ESC> will insert {string} at the start of block on every line of the block

A{string}<ESC> will append {string} to the end of block on every line of the block.

c: All selected text in the block will be replaced by the same text string.
C: like c,but will change to the line end

r: replace all line
\>: shift all line

# repeating

When repeating a Visual mode operator, the operator will be applied to the same amount of text as the last time

hello
456(world)654
456(NOT THIS)654

# select mode

with select mode selected,the input will change current selection,and stop into insert mode.


gh: char select 
gH: line select
g_CTRL-H: block select
