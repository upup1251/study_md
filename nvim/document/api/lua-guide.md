this guide is thought as a survival kit--the minium needed to know to get stared on using lua in neovim.

This API consists of three different layers:

1. The "Vim API" inherited from Vim
- Ex-commands and builtin-functions: `vim.cmd()`
- user-functions in Vimscript: `vim.fn` 

2. The "Nvim API" written in C for use: `vim.api`

3. The "Lua API" wirrten in and specifically for lua: `vim.*`
> the `*` is not mentioned before

#  using lua


To run Lua code from the Nvim command line, use the :lua command:
```lua
:lua print("hello!")
```

- each :lua command has its own scope and variables declared with the local keyword are not accessible outside of the command.

You can also use :lua=, which is equivalent to :lua vim.print(...)

To run a Lua script in an external file, you can use the :source command
```lua
:source ~/programs/baz/myluafile.lua
```


# using vim command and function from lua

All Vim commands and functions are accessible from Lua.

1. vim command

To run an arbitrary Vim command from Lua, pass it as a string to `vim.cmd()`

2. vim functions 

Use `vim.fn.function_name()` to call Vimscript functions from Lua.
- Data types between Lua and Vimscript are automatically converted
- This works for both builtin-functions and user-functions.

note that the symbol "#" is valid char identifiers in lua,so we can only call function contain "#" using 
```lua
vim.fn['my#autoload#function']()
```

3. variables

- vim.g: global variables (g:)
- vim.b: variables for the current buffer (b:)
- vim.w: variables for the current window (w:)
- vim.t: variables for the current tabpage (t:)
- vim.v: predefined Vim variables (v:)
- vim.env: environment variables defined in the editor session


4. options

There are two complementary(互补的) ways of setting options via Lua.

- vim.opt

The most convenient way for setting global and local options, e.g., in init.lua,is through vim.opt and friends:
vim.opt: behaves like :set
vim.opt_global: behaves like :setglobal
vim.opt_local: behaves like :setlocal


- vim.o 

a more direct variable-like access using vim.o and friends, similarly to how you can get and set options via :echo &number and :let &listchars='space:_,tab:>~':
vim.o: behaves like :set
vim.go: behaves like :setglobal
vim.bo: for buffer-scoped options
vim.wo: for window-scoped options (can be double indexed)




# mappings

You can map either Vim commands or Lua functions to key sequences.

1. creating mappings

Mappings can be created using `vim.keymap.set()`. This function takes three mandatory arguments:
- {mode} is a string or a table of strings containing the mode prefix for which the mapping will take effect. The prefixes are the ones listed in :map-modes, or "!" for :map!, or empty string for :map.
- {lhs} is a string with the key sequences that should trigger the mapping.
- {rhs} is either a string with a Vim command or a Lua function that should be executed when the {lhs} is entered. An empty string is equivalent to <Nop>, which disables a key.


2. remove mappings

A specific mapping can be removed with `vim.keymap.del()`

# autocommands

Autocommands are created using vim.api.nvim_create_autocmd(), which takes two mandatory arguments:
- {event}: a string or table of strings containing the event(s) which should trigger the command or function.
- {opts}: a table with keys that control what should happen when the event(s) are triggered.



3. del autocommands
You can use `vim.api.nvim_clear_autocmds()` to remove autocommands. 
This function takes a single argument that is a table of keys describing the autocommands that are to be removed

2. group autocommands

Autocommand groups can be used to group related autocommands together;

This is useful for organizing autocommands and especially for preventing autocommands to be set multiple times.

# user commands

user-commands are custom Vim commands that call a Vimscript or Lua function.

Just like built-in commands, they can have arguments, act on ranges, or have custom completion of arguments.


1. create use command

User commands can be created via `nvim_create_user_command()`. This function
takes three mandatory(强制) arguments:
- a string that is the name of the command 
> which must start with an uppercase letter to distinguish it from builtin commands);
- a string containing Vim commands or a Lua function that is executed when the command is invoked;
- a table with command-attributes; in addition, it can contain 
    - the keys desc (a string describing the command); 
    - force (set to false to avoid replacing an already existing command with the same name)
    - preview (a Lua function that is used for :command-preview).


2. call user command

Lua functions are called with a single table argument containing arguments and modifiers. The most important are:
- name: a string with the command name
- fargs: a table containing the command arguments split by whitespace (see <f-args>)
- bang: true if the command was executed with a ! modifier (see <bang>)
- line1: the starting line number of the command range (see <line1>)
- line2: the final line number of the command range (see <line2>)
- range: the number of items in the command range: 0, 1, or 2 (see <range>)
- count: any count supplied (see <count>)
- smods: a table containing the command modifiers (like -r/--rule,see <mods>)

