
# fold methods

The folding method can be set with the 'foldmethod' option.

when set 'foldmethod' from "manual" to a other value ,all folds deleted and new ones craeted  
but set from other to "manual",the existing folds will not removed

There are six methods to select folds:
	manual(手动)		manually define folds
	indent(缩进)		more indent means a higher fold level
	expr(正则表达式)		specify an expression to define folds
	syntax		folds defined by syntax highlighting
	diff		folds for unchanged text
	marker		folds defined by markers in the text


## manual

use 'fole command' to manually define the fold regions

when quit file,the manual folds will lose,to save the folds by `:mkview` command,load the folds by `"loadview`
> 使用view保存手动折叠



## indent

the folds are automatically defined by the indent of the lines

# fold command

all folding command start with "z"


## creating and delete folds

> This only works when 'foldmethod' is "manual" or "marker".

- `zf{motion}/{Visual}zf`: Operator to create a fold.
- `zF`: Create a fold for [count] lines.  Works like "zf".
- `:{range}fo[ld]`: Create a fold for the lines in {range}.  Works like "zf".

- `zd`: Delete one fold at the cursor.
- `zD`: delete folds recursivel(递归) at the cursor
- `zE`: Eliminate(消除) all folds in current window


## opening and closing folds

a fold smaller than the option 'foldminlines'(最小折叠行) always open.

- `zo`		Open one fold under the cursor. 
>  When a count is given, that many folds deep will be opened. 
- `zO`		Open all folds under the cursor recursively(递归).

- `zc`		Close one fold under the cursor.  
> When a count is given, that many folds deep are closed.
- `zC`		Close all folds under the cursor recursively.


- `za`		Summary: Toggle the fold under the cursor.
- `zA`		When on a closed fold: open it recursively.

- `zn`		Fold none: reset 'foldenable'.  All folds will be open.
- `zN`		Fold normal: set 'foldenable'.  All folds will be as the were before.
- `zi`		Invert 'foldenable'.


## moving over folds

- `[z`		Move to the start of the current open fold.
- `]z`		Move to the end of the current open fold.
- `zj`		Move downwards to the start of the next fold.
- `zk`		Move upwards to the end of the previous fold.


## executing command on folds

- `:\[range]foldd\[oopen] {cmd}`: Execute {cmd} on [range] lines that are not in a closed fold.

- `:[range]folddoc[losed] {cmd}`:: Execute {cmd} on [range] lines that are in a closed fold.
# fold options


## color


- Folded group 'hl-Folded': set the color of a closed fold
- foldcolumn group 'hl-FoldColumn': set the color of the fold column


## foldlevel


- 'foldlevel' is a number option: only the fold nested level (折叠嵌套级数) less than 'foldlevel' will open


## foldtext

- 'foldtext' is a string option that specifies an expression for every fold.

## foldcolumn

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

