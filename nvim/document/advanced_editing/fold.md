
# fold methods

The folding method can be set with the 'foldmethod' option.

There are six methods to select folds:
	manual(手动)		manually define folds
	indent		more indent means a higher fold level
	expr		specify an expression to define folds
	syntax		folds defined by syntax highlighting
	diff		folds for unchanged text
	marker		folds defined by markers in the text






# fold command

zf{motion}/{Visual}zf	Operator to create a fold.
> This only works when 'foldmethod' is "manual" or "marker".
zF		Create a fold for [count] lines.  Works like "zf".

:{range}fo[ld]   Create a fold for the lines in {range}.  Works like "zf".

zd		Delete one fold at the cursor.
zD      delete folds recursivel(递归) at the cursor
zE      deelte all folds in current window

zo		Open one fold under the cursor. 
>  When a count is given, that many folds deep will be opened. 
zO		Open all folds under the cursor recursively(递归).

zc		Close one fold under the cursor.  
> When a count is given, that many folds deep are closed.
zC		Close all folds under the cursor recursively.


za		Summary: Toggle the fold under the cursor.
zA		When on a closed fold: open it recursively.

zn		Fold none: reset 'foldenable'.  All folds will be open.
zN		Fold normal: set 'foldenable'.  All folds will be as the were before.
zi		Invert 'foldenable'.


\[z		Move to the start of the current open fold.
]z		Move to the end of the current open fold.
zj		Move downwards to the start of the next fold.
zk		Move upwards to the end of the previous fold.

:\[range]foldd\[oopen] {cmd}      Execute {cmd} on all lines that are not in a closed fold.

:[range]folddoc[losed] {cmd}	  Execute {cmd} on all lines that are in a closed fold.
# fold options


The colors of a closed fold are set with the Folded group hl-Folded.

'foldlevel' is a number option: The higher the more folded regions are open.

'foldtext' is a string option that specifies an expression for every fold.

'foldcolumn' is a number, which sets the width for a column on the side of the window to indicate folds. 

'foldenable'  'fen':	Open all folds while not set.
'foldexpr'    'fde':	Expression used for "expr" folding.
'foldignore'  'fdi':	Characters used for "indent" folding.
'foldmarker'  'fmr':	Defined markers used for "marker" folding.
'foldmethod'  'fdm':	Name of the current folding method.
'foldminlines' 'fml':	Minimum number of screen lines for a fold to be
			displayed closed.
'foldnestmax' 'fdn':	Maximum nesting for "indent" and "syntax" folding.
'foldopen'    'fdo':	Which kinds of commands open closed folds.
'foldclose'   'fcl':	When the folds not under the cursor are closed.

# behavior of fold

