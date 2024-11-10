<!-- luasnip.md -->



```
           /\ \                     /\  _`\           __
           \ \ \      __  __     __ \ \,\L\_\    ___ /\_\  _____
            \ \ \  __/\ \/\ \  /'__`\\/_\__ \  /' _ `\/\ \/\ '__`\
             \ \ \L\ \ \ \_\ \/\ \L\.\_/\ \L\ \/\ \/\ \ \ \ \ \L\ \
              \ \____/\ \____/\ \__/.\_\ `\____\ \_\ \_\ \_\ \ ,__/
               \/___/  \/___/  \/__/\/_/\/_____/\/_/\/_/\/_/\ \ \/
                                                             \ \_\
                                                              \/_/
```

LuaSnip 是一个完全用 lua 编写的代码片段引擎。

功能：根据用户输入插入文本 (luasnip-function-node) 或节点 (luasnip-dynamic-node)、 解析 LSP 语法和切换节点 (luasnip-choice-node) 等。


假定
```lua
local ls = require "luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require "luasnip.util.events"
local ai = require "luasnip.nodes.absolute_indexer"
local extras = require "luasnip.extras"
local fmt = extras.fmt
local m = extras.m
local l = extras.l
local postfix = require "luasnip.extras.postfix".postfix
```



### 基础

在 LuaSnip 中，代码片段由节点 (nodes) 组成。节点包括：

- textNode：静态文本
- insertNode：可编辑的文本
- functionNode：函数节点，可从其他节点的内容生成的文本
- dynamicNode：动态节点，基于输入生成的节点
- 其他节点
    - choiceNode：在两个节点（或更多节点）之间进行选择
    - restoreNode：存储和恢复到节点的输入


通常使用 s(trigger:string, nodes:table) 形式的函数创建代码片段。

> 给定文件类型的代码片断必须通过 ls.add_snippets(filetype, snippets) 添加进 LuaSnip。
> 应可全局访问（针对所有文件类型）的片段必须添加到特殊文件类型 all。



### 结点node 
每个节点都接受一个可选的参数列表作为它的最后一个参数。


### 片段

***s***








### textNode


只是文本

```lua
s("trigger", { t("Wow! Text!") })

Wow! Text!⎵
```


### insertNode

包含可编辑的文本，并且可以跳进和跳出(占位符)

```lua
s("trigger", {
    t({"After expanding, the cursor is here ->"}), i(1),
    t({"", "After jumping forward once, cursor is here ->"}), i(2),
    t({"", "After jumping once more, the snippet is exited there ->"}), i(0),
})
```

- 展开后，光标位于 InstertNode 1
- 跳跃后，将位于 InsertNode 2
- 再次跳跃后，将位于 InsertNode 0

> 如果在片段中未找到第 0 个 InsertNode，则会在所有其他节点之后自动插入一个。


```lua
--可以在 InsertNode 中包含初始文本
s("trigger", i(1, "This text is SELECTed after expanding the snippet."))
```



### function_node

根据其他节点的内容，使用自定义的函数来插入文本


```lua
local ls = require("luasnip")

ls.snippet("name", {
    -- 其他节点...
    ls.function_node(function(args)
        return "动态生成的内容: " .. args[1][1]
    end, {1})  -- 这里的 {1} 是要传递给函数的参数
})
```









### postfix

用于在现有文本的后缀上触发代码片段,它允许你根据前面的文本生成片段

```lua
--将 .br 前面的文本使用方括号 [] 括起来
postfix(".print", {
    -- 这个 function 会在你输入触发符后执行
    f(function(_, parent)
        -- parent.snippet.env.POSTFIX_MATCH 捕获的前面的文本
        return "print(" .. parent.snippet.env.POSTFIX_MATCH .. ")"
    end)
}),


    --或不进行处理之间替换
postfix(".log", "print(${1:message})"),

```




### choiceNode

ChoiceNode 允许在多个节点之间进行选择。


```lua
ls.snippet("choice", {
  -- 正常文本节点
  ls.text_node("Choose: "),
  -- 选择节点，两个选项
  ls.choice_node(id, {
    ls.text_node("Option 1"),
    ls.text_node("Option 2"),
    ls.text_node("Option 3")
  }),
}),
```

- ls.choice_node(1, { ... })：表示这是第一个选择节点，里面的参数是不同的选项。



