# single repeats

`.`: Repeat last change, with count replaced with [count]. Does not repeat a command-line command.

`@:`			Repeat last command-line [count] times.


# multiple repeats 

:\[range]g\[lobal]/{pattern}/\[cmd]
			Execute the Ex command \[cmd] (default ":p") on the
			lines within \[range] where {pattern} matches.

# complex repeats


q{0-9a-zA-Z"}		Record typed characters into register {0-9a-zA-Z"}(uppercase to append).


q			Stops recording.

@{0-9a-z".=*+}		Execute the contents of register {0-9a-z".=*+} [count] times.

@@			Repeat the previous @{0-9a-z":*} [count] times.
Q			Repeat the last recorded register [count] times.


# context

The editor state is represented by the Context concept. 

The following Context items are supported:
	"jumps"		jumplist  
	"regs"		registers  
	"bufs"		buffer-list  
	"gvars"		global-variables
	"sfuncs"	script-local functions
	"funcs"		global and script-local functions



