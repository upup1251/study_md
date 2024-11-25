~/study_md/nvim/plugins/lazynvim.md

lazy.nvim is a modern plugin manager for Neovim.

1. installation

see [🛠️ Installation](https://lazy.folke.io/installation)


# plugin spec(插件规范)

1. spec Source(来源规范)

a valid spec should define one of `[1]`,`dir` or `url`

| property | type | description |
| --------------- | --------------- | --------------- |
| \[1] | string? | short plugin(will be expand using 'config.git.url_format') |
| dir | string? | a directory pointing to a local plugin |
| url | string? | a custom git url where the plugin is hosted |
| name | string? | a custom name for the plugin used for the local plugin directory |
| dev | boolean? | when true,a local plugin directory will be used instead of online|


2. spec loading(加载属性规范)

| property | type | description |
| --------------- | --------------- | --------------- |
| dependencies | LazySpec[ ] | a list of plugin name or plugin specs that should be loaded when the plugin loads.dependencies always Lazy-Loaded unless use'priority' |
| enabled | boolean? or fun():boolean | whether load  |
| cond | boolean? or fun(LazyPlufin):boolean | like 'enabled',but will not uninstall plugins when value=false |
| priority | number? | only useful for plugin which set 'lazy=false',point the loading order(default is 50) |


3. spec setup (初始化规范)


| property | type | description |
| --------------- | --------------- | --------------- |
| init | fun(LazyPlugin) | executed during neovim start |
| opts | table or fun(LazyPlugin,opts:table) | will be passed to the 'Plugin.config()' function as params for futher handle(处理) |
| config | function(LazyPlugin,opts:table) or true | executed when the plugin loads.will automatically run 'require(MAIN).setup(opts)' if 'opts' or 'config=treu' is set. | 
| main | string? | mannual specify the main module to use for config() and opts() |
| build | fun(LazyPlugin) or string or false or a list of build commands | is executed when a plugin is installed or updated |


4. spec lazy loading

| property | type | description |
| --- | ---  | --- |
| lazy | boolean? | when 'true',the plugin will only load when needed |
| event | string?... | lazy-load on event |
| cmd | string?... | lazy-load on command |
| ft | string?... | on filetype |
| keys | string?... | on key mapping |



5. spec advanced

| property | type | description |
| --- | --- | --- |
| optional | boolean? |  when a spec is marked optional,it will only be included in the final spec,when the same plugin has been specified at least once somewhare else without 'optional' |
| specs | LazySpec | a list of plugin specs defied in the scope of the plugin |
| module | false? | do't automatically load this lua module when it's required somewhere |
| import | string? | import the given spec module |



6. spec versioning

| property | type | description |
| --- | --- | --- | 
| branch | string? | branch of the repository |
| tag | string? | tag of the repository |
| commit | string? | commit of the repository |
| version | string? or false to override the default | version to use from the repository |
| pin | boolean? | when true,will not updates it |
| submodules | boolean? | when false,git submodules will not be fetch.default to true|


# lazy loading

mean: lazy.nvim automatically lazy-loads Lua modules.

plugins will be lazy-loaded when one of following is 'true':
- the plugins only exixts as a dependenciy in your spec 
- it has an 'event','cmd','ft' or 'keys' key 
- config.defaults.lazy == true


## lazy key mappings 

the `key` property can be a `string` or `string[]` for simple-mode mappings,or a `LazyKeySpec` table with follow key-value pairs:
- [1]:(string) Ihs(required)
- [2]:(string|fun()) rhs(optional)
- mode:(string|string[])mode(optional,default to `n`)
- ft:(string|string[])`filetype` for buffer-local keymaps(optional)
- any other option valid for `vim.keymap.set`




# satrt step

lazyhi
lazy.nvim change the neovim packages,it takes over the complete startup steps of neovim.

at the step 10 of 'neovim initialization',lazy will start work

1. all the plugin `init()` function are executed
2. all plugins with `lazy=false` are loaded 
3. all files from `/plugin` adn `/ftdetect` under runtime path are sourced 
4. all `/after/plugin` files are sourced.




# configuration

see [configuration](https://lazy.folke.io/configuration)


