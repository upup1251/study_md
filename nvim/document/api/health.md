[toc]

vim.health is a minimal(最小的) framrwork to help users troubleshoot(寻找解决问题) configuration and any other environment condition that a plugin(插件) might care about 

> plugin autors are encourage to write new healthchecks.



# commands

`che[ckhealth]`: run all healthchecks


`che[ckhealth] {plugins}`: run healthchecks for one or more plugins


to run healthchecks for Lua submodules(Lua子模块),use `.` or `*` to refer to all submodules.

# create healthchecks 

to add a new healthchecks for your own plugin
- simply create a `health.lua` module on **runtimepath** to return a table with a "check()" function
- the the `:checkhealth` will automatically find and invoke(执行) the function



function for healthcheck 
`vim.health.error({msg},{...})`: report an error
- `{meg}`: (string)
- `{...}`: (string|string[]) optioan advice

`vim.health.info({msg})`: report an information mwssage
- `{msg}`: (string)

`vim.health.ok({msg})`: report a "success" message
- `{msg}`: (string)

`vim.health.start({name})`: starts a new report
- `{name}`: (string)

`vim.health.warn({msg},{...})`: report a warning 
- `{msg}`: (string)
- `{...}`: (string|string[]) optional advice



