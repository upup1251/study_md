
:as\[ci]/ga			Print the ascii value of the character under the
gx			Opens the current filepath or URL 

:norm\[al]\[!] {commands}	    Execute Normal mode commands {commands}.

:te\[rminal]\[!] [{cmd}]	Run {cmd} in a non-interactive 'shell' in a new
			terminal-emulator buffer. Without {cmd}, start an
			interactive 'shell'.

:!{cmd}			Execute {cmd} with 'shell'.
:!!			Repeat last ":!{cmd}".

:command /pattern   filter the output of command with regex expression
:verbose [count] {command}  lookup the detail of {command}
:silent [!] {command}       carry out(执行) {command} without normal message output
> with [!] ,the error message will not output



\[count]K		Runs the program given by 'keywordprg' to lookup the
			word (defined by 'iskeyword') under or right of the
			cursor. Default is "man".

\[N]gs/\[N]sl\[eep]:        Do nothing for [N] seconds, or [N] milliseconds if [m] was given. 
